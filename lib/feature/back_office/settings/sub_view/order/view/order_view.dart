import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/order/view/widget/lunch_happy_hour_view.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/order/view/widget/order_font_printer_view.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

String? selectedValue;
String? selectedValue2;
String? selectedValue3;
String? selectedValue4;
String? selectedValue5;
String? selectedValue6;
List<String> list = <String>[
  'HOT',
  'TEST',
  'KITCHEN',
  'Receipt',
];

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      const Flexible(
                          flex: 2, child: Text('Mirror Order Printer1')),
                      const SizedBox(width: 16),
                      Flexible(
                        flex: 2,
                        child: DropdownButton<String>(
                          hint: const Text(''),
                          value: selectedValue,
                          isExpanded: true,
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
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
                      const SizedBox(width: 8),
                      const Flexible(
                          flex: 2, child: Text('Mirror Order Printer2')),
                      const SizedBox(width: 16),
                      Flexible(
                        flex: 2,
                        child: DropdownButton<String>(
                          hint: const Text(''),
                          value: selectedValue2,
                          isExpanded: true,
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
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
                Flexible(
                  child: Row(
                    children: [
                      const Flexible(
                          flex: 2, child: Text('Default Special Item Printer')),
                      const SizedBox(width: 16),
                      Flexible(
                        flex: 2,
                        child: DropdownButton<String>(
                          hint: const Text(''),
                          value: selectedValue3,
                          isExpanded: true,
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
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
                      const SizedBox(width: 8),
                      Flexible(
                        flex: 2,
                        child: DropdownButton<String>(
                          hint: const Text(''),
                          value: selectedValue4,
                          isExpanded: true,
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue4 = newValue;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        flex: 2,
                        child: DropdownButton<String>(
                          hint: const Text(''),
                          value: selectedValue5,
                          isExpanded: true,
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue5 = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Row(
                    children: [
                      const Flexible(
                          flex: 2, child: Text('BackUp Kitchen Printer')),
                      const SizedBox(width: 16),
                      Flexible(
                        flex: 1,
                        child: DropdownButton<String>(
                          hint: const Text(''),
                          value: selectedValue6,
                          isExpanded: true,
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue6 = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Row(
                    children: [
                      const Flexible(
                          flex: 2,
                          child: Text('Printer Order Ahead Of Pick-Up')),
                      const Expanded(flex: 1, child: TextField()),
                      const Flexible(
                        flex: 2,
                        child: Text(
                          '(Minutes)',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 8),
                      const Text('Enable Open Tab for Bar'),
                      const SizedBox(width: 8),
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 8),
                      const Text('Print Hold/Fire Symbol'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Flexible(
                  child: Row(
                    children: [
                      Flexible(flex: 3, child: Text('Print')),
                      Flexible(child: TextField()),
                      Flexible(
                        flex: 3,
                        child: Text(
                          'Empty Lines At The Top of The Order',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 8),
                      const Text('Order Seat By Seat'),
                      const SizedBox(width: 8),
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 8),
                      const Text(
                          'Print Price For Special Item or special Edition'),
                      const SizedBox(width: 8),
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 8),
                      const Text('Print void items in order'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 8),
                      const Text('Show Option Group In Order'),
                      const SizedBox(width: 8),
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 8),
                      const Text('Print Line To Seperate Each Group'),
                      const SizedBox(width: 8),
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 8),
                      const Text('Use barcode scanner'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Flexible(
            flex: 2,
            child: LunchHappyHourView(),
          ),
          const SizedBox(height: 10),
          const Flexible(
            flex: 3,
            child: OrderFontPrinterView(),
          ),
          const Flexible(
            child: _BottomButtonFields(),
          ),
        ],
      ),
    );
  }
}

class _BottomButtonFields extends StatelessWidget {
  const _BottomButtonFields();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: context.dynamicWidth(0.1)),
        LightBlueButton(
            buttonText: 'Save',
            onTap: () async =>
                await context.read<CategoryCubit>().saveChanges()),
        LightBlueButton(
          buttonText: 'Exit',
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Future<void> patchCategory(BuildContext context) async {
    CategoryCubit categoryCubit = context.read<CategoryCubit>();

    final bool isSuccess = await categoryCubit.patchCategories(
        categoryId: categoryCubit.selectedCategory!.id!);

    if (!isSuccess) {
      await showOrderErrorDialog('${categoryCubit.state.exception?.message}!');
      await categoryCubit.getCategories();
    } else {
      await categoryCubit
          .patchCategories(
              categoryId: categoryCubit.state.selectedCategory!.id!)
          .whenComplete(() => categoryCubit.getCategories());
    }
  }
}
