import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  String? selectedOrder1;
  String? selectedOrder2;
  String? selectedReceipt1;
  String? selectedReceipt2;
  String? selectedKitchen1;
  String? selectedKitchen2;
  String? selectedDistributor1;
  String? selectedDistributor2;
  List<String> generalLanguage = <String>[
    'English(USA)',
    'TEST',
    'KITCHEN',
    'Receipt',
  ];
  List<String> itemLanguage = <String>[
    'The First Language',
    'TEST',
    'KITCHEN',
    'Receipt',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flexible(
              flex: 9,
              child: Column(
                children: [
                  Flexible(
                    flex: 4,
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(''),
                        ),
                        const Expanded(
                            flex: 2,
                            child: Text(
                              'General Language',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                        SizedBox(width: context.dynamicWidth(0.02)),
                        const Expanded(
                            flex: 3,
                            child: Text(
                              'Item Language',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: context.dynamicHeight(0.01)),
                  Flexible(
                    flex: 4,
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Text(
                              'Order',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                        Expanded(
                          flex: 2,
                          child: DropdownButton<String>(
                            hint: const Text(''),
                            value: selectedOrder1,
                            isExpanded: true,
                            items: generalLanguage
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedOrder1 = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: context.dynamicWidth(0.02)),
                        Expanded(
                          flex: 3,
                          child: DropdownButton<String>(
                            hint: const Text(''),
                            value: selectedOrder2,
                            isExpanded: true,
                            items: itemLanguage
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedOrder2 = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Text(
                              'Receipt',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                        Expanded(
                          flex: 2,
                          child: DropdownButton<String>(
                            hint: const Text(''),
                            value: selectedReceipt1,
                            isExpanded: true,
                            items: generalLanguage
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedReceipt1 = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: context.dynamicWidth(0.02)),
                        Expanded(
                          flex: 3,
                          child: DropdownButton<String>(
                            hint: const Text(''),
                            value: selectedReceipt2,
                            isExpanded: true,
                            items: itemLanguage
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedReceipt2 = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Text(
                              'Kitchen Monitor',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                        Expanded(
                          flex: 2,
                          child: DropdownButton<String>(
                            hint: const Text(''),
                            value: selectedKitchen1,
                            isExpanded: true,
                            items: generalLanguage
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedKitchen1 = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: context.dynamicWidth(0.02)),
                        Expanded(
                          flex: 3,
                          child: DropdownButton<String>(
                            hint: const Text(''),
                            value: selectedKitchen2,
                            isExpanded: true,
                            items: itemLanguage
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedKitchen2 = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Text(
                              'Distributor',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                        Expanded(
                          flex: 2,
                          child: DropdownButton<String>(
                            hint: const Text(''),
                            value: selectedDistributor1,
                            isExpanded: true,
                            items: generalLanguage
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDistributor1 = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: context.dynamicWidth(0.02)),
                        Expanded(
                          flex: 3,
                          child: DropdownButton<String>(
                            hint: const Text(''),
                            value: selectedDistributor2,
                            isExpanded: true,
                            items: itemLanguage
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDistributor2 = newValue;
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
            const Flexible(
              flex: 2,
              child: _BottomButtonFields(),
            ),
          ],
        ));
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
