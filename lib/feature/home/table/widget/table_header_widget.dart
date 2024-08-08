import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
import 'package:a_pos_flutter/feature/home/branch/cubit/branch_state.dart';
import 'package:a_pos_flutter/feature/home/main/view/main_view.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/widget/timer_widget.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/cubit/global_cubit.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
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
                    BlocSelector<TableCubit, TableState, DateTime?>(
                      //TODO: ADD HERE LATER ->!
                      //TODO: CHECK HERE LATER WILL BE INDEX INSTEAD OF .FIRST!!
                      selector: (state) {
                        return null;

                        // return state.tableModel.first.lastOrderDate;
                      },
                      builder: (context, lastOrderTime) {
                        return lastOrderTime != null
                            ? TimerWidget(lastOrderTime: lastOrderTime)
                            : const SizedBox();
                      },
                    ),
                    _TopRichTextWidget(
                        leftText: 'Logged',
                        rightText:
                            '${context.read<GlobalCubit>().user.user?.name} ${context.read<GlobalCubit>().user.user?.lastName}'),
                  ],
                ),
              ),

              /// Waiter && Customer Text
              SizedBox(
                width: context.dynamicWidth(.2),
                child: Column(
                  children: [
                    _TopRichTextWidget(
                        leftText: 'Waiter',
                        rightText: '${context.read<GlobalCubit>().user.user?.name}'),
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
                    const _TopRichTextWidget(leftText: 'Guests', rightText: ''),
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
              InkWell(onTap: () {}, child: const LightBlueButton(buttonText: 'Customer Info')),

              /// Exit Button
              InkWell(
                  onTap: () {
                    context.read<BranchCubit>().setCategorySelected(null);
                    context.read<BranchCubit>().setSubCategorySelected(null);
                    context.read<BranchCubit>().setMainCategorySelected(null);
                    context.read<BranchCubit>().setFilter('');
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (_) => const MainView()), (route) => false);
                  },
                  child: const LightBlueButton(buttonText: 'Exit')),
            ]))
      ],
    );
  }
}
