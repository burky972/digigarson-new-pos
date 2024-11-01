import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChargesView extends StatelessWidget {
  const ChargesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.dynamicHeight(0.25),
            width: context.dynamicWidth(0.5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///Middle all items(textfield-checkbox-selectImage)
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Flexible(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child:
                                                  Text('General Text Rate %')),
                                          Expanded(flex: 3, child: TextField()),
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
                                          const Text(
                                              'Add Delivery Change Automatically'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Flexible(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                  'Delivery Charge Rate%')),
                                          Expanded(flex: 3, child: TextField()),
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
                                          const Text(
                                              'Add Gratuity Automatically'),
                                        ],
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child:
                                                      Text('Gratuity Rate %')),
                                              Expanded(
                                                  flex: 3, child: TextField()),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child:
                                                      Text('Guests Numbers')),
                                              Expanded(
                                                  flex: 3, child: TextField()),
                                            ],
                                          ),
                                        ),
                                      ],
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
          ),
          const Expanded(
            flex: 2,
            child: _BottomButtonFields(),
          ),
        ],
      ),
    );
  }
}

class CategoryModel {
  final String? printerName;
  final String? printer;
  final String? type;
  final String? paperWidth;

  CategoryModel({this.printerName, this.printer, this.type, this.paperWidth});
}

class _BottomButtonFields extends StatelessWidget {
  const _BottomButtonFields();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
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
