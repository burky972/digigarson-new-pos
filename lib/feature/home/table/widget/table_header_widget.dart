import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
import 'package:a_pos_flutter/feature/home/branch/cubit/branch_state.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/widget/timer_widget.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/cubit/global_cubit.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/service/global_service.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/routes/route_constants.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'top_rich_text_widget.dart';

class TableHeaderWidget extends StatefulWidget {
  const TableHeaderWidget({super.key});

  @override
  State<TableHeaderWidget> createState() => _TableHeaderWidgetState();
}

class _TableHeaderWidgetState extends State<TableHeaderWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.dynamicWidth(.6),
          child: Row(
            children: [
              /// Logged && Ordered time widger
              SizedBox(
                width: context.dynamicWidth(.2),
                child: Column(
                  children: [
                    _TopRichTextWidget(
                        leftText: 'Logged',
                        rightText: '${GlobalService.user.name} ${GlobalService.user.lastName}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Duration: ',
                            style: CustomFontStyle.titlesTextStyle
                                .copyWith(color: context.colorScheme.tertiary)),
                        BlocSelector<TableCubit, TableState, DateTime?>(
                          selector: (state) => state.tableModel.isNotEmpty
                              ? state.selectedTable?.lastOrderDate
                              : DateTime(0),
                          builder: (context, lastOrderTime) {
                            return lastOrderTime != null
                                ? TimerWidget(
                                    lastOrderTime: lastOrderTime,
                                    color: Colors.red,
                                  )
                                : const SizedBox();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Waiter && Customer Text
              SizedBox(
                width: context.dynamicWidth(.2),
                child: Column(
                  children: [
                    _TopRichTextWidget(leftText: 'Waiter', rightText: '${GlobalService.user.name}'),
                    const _TopRichTextWidget(leftText: 'Customer', rightText: ''),
                  ],
                ),
              ),
              SizedBox(
                width: context.dynamicWidth(.2),
                child: Column(
                  children: [
                    _TopRichTextWidget(
                        leftText: 'Seat ',
                        rightText: context.read<GlobalCubit>().selectedTableName),
                    _TopRichTextWidget(
                        leftText: 'Guests',
                        rightText:
                            '${context.read<TableCubit>().state.selectedTable?.customerCount ?? 0}'),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// SEARCH TEXTFIELD
        SizedBox(
            width: context.dynamicWidth(.3),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              BlocBuilder<BranchCubit, BranchState>(
                  builder: ((context, state) => Container(
                        padding: const AppPadding.extraMinAll(),
                        width: context.dynamicWidth(.14),
                        constraints: const BoxConstraints(
                            minWidth: 100, maxWidth: 120, minHeight: 30, maxHeight: 65),
                        child: CustomSearchTextfield(
                          isSuffixIcon: state.filter.isNotEmpty,
                          searchController: _searchController,
                          onClearClicked: () {
                            _searchController.clear();
                            context.read<BranchCubit>().setFilter('');
                          },
                          onChanged: (text) => context.read<BranchCubit>().setFilter(text),
                        ),
                      ))),

              /// Customer Info Button
              const LightBlueButton(buttonText: 'Customer Info'),

              /// Exit Button
              LightBlueButton(
                buttonText: 'Exit',
                onTap: () {
                  context.read<BranchCubit>().setCategorySelected(null);
                  context.read<BranchCubit>().setSubCategorySelected(null);
                  context.read<BranchCubit>().setMainCategorySelected(null);
                  context.read<BranchCubit>().setFilter('');
                  context.read<TableCubit>().clearNewOrderProducts();
                  context.read<TableCubit>().setIsQuickService(false);
                  context.read<TableCubit>().setSelectedEditProduct(null);
                  context.read<TableCubit>().getTable();
                  routeManager.replace(RouteConstants.main);
                },
              ),
            ]))
      ],
    );
  }
}
