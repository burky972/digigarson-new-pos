import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/receipt/view/widget/receipt_font_star_other_printers.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiptView extends StatefulWidget {
  const ReceiptView({super.key});

  @override
  State<ReceiptView> createState() => _ReceiptViewState();
}

String? selectedValue;
String? selectedValue2;
String? selectedValue3;
String? selectedValue4;
String? selectedValue5;
List<String> list = <String>[
  'HOT',
  'TEST',
  'KITCHEN',
  'Receipt',
];
List<String> list2 = <String>['Cash and Credit Card', 'Cash', 'Credit Card'];
List<String> list3 = <String>[
  'Mercury',
  'TSYS',
  'Dejavoo',
  'Datacap',
  'SoundPayment'
];

class _ReceiptViewState extends State<ReceiptView> {
  String? selectedFilePath;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFilePath = result.files.single.path;
      });
    } else {
      // Kullanıcı dosya seçmedi
      setState(() {
        selectedFilePath = 'Dosya seçilmedi.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Row(
              children: [
                const Expanded(
                  child: Text('Primary Receipt Printer'),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    hint: const Text(''),
                    value: selectedValue,
                    isExpanded: true,
                    items: list.map<DropdownMenuItem<String>>((String value) {
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
          Flexible(
            child: Row(
              children: [
                const Expanded(child: Text('Secondary Receipt Printer')),
                Expanded(
                  child: DropdownButton<String>(
                    hint: const Text(''),
                    value: selectedValue2,
                    isExpanded: true,
                    items: list.map<DropdownMenuItem<String>>((String value) {
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
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: _pickFile,
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                const Expanded(child: Text('Default Report Printer')),
                Expanded(
                  child: DropdownButton<String>(
                    hint: const Text(''),
                    value: selectedValue3,
                    isExpanded: true,
                    items: list.map<DropdownMenuItem<String>>((String value) {
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
          Flexible(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Print receipt after close order'),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Use Credit Card System'),
                const SizedBox(width: 8),
                SizedBox(
                  width: context.dynamicWidth(0.2),
                  child: DropdownButton<String>(
                    hint: const Text(''),
                    value: selectedValue5,
                    isExpanded: true,
                    items: list3.map<DropdownMenuItem<String>>((String value) {
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
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: _pickFile,
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Print Item Detail In Receipt'),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Print Option Detail In Receipt'),
                const SizedBox(width: 8),
                const Text(
                  'Note: "Print Item Detail In Receipt" must be checked at first, and then you can check it.',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Ask whether close the order when settle'),
                const SizedBox(width: 12),
                SizedBox(
                  width: context.dynamicWidth(0.2),
                  child: DropdownButton<String>(
                    hint: const Text(''),
                    value: selectedValue4,
                    isExpanded: true,
                    items: list2.map<DropdownMenuItem<String>>((String value) {
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
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Show Tips Screen For Credit Card'),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Tip Guide'),
                const SizedBox(width: 20),
                const Text('Rate1(%)'),
                SizedBox(
                    width: context.dynamicWidth(0.1), child: const TextField()),
                const SizedBox(width: 20),
                const Text('Rate2(%)'),
                SizedBox(
                    width: context.dynamicWidth(0.1), child: const TextField()),
                const SizedBox(width: 20),
                const Text('Rate3(%)'),
                SizedBox(
                    width: context.dynamicWidth(0.1), child: const TextField()),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Flexible(flex: 8, child: ReceiptFontStarOtherPrinters()),
          const Flexible(
            flex: 3,
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
