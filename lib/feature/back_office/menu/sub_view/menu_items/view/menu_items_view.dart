import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_border_all_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
part '../widget/bottom_button_fields.dart';

class MenuItemsView extends StatefulWidget {
  const MenuItemsView({super.key});

  @override
  State<MenuItemsView> createState() => _MenuItemsViewState();
}

class _MenuItemsViewState extends State<MenuItemsView> with _MenuItemsMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const AppPadding.minAll(),
      child: Column(
        children: [
          SizedBox(
            height: context.dynamicHeight(0.8),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  width: context.dynamicWidth(0.2),
                  // height: context.dynamicHeight(0.85),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      const Text(
                        'Group Name',
                        style: CustomFontStyle.titlesTextStyle,
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: List.generate(40, (int index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              // color: index == selectedGroupIndex ? context.colorScheme.tertiary : null,
                              child: Column(
                                children: [
                                  Text('data $index'),
                                  const Divider(),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: context.dynamicHeight(0.52),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //! Middle Table Widget !!
                              Container(
                                width: context.dynamicWidth(0.4),
                                height: context.dynamicHeight(0.5),
                                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                child: Scrollbar(
                                  controller: scrollController,
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    scrollDirection: Axis.horizontal,
                                    child: SingleChildScrollView(
                                      controller: horizontalController,
                                      child: SizedBox(
                                        width: context.dynamicWidth(0.4),
                                        child: Table(
                                          border: TableBorder.all(),
                                          columnWidths: const <int, TableColumnWidth>{
                                            0: FlexColumnWidth(80.0),
                                            1: FixedColumnWidth(70.0),
                                            2: FixedColumnWidth(70.0),
                                            3: FixedColumnWidth(70.0),
                                            4: FixedColumnWidth(70.0),
                                            5: FixedColumnWidth(70.0),
                                            6: FixedColumnWidth(70.0),
                                            7: FixedColumnWidth(70.0),
                                            8: FixedColumnWidth(70.0),
                                          },
                                          children: [
                                            const TableRow(
                                              decoration: BoxDecoration(color: Colors.grey),
                                              children: [
                                                TableCell(
                                                  child: Center(
                                                      child: Text('Option Name',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold))),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                      child: Text('Price',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold))),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                      child: Text('L Price',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold))),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                      child: Text('H Price',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold))),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                      child: Text('D Price',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold))),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                      child: Text('T Price',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold))),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                      child: Text('Tax',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold))),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                      child: Text('BarTax',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold))),
                                                ),
                                              ],
                                            ),
                                            ...selectedOptionData.asMap().entries.map((entry) {
                                              int index = entry.key;
                                              Map<String, dynamic> row = entry.value;
                                              return TableRow(
                                                decoration: BoxDecoration(
                                                  color: index == selectedOptionIndex
                                                      ? context.colorScheme.tertiary
                                                      : null,
                                                ),
                                                children: [
                                                  _TableCellTextWidget(
                                                    onTap: () => onRowTap(index),
                                                    text: row['itemName']!.toString(),
                                                  ),
                                                  _TableCellTextWidget(
                                                    onTap: () => onRowTap(index),
                                                    text: row['price']!.toString(),
                                                  ),
                                                  _TableCellTextWidget(
                                                    onTap: () => onRowTap(index),
                                                    text: row['lPrice']!.toString(),
                                                  ),
                                                  _TableCellTextWidget(
                                                    onTap: () => onRowTap(index),
                                                    text: row['hPrice']!.toString(),
                                                  ),
                                                  _TableCellTextWidget(
                                                    onTap: () => onRowTap(index),
                                                    text: row['dPrice']!.toString(),
                                                  ),
                                                  _TableCellTextWidget(
                                                    onTap: () => onRowTap(index),
                                                    text: row['tPrice']!.toString(),
                                                  ),
                                                  _TableCellTextWidget(
                                                    onTap: () => onRowTap(index),
                                                    text: row['tax']!.toString(),
                                                  ),
                                                  _TableCellTextWidget(
                                                    onTap: () => onRowTap(index),
                                                    text: row['barTax']!.toString(),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //! right small Table Widget !!
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: context.dynamicWidth(0.3),
                                      height: context.dynamicHeight(0.4),
                                      decoration:
                                          BoxDecoration(border: Border.all(color: Colors.black)),
                                      child: Scrollbar(
                                        controller: smallTableScrollController,
                                        thumbVisibility: true,
                                        child: SingleChildScrollView(
                                          controller: smallTableScrollController,
                                          scrollDirection: Axis.horizontal,
                                          child: SingleChildScrollView(
                                            controller: smallTableHorizontalController,
                                            child: SizedBox(
                                              width: context.dynamicWidth(0.3),
                                              child: Table(
                                                border: TableBorder.all(),
                                                columnWidths: const <int, TableColumnWidth>{
                                                  0: FlexColumnWidth(30.0),
                                                  1: FixedColumnWidth(200.0),
                                                  2: FixedColumnWidth(200.0),
                                                },
                                                children: [
                                                  const TableRow(
                                                    decoration: BoxDecoration(color: Colors.grey),
                                                    children: [
                                                      TableCell(
                                                        child: Center(
                                                            child: Text('Select',
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold))),
                                                      ),
                                                      TableCell(
                                                        child: Center(
                                                            child: Text('Option Group',
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold))),
                                                      ),
                                                      TableCell(
                                                        child: Center(
                                                            child: Text('Maximum Options',
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold))),
                                                      ),
                                                    ],
                                                  ),
                                                  ...selectedSmallTableData
                                                      .asMap()
                                                      .entries
                                                      .map((entry) {
                                                    int index = entry.key;
                                                    Map<String, dynamic> row = entry.value;
                                                    return TableRow(
                                                      decoration: BoxDecoration(
                                                        color: index == selectedSmallTableIndex
                                                            ? context.colorScheme.tertiary
                                                            : null,
                                                      ),
                                                      children: [
                                                        TableCell(
                                                          child: Padding(
                                                            padding: const AppPadding.minAll(),
                                                            child: Checkbox(
                                                              value: row['select'],
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  row['select'] = value;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        _TableCellTextWidget(
                                                          onTap: () => onSmallTableTap(index),
                                                          text: row['optionGroup']!.toString(),
                                                        ),
                                                        _TableCellTextWidget(
                                                          onTap: () => onSmallTableTap(index),
                                                          text: row['maximumOptions']!.toString(),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// small table maximum option's textfield
                                    SizedBox(
                                      height: context.dynamicHeight(0.1),
                                      width: context.dynamicWidth(0.3),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Maximum options',
                                            style: CustomFontStyle.titlesTextStyle
                                                .copyWith(color: context.colorScheme.primary),
                                          ),
                                          SizedBox(
                                            width: context.dynamicWidth(0.01),
                                          ),
                                          Expanded(
                                              child: TextField(
                                            readOnly:
                                                !selectedSmallTableData[selectedSmallTableIndex!]
                                                    ['select'],
                                            controller: _textFieldController,
                                            style: CustomFontStyle.formsTextStyle
                                                .copyWith(fontSize: context.dynamicWidth(0.01)),
                                            onChanged: (value) {
                                              if (selectedSmallTableIndex != null) {
                                                setState(() {
                                                  selectedSmallTableData[selectedSmallTableIndex!]
                                                          ['maximumOptions'] =
                                                      int.tryParse(value) ??
                                                          selectedSmallTableData[
                                                                  selectedSmallTableIndex!]
                                                              ['maximumOptions'];
                                                });
                                              }
                                            },
                                            decoration: InputDecoration(
                                                label: Text(selectedSmallTableData[0]
                                                        ['maximumOptions']
                                                    .toString()),
                                                hintText: '',
                                                contentPadding: const EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 12),
                                                border: const OutlineInputBorder(
                                                    borderSide: BorderSide(width: 2))),
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          // height: context.dynamicHeight(0.2),

                          // flex: 2,
                          // height: context.dynamicHeight(0.3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Option Details',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Flexible(
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                    flex: 1, child: Text('Option Group')),
                                                Expanded(
                                                  flex: 2,
                                                  child: CustomBorderAllTextfield(
                                                    //TODO: change controller later!1
                                                    // controller: _optionNameController,
                                                    controller: TextEditingController(),
                                                    onChanged: (value) {
                                                      if (selectedOptionIndex != null) {
                                                        setState(() {
                                                          selectedOptionData[selectedOptionIndex!]
                                                              ['optionName'] = value;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Row(
                                              children: [
                                                const Expanded(flex: 1, child: Text('Option Name')),
                                                Expanded(
                                                  flex: 2,
                                                  child: CustomBorderAllTextfield(
                                                    // controller: _optionNameController,
                                                    controller: TextEditingController(),
                                                    onChanged: (value) {
                                                      if (selectedOptionIndex != null) {
                                                        setState(() {
                                                          selectedOptionData[selectedOptionIndex!]
                                                              ['optionName'] = value;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Row(
                                              children: [
                                                const Expanded(flex: 1, child: Text('Description')),
                                                Expanded(
                                                  flex: 2,
                                                  child: CustomBorderAllTextfield(
                                                    // controller: _descriptionController,
                                                    controller: TextEditingController(),
                                                    onChanged: (value) {
                                                      if (selectedOptionIndex != null) {
                                                        setState(() {
                                                          selectedOptionData[selectedOptionIndex!]
                                                              ['optionDescription'] = value;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Row(
                                              children: [
                                                const Expanded(flex: 1, child: Text('Price')),
                                                Expanded(
                                                  flex: 2,
                                                  child: CustomBorderAllTextfield(
                                                    // controller: _priceController,
                                                    controller: TextEditingController(),
                                                    onChanged: (value) {
                                                      if (selectedOptionIndex != null) {
                                                        setState(() {
                                                          selectedOptionData[selectedOptionIndex!]
                                                              ['price'] = value;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Row(
                                              children: [
                                                const Expanded(flex: 1, child: Text('Lunch Price')),
                                                Expanded(
                                                  flex: 2,
                                                  child: CustomBorderAllTextfield(
                                                    // controller: _lunchPriceController,
                                                    controller: TextEditingController(),
                                                    onChanged: (value) {
                                                      if (selectedOptionIndex != null) {
                                                        setState(() {
                                                          selectedOptionData[selectedOptionIndex!]
                                                              ['lPrice'] = value;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Flexible(
                                              child: Row(
                                                children: [
                                                  const Expanded(
                                                      flex: 1, child: Text('HappyHour Price')),
                                                  Expanded(
                                                    flex: 2,
                                                    child: CustomBorderAllTextfield(
                                                      // controller: _happyHourController,
                                                      controller: TextEditingController(),
                                                      onChanged: (value) {
                                                        if (selectedOptionIndex != null) {
                                                          setState(() {
                                                            selectedOptionData[selectedOptionIndex!]
                                                                ['hPrice'] = value;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                              child: Row(
                                                children: [
                                                  const Expanded(
                                                      flex: 1, child: Text('Delivery Price')),
                                                  Expanded(
                                                    flex: 2,
                                                    child: CustomBorderAllTextfield(
                                                      // controller: _deliveryPriceController,
                                                      controller: TextEditingController(),
                                                      onChanged: (value) {
                                                        if (selectedOptionIndex != null) {
                                                          setState(() {
                                                            selectedOptionData[selectedOptionIndex!]
                                                                ['dPrice'] = value;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                              child: Row(
                                                children: [
                                                  const Expanded(
                                                      flex: 1, child: Text('TakeOut Price')),
                                                  Expanded(
                                                    flex: 2,
                                                    child: CustomBorderAllTextfield(
                                                      // controller: _takeOutPriceController,
                                                      controller: TextEditingController(),
                                                      onChanged: (value) {
                                                        if (selectedOptionIndex != null) {
                                                          setState(() {
                                                            selectedOptionData[selectedOptionIndex!]
                                                                ['tPrice'] = value;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      children: [
                                                        Checkbox(
                                                          value: (selectedOptionIndex ?? 0) >=
                                                                  selectedOptionData.length
                                                              ? selectedOptionData[0]['percentTax']
                                                              : selectedOptionData[
                                                                      selectedOptionIndex!]
                                                                  ['percentTax'],
                                                          onChanged: (value) {
                                                            // if (value != null) {
                                                            //   setState(() {
                                                            //     onTaxCheckboxChanged(
                                                            //         'percentTax', value);
                                                            //   });
                                                            // }
                                                          },
                                                        ),
                                                        const SizedBox(width: 3),
                                                        const Text('Tax% '),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: CustomBorderAllTextfield(
                                                      isReadOnly:
                                                          !selectedOptionData[selectedOptionIndex!]
                                                              ['percentTax'],
                                                      // controller: _taxController,
                                                      controller: TextEditingController(),

                                                      onChanged: (value) {
                                                        if (selectedOptionIndex != null) {
                                                          setState(() {
                                                            selectedOptionData[selectedOptionIndex!]
                                                                ['tax'] = value;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  // selectedColor = null;
                                                });
                                              },
                                              child: Container(
                                                width: context.dynamicHeight(0.1),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey)),
                                                child: selectedColor != null
                                                    ? ColoredBox(color: selectedColor)
                                                    : null,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      // debugPrint(selectedColor.toString());
                                                    },
                                                    child: const LightBlueButton(
                                                      buttonText: 'Browse',
                                                    )),
                                                InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: const Text('Bir renk seçin'),
                                                            content: SingleChildScrollView(
                                                              child: ColorPicker(
                                                                pickerColor: Colors.white,
                                                                onColorChanged: (value) {
                                                                  setState(() {
                                                                    // selectedColor = value;
                                                                    // debugPrint(selectedColor
                                                                    //     .toString());
                                                                  });
                                                                },
                                                                pickerAreaHeightPercent: 0.8,
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: const Text('Tamam'),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child:
                                                        const LightBlueButton(buttonText: 'Color')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          const _BottomButtonFields(),
        ],
      ),
    );
  }
}

class _TableCellTextWidget extends StatelessWidget {
  const _TableCellTextWidget({required this.onTap, required this.text});
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

mixin _MenuItemsMixin on State<MenuItemsView> {
  late List<Map<String, dynamic>> selectedOptionData;
  int? selectedOptionIndex = 0;
  int? selectedGroupIndex = 0;
  Color selectedColor = Colors.white;
  final ScrollController scrollController = ScrollController();
  final ScrollController horizontalController = ScrollController();
  final ScrollController smallTableScrollController = ScrollController();
  final ScrollController smallTableHorizontalController = ScrollController();

  @override
  void initState() {
    super.initState();
    selectedOptionData = groupedOptionData[0];
  }

  int? selectedSmallTableIndex = 0;
  final TextEditingController _textFieldController = TextEditingController();

  void onSmallTableTap(int index) {
    setState(() {
      selectedSmallTableIndex = index;
      _textFieldController.text =
          selectedSmallTableData[selectedSmallTableIndex!]['maximumOptions'].toString();
    });
  }

  void onRowTap(index) {
    setState(() {
      if (selectedOptionIndex == index) {
        return;
      } else {
        selectedOptionIndex = index;
      }
    });
  }

  final List<Map<String, dynamic>> selectedSmallTableData = [
    {
      'select': false,
      'optionGroup': 'Md Juice',
      'maximumOptions': 0,
    },
    {
      'select': false,
      'optionGroup': 'Md Juice',
      'maximumOptions': 0,
    },
    {
      'select': false,
      'optionGroup': 'Md Juice',
      'maximumOptions': 0,
    },
    {
      'select': false,
      'optionGroup': 'Md Juice',
      'maximumOptions': 0,
    },
    {
      'select': false,
      'optionGroup': 'Md Juice',
      'maximumOptions': 0,
    },
    {
      'select': false,
      'optionGroup': 'Md Juice',
      'maximumOptions': 0,
    },
    {
      'select': false,
      'optionGroup': 'Md Juice',
      'maximumOptions': 0,
    },
    {
      'select': false,
      'optionGroup': 'Md Juice',
      'maximumOptions': 0,
    },
    {
      'select': false,
      'optionGroup': 'Md Juice',
      'maximumOptions': 0,
    },
    {
      'select': false,
      'optionGroup': 'Md Juice',
      'maximumOptions': 0,
    },
    {
      'select': false,
      'optionGroup': 'Md Juice',
      'maximumOptions': 0,
    },
    {
      'select': false,
      'optionGroup': 'Md Juice',
      'maximumOptions': 0,
    },
    {
      'select': false,
      'optionGroup': 'Md Juice',
      'maximumOptions': 0,
    },
  ];

  final List<List<Map<String, dynamic>>> groupedOptionData = [
    [
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'New Item Cola',
        'price': 1.0,
        'lPrice': 1.0,
        'hPrice': 1.0,
        'dPrice': 1.0,
        'tPrice': 1.0,
        'tax': 1.0,
        'barTax': 1.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
      {
        'itemName': 'Md Juice',
        'price': 0.0,
        'lPrice': 0.0,
        'hPrice': 0.0,
        'dPrice': 0.0,
        'tPrice': 0.0,
        'tax': 0.0,
        'barTax': 0.0,
        'percentTax': false,
      },
    ]
  ];
}
