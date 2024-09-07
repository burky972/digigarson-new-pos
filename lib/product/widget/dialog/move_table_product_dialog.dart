import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_state.dart';
import 'package:a_pos_flutter/feature/home/order/cubit/order_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/enums/button_action/button_action_enum.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/service/response_action_service.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoveTableProductDialog extends StatelessWidget {
  const MoveTableProductDialog({super.key, required this.isTransfer});
  final bool isTransfer; // if is transfer true move table else move product

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: context.height,
        width: context.dynamicWidth(0.75),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top option title
            Container(
              padding: const AppPadding.lowHorizontal(),
              child: Text(
                isTransfer ? 'Move Table' : 'Move Product',
                style: CustomFontStyle.formsTextStyle,
              ),
            ),

            /// Option items, option groups table
            const Padding(
              padding: AppPadding.minAll(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [SizedBox(height: 16), SectionWidget()],
              ),
            ),
            const Spacer(),

            /// bottom button fields
            _MoveTableButtons(isTransfer: isTransfer)
          ],
        ),
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  const SectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionCubit, SectionState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _BoldTitleText(text: 'Sections'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.originalSections?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => context
                        .read<SectionCubit>()
                        .setSelectedSection(sectionModel: state.originalSections![index]),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(right: 8),
                      color: state.selectedSection == state.originalSections![index]
                          ? context.colorScheme.tertiary
                          : Colors.grey[300],
                      child: Center(child: Text(state.originalSections?[index].title ?? '')),
                    ),
                  );
                },
              ),
            ),
            BlocBuilder<SectionCubit, SectionState>(
              // buildWhen: (previous, current) =>
              //     previous.selectedSection?.id != current.selectedSection?.id,
              builder: (context, state) {
                return SizedBox(
                  height: 500,
                  child: AvailableTablesWidget(
                    sectionId: state.selectedSection!.id!,
                  ),
                );
              },
            ),
            BlocSelector<TableCubit, TableState, String>(
              selector: (state) {
                return state.selectedTable?.title ?? '';
              },
              builder: (context, tableTitle) {
                return _BoldTitleText(text: 'Table/Seat No: $tableTitle');
              },
            ),
          ],
        );
      },
    );
  }
}

class AvailableTablesWidget extends StatelessWidget {
  const AvailableTablesWidget({super.key, required this.sectionId});
  final String sectionId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const _BoldTitleText(text: 'Available Tables'),
        const SizedBox(height: 8),
        Expanded(
          child: BlocBuilder<TableCubit, TableState>(
            builder: (context, state) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: state.tablesBySectionList![sectionId]?.length ?? 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => context
                        .read<TableCubit>()
                        .setSelectedTable(state.tablesBySectionList![sectionId]![index]),
                    child: Container(
                      color:
                          state.selectedMoveTable == state.tablesBySectionList![sectionId]?[index]
                              ? context.colorScheme.primary
                              : state.selectedTable == state.tablesBySectionList![sectionId]?[index]
                                  ? context.colorScheme.tertiary
                                  : Colors.grey[300],
                      child: Center(
                          child: Text(state.tablesBySectionList![sectionId]?[index].title ?? '')),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _BoldTitleText extends StatelessWidget {
  const _BoldTitleText({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: CustomFontStyle.titlesTextStyle
          .copyWith(fontSize: 24, color: context.colorScheme.tertiary),
    );
  }
}

/// Move Table Buttons(OK, Cancel)
class _MoveTableButtons extends StatelessWidget {
  const _MoveTableButtons({required this.isTransfer});
  final bool isTransfer;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableCubit, TableState>(
      builder: (context, state) {
        OrderCubit orderCubit = context.read<OrderCubit>();
        TableCubit tableCubit = context.read<TableCubit>();
        return Padding(
          padding: const AppPadding.minAll(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: state.selectedMoveTable == state.selectedTable
                      ? null
                      : () async {
                          if (isTransfer) {
                            await _transferTable(orderCubit, state, tableCubit, context);
                          } else {
                            await _moveProduct(orderCubit, state, tableCubit, context);
                          }
                        },
                  child: const LightBlueButton(buttonText: 'OK')),
              InkWell(
                  child: LightBlueButton(
                buttonText: 'Cancel',
                onTap: () => Navigator.pop(context),
              )),
            ],
          ),
        );
      },
    );
  }

  /// Move Product Function
  Future<void> _moveProduct(
      OrderCubit orderCubit, TableState state, TableCubit tableCubit, BuildContext context) async {
    final response = await orderCubit.moveProducts(
        tableId: state.selectedMoveTable!.id!,
        targetTableId: state.selectedTable!.id!,
        moveProduct: MoveProduct(orderIds: [state.newOrderProduct!.id!]));
    await ResponseActionService.getTableAndNavigate(
      context: context,
      response: response,
      tableCubit: tableCubit,
      action: ButtonAction.moveProduct,
    );
  }

  /// Transfer Table Function
  Future<void> _transferTable(
      OrderCubit orderCubit, TableState state, TableCubit tableCubit, BuildContext context) async {
    final response = await orderCubit.transferTable(
        tableId: state.selectedMoveTable!.id!,
        targetTableId: state.selectedTable!.id!,
        moveTable: MoveProduct(
            orderIds: state.selectedMoveTable!.orders.first.products
                .map((e) => e!.id.toString())
                .toList()));
    await ResponseActionService.getTableAndNavigate(
      context: context,
      response: response,
      tableCubit: tableCubit,
      action: ButtonAction.moveTable,
    );
  }
}
