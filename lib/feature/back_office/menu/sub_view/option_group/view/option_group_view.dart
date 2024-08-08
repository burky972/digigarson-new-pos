import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/cubit/option_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/cubit/option_state.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_border_all_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part '../widget/bottom_buttons_field.dart';

class OptionGroupsView extends StatefulWidget {
  const OptionGroupsView({super.key});

  @override
  State<OptionGroupsView> createState() => _OptionGroupsViewState();
}

class _OptionGroupsViewState extends State<OptionGroupsView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<OptionCubit, OptionState>(
      builder: (context, state) {
        final optionCubit = context.read<OptionCubit>();
        return Column(
          children: [
            /// Option Group Table Widget
            Container(
              height: context.dynamicHeight(0.5),
              decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(color: Colors.grey),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: AppPadding.minAll(),
                            child: Center(
                                child: Text('Group Name', style: CustomFontStyle.titlesTextStyle)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('Description', style: CustomFontStyle.titlesTextStyle)),
                        ),
                      ],
                    ),
                    ...state.allOptions.asMap().entries.map((entry) {
                      OptionModel option = entry.value ?? OptionModel.empty();
                      return TableRow(
                        decoration: BoxDecoration(
                          color:
                              option == state.selectedOption ? context.colorScheme.tertiary : null,
                        ),
                        children: [
                          _TableCellText(
                            onTap: () => optionCubit.setSelectedOption(option),
                            text: option.name.toString(),
                          ),
                          _TableCellText(
                            onTap: () => optionCubit.setSelectedOption(option),
                            text: option.specialName.toString(),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Text(
                        'OptionGroup Details',
                        style: CustomFontStyle.titlesTextStyle,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    const Expanded(flex: 1, child: Text('Group Name')),
                                    Expanded(
                                        flex: 2,
                                        child: CustomBorderAllTextfield(
                                          controller: optionCubit.optionNameController,
                                          onChanged: (value) => optionCubit
                                              .updateOptionNameOrDesc(value, isName: true),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(height: context.dynamicHeight(0.002)),
                              Flexible(
                                child: Row(
                                  children: [
                                    const Expanded(flex: 1, child: Text('Group Description')),
                                    Expanded(
                                        flex: 2,
                                        child: CustomBorderAllTextfield(
                                          controller: optionCubit.optionDescController,
                                          onChanged: (value) =>
                                              optionCubit.updateOptionNameOrDesc(value),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: context.dynamicHeight(0.2),
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {},
                                        child: const LightBlueButton(
                                          buttonText: 'Browse',
                                        )),
                                    InkWell(
                                        onTap: () {},
                                        child: const LightBlueButton(buttonText: 'Color')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            /// Bottom buttons
            SizedBox(height: context.dynamicHeight(0.2), child: const _BottomButtonFields()),
          ],
        );
      },
    );
  }
}

class _TableCellText extends StatelessWidget {
  const _TableCellText({required this.onTap, required this.text});
  final VoidCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const AppPadding.minAll(),
          child: Center(
            child: Text(
              text,
              style: CustomFontStyle.menuTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
