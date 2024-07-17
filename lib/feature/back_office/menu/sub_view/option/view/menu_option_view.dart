import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_border_all_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

part '../widget/bottom_button_fields.dart';
part '../mixin/option_view_mixin.dart';

class MenuOptionsView extends StatefulWidget {
  const MenuOptionsView({
    super.key,
  });

  @override
  State<MenuOptionsView> createState() => _MenuOptionsViewState();
}

class _MenuOptionsViewState extends State<MenuOptionsView>
    with _OptionMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const AppPadding.largeAll(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
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
                      onTap: () {
                        setSelectedOptionData(index);
                        onGroupTapped(index);
                      },
                      child: Container(
                        color: index == selectedGroupIndex ? context.colorScheme.tertiary : null,
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
          SizedBox(width: context.dynamicWidth(0.005)),
          SizedBox(
            width: context.dynamicWidth(0.7),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FixedColumnWidth(80.0),
                          3: FixedColumnWidth(80.0),
                          4: FixedColumnWidth(80.0),
                          5: FixedColumnWidth(80.0),
                          6: FixedColumnWidth(80.0),
                          7: FixedColumnWidth(80.0),
                          8: FixedColumnWidth(80.0),
                          9: FixedColumnWidth(80.0),
                        },
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          const TableRow(
                            decoration: BoxDecoration(color: Colors.grey),
                            children: [
                              TableCell(
                                child: Center(
                                    child: Text('Option Name',
                                        style: TextStyle(fontWeight: FontWeight.bold))),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text('Description',
                                        style: TextStyle(fontWeight: FontWeight.bold))),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text('Price',
                                        style: TextStyle(fontWeight: FontWeight.bold))),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text('L Price',
                                        style: TextStyle(fontWeight: FontWeight.bold))),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text('H Price',
                                        style: TextStyle(fontWeight: FontWeight.bold))),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text('D Price',
                                        style: TextStyle(fontWeight: FontWeight.bold))),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text('T Price',
                                        style: TextStyle(fontWeight: FontWeight.bold))),
                              ),
                              TableCell(
                                child: Center(
                                    child:
                                        Text('Tax', style: TextStyle(fontWeight: FontWeight.bold))),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text('BarTax',
                                        style: TextStyle(fontWeight: FontWeight.bold))),
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
                                  text: row['optionName']!.toString(),
                                ),
                                _TableCellTextWidget(
                                  onTap: () => onRowTap(index),
                                  text: row['optionDescription']!.toString(),
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
                const Spacer(),

                Expanded(
                    flex: 2,
                    // height: context.dynamicHeight(0.2),
                    child: Column(
                      children: [
                        // const SizedBox(height: 10),
                        Expanded(
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
                                                    controller: _optionNameController,
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
                                                    controller: _optionNameController,
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
                                                    controller: _descriptionController,
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
                                                    controller: _priceController,
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
                                                    controller: _lunchPriceController,
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
                                                      controller: _happyHourController,
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
                                                      controller: _deliveryPriceController,
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
                                                      controller: _takeOutPriceController,
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
                                                            if (value != null) {
                                                              setState(() {
                                                                onTaxCheckboxChanged(
                                                                    'percentTax', value);
                                                              });
                                                            }
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
                                                      controller: _taxController,
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
                                                  selectedColor = null;
                                                });
                                              },
                                              child: Container(
                                                width: context.dynamicHeight(0.1),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey)),
                                                child: selectedColor != null
                                                    ? ColoredBox(color: selectedColor!)
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
                                                      debugPrint(selectedColor.toString());
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
                                                                    selectedColor = value;
                                                                    debugPrint(
                                                                        selectedColor.toString());
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
                    )),

                /// Bottom buttons
                const Expanded(
                  flex: 1,
                  // height: context.dynamicHeight(0.2),
                  child: _BottomButtonFields(),
                ),
              ],
            ),
          ),
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
