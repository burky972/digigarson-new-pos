import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
import 'package:a_pos_flutter/feature/home/branch/cubit/branch_state.dart';
import 'package:a_pos_flutter/feature/home/main/view/main_view.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/cubit/global_cubit.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_search_textfield.dart';
import 'package:a_pos_flutter/product/widget/timer/current_time_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              /// Timer && name/surname Text
              SizedBox(
                width: context.dynamicWidth(.2),
                child: Column(
                  children: [
                    const CurrentTimeWidget(),
                    SizedBox(
                      height: 30,
                      child: Text(
                          '${context.read<GlobalCubit>().user.user?.name} ${context.read<GlobalCubit>().user.user?.lastName}',
                          style: const TextStyle(fontSize: 16, color: Colors.indigo)),
                    )
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
                    _TopRichTextWidget(leftText: LocaleKeys.Table.tr(), rightText: ''),
                    // SizedBox(
                    // height: 30,
                    //TODO! CREATE TABLE LIST CUBIT !!!!
                    // child: Text('${LocaleKeys.Table.tr()}: X  ',
                    //     style: const TextStyle(fontSize: 16, color: Colors.indigo)),
                    // child: Text(
                    //     '${getTranslated("Table", context)}: ${Provider.of<MyBranchProvider>(context, listen: false).myBranch!.sections.where((element) => element.sId == Provider.of<TableListProvider>(context, listen: false).selectedTable_!.section).first.title} ${Provider.of<TableListProvider>(context, listen: false).selectedTable_!.title}',
                    //     style: const TextStyle(fontSize: 16, color: Colors.indigo)),
                    // ),
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

class _TopRichTextWidget extends StatelessWidget {
  const _TopRichTextWidget({required this.leftText, required this.rightText});
  final String leftText;
  final String rightText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: '$leftText:',
                style:
                    CustomFontStyle.titlesTextStyle.copyWith(color: context.colorScheme.tertiary)),
            TextSpan(
                text: rightText,
                style: CustomFontStyle.popupNotificationTextStyle
                    .copyWith(color: context.colorScheme.primary)),
          ]),
        ));
  }
}
