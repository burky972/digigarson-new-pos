import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/others/view/widget/payment_stay.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/others/view/widget/print_receipt_stay.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/others/view/widget/send_close_stay.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OthersView extends StatefulWidget {
  const OthersView({super.key});

  @override
  State<OthersView> createState() => _OthersViewState();
}

bool isBackupEnabled = false;
String? selectedDefaultSection1;
List<String> list = <String>[
  'HOT',
  'TEST',
  'KITCHEN',
  'Receipt',
];

class _OthersViewState extends State<OthersView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Flexible(
          flex: 4,
          child: Column(
            children: [
              Flexible(
                  child: Row(children: [
                const Flexible(flex: 2, child: Text('Default Section')),
                const SizedBox(width: 16),
                Flexible(
                  flex: 2,
                  child: DropdownButton<String>(
                    hint: const Text(''),
                    value: selectedDefaultSection1,
                    isExpanded: true,
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDefaultSection1 = newValue;
                      });
                    },
                  ),
                ),
              ])),
              Flexible(
                  child: Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  const SizedBox(width: 8),
                  const Text('Auto Update When Start The Program'),
                ],
              )),
              Flexible(
                  child: Row(
                children: [
                  const Flexible(
                      flex: 10,
                      child: Text('Amounts(\$) For Every Membership Point')),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
        const Flexible(
          flex: 12,
          child: Row(
            children: [
              Flexible(
                child: SendCloseStay(),
              ),
              SizedBox(width: 8),
              Flexible(
                child: PaymentStay(),
              ),
              SizedBox(width: 8),
              Flexible(
                child: PrintReceiptStay(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Flexible(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Disable or Enable order types',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 8),
                      const Text('Take OUt'),
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 8),
                      const Text('Pick Up'),
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 8),
                      const Text('Delivery'),
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 8),
                      const Text('Quick Service'),
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 8),
                      const Text('Bar'),
                    ],
                  ),
                ],
              ),
            )),
        const SizedBox(height: 20),
        Flexible(
          flex: 3,
          child: Row(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isBackupEnabled,
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        isBackupEnabled = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text('Enable Backup Server'),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              const Text('IP Address'),
              const SizedBox(width: 8),
              SizedBox(
                width: context.dynamicWidth(0.2),
                child: Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextField(
                      enabled: isBackupEnabled,
                      decoration: InputDecoration(
                        hintText: 'Enter server address',
                        hintStyle: TextStyle(
                          color: isBackupEnabled ? null : Colors.grey,
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const Flexible(
          flex: 3,
          child: _BottomButtonFields(),
        ),
      ]),
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
