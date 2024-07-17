import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_border_all_textfield.dart';
import 'package:flutter/material.dart';
part '../mixin/option_group_mixin.dart';
part '../widget/bottom_buttons_field.dart';

class OptionGroupsView extends StatefulWidget {
  const OptionGroupsView({super.key});

  @override
  State<OptionGroupsView> createState() => _OptionGroupsViewState();
}

class _OptionGroupsViewState extends State<OptionGroupsView>
    with _OptionGroupsMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        Container(
          height: context.dynamicHeight(0.5),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
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
                ...selectedOptionData.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> row = entry.value;
                  return TableRow(
                    decoration: BoxDecoration(
                      color: index == selectedOptionIndex ? context.colorScheme.tertiary : null,
                    ),
                    children: [
                      _TableCellText(
                        onTap: () => onSelectedTapped(index),
                        text: row['groupName']!.toString(),
                      ),
                      _TableCellText(
                        onTap: () => onSelectedTapped(index),
                        text: row['groupDescription']!.toString(),
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
                                      controller: _groupNameController,
                                      onChanged: (value) {
                                        if (selectedOptionIndex != null) {
                                          setState(() {
                                            selectedOptionData[selectedOptionIndex!]['groupName'] =
                                                value;
                                          });
                                        }
                                      },
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
                                      controller: _groupDescController,
                                      onChanged: (value) {
                                        if (selectedOptionIndex != null) {
                                          setState(() {
                                            selectedOptionData[selectedOptionIndex!]
                                                ['groupDescription'] = value;
                                          });
                                        }
                                      },
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
