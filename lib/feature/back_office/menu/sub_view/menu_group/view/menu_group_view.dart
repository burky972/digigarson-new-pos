import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:flutter/material.dart';

part '../widget/_table_widget.dart';
part '../widget/bottom_button_fields.dart';

class MenuGroupView extends StatefulWidget {
  const MenuGroupView({
    super.key,
    required this.data,
    required this.selectedRowIndex,
    required this.onRowTap,
    required this.onCheckboxChanged,
  });

  final List<Map<String, dynamic>> data;
  final int? selectedRowIndex;
  final Function(int) onRowTap;
  final Function(String, bool) onCheckboxChanged;

  @override
  State<MenuGroupView> createState() => _MenuGroupViewState();
}

String? selectedValue;
String? selectedValue2;
String? selectedValue3;
List<String> list = <String>['hot', 'cold', 'freeze'];

class _MenuGroupViewState extends State<MenuGroupView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Table Widget
        Container(
          height: context.dynamicHeight(0.5),
          width: context.dynamicWidth(0.8),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: ListView(
            children: [
              _TableWidget(widget: widget),
            ],
          ),
        ),
        SizedBox(
            height: context.dynamicHeight(0.35),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Middle title
                      Expanded(
                        flex: 1,
                        child: Text(
                          'MenuItemGroup Details',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),

                      ///Middle all items(textfield-checkbox-selectImage)
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  const Flexible(
                                    child: Row(
                                      children: [
                                        Expanded(flex: 2, child: Text('Group Name')),
                                        Expanded(flex: 3, child: TextField()),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Flexible(
                                    child: Row(
                                      children: [
                                        Expanded(flex: 2, child: Text('Group Description')),
                                        Expanded(flex: 3, child: TextField()),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  ///Printer1 dropdownButton
                                  Flexible(
                                    child: Row(
                                      children: [
                                        const Expanded(flex: 2, child: Text('Printer1')),
                                        Expanded(
                                          flex: 3,
                                          child: DropdownButton<String>(
                                            hint: const Text(''),
                                            value: selectedValue,
                                            isExpanded: true,
                                            items:
                                                list.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedValue = newValue;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  ///Printer2 dropdownButton
                                  Flexible(
                                    child: Row(
                                      children: [
                                        const Expanded(flex: 2, child: Text('Printer2')),
                                        Expanded(
                                          flex: 3,
                                          child: DropdownButton<String>(
                                            hint: const Text(''),
                                            value: selectedValue2,
                                            isExpanded: true,
                                            items:
                                                list.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedValue2 = newValue;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  ///Printer3 dropdownButton
                                  Flexible(
                                    child: Row(
                                      children: [
                                        const Expanded(flex: 2, child: Text('Printer3')),
                                        Expanded(
                                          flex: 3,
                                          child: DropdownButton<String>(
                                            hint: const Text(''),
                                            value: selectedValue3,
                                            isExpanded: true,
                                            items:
                                                list.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedValue3 = newValue;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 50),

                            ///In DineIn-TakeOut-Delivery-QuickService-Bar checkBox
                            Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.data[widget.selectedRowIndex!]['dinIn'],
                                            onChanged: (value) {
                                              if (value != null) {
                                                setState(() {
                                                  widget.onCheckboxChanged('dinIn', value);
                                                });
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('Dine In'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.data[widget.selectedRowIndex!]['takeOut'],
                                            onChanged: (value) {
                                              if (value != null) {
                                                setState(() {
                                                  widget.onCheckboxChanged('takeOut', value);
                                                });
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('Take Out'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.data[widget.selectedRowIndex!]
                                                ['delivery'],
                                            onChanged: (value) {
                                              if (value != null) {
                                                setState(() {
                                                  widget.onCheckboxChanged('delivery', value);
                                                });
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('Delivery'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.data[widget.selectedRowIndex!]
                                                ['quickService'],
                                            onChanged: (value) {
                                              if (value != null) {
                                                setState(() {
                                                  widget.onCheckboxChanged('quickService', value);
                                                });
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('Quick Service'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.data[widget.selectedRowIndex!]['bar'],
                                            onChanged: (value) {
                                              if (value != null) {
                                                setState(() {
                                                  widget.onCheckboxChanged('bar', value);
                                                });
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('Bar'),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),

                            ///Select image or color
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Container(
                                    height: context.dynamicHeight(0.1),
                                    width: context.dynamicHeight(0.1),
                                    decoration:
                                        BoxDecoration(border: Border.all(color: Colors.grey)),
                                  ),
                                  const SizedBox(height: 15),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap: () {},
                                            child: const LightBlueButton(
                                              buttonText: 'Browse',
                                            )),
                                        const SizedBox(width: 4),
                                        InkWell(
                                            onTap: () {},
                                            child: const LightBlueButton(buttonText: 'Clean')),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///In Kitchen Screen checkBox
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: widget.data[widget.selectedRowIndex!]['kitchenScreen'],
                                    onChanged: (value) {
                                      if (value != null) {
                                        widget.onCheckboxChanged('kitchenScreen', value);
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('In Kitchen Screen'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      ///Bottom buttons
                      const Expanded(
                        flex: 2,
                        child: _BottomButtonFields(),
                      ),
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
