part of '../view/product_view.dart';

/// Left Side Table Category List
class _CategoryListWidget extends StatelessWidget {
  const _CategoryListWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
      width: context.dynamicWidth(0.2),
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Group Name',
            style: CustomFontStyle.titlesTextStyle,
          ),
          const SizedBox(height: 10),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              return Column(
                children: state.subCategories.map((e) {
                  return InkWell(
                    onTap: () async {
                      await context.read<CategoryCubit>().setSelectedSubCategory(e);
                      if (!context.mounted) return;
                      context.read<ProductCubit>().setSelectedProductById(e.id!);
                    },
                    child: Container(
                      color: e == state.selectedSubCategory ? context.colorScheme.tertiary : null,
                      child: Column(
                        children: [
                          Text('${e.title}'),
                          const Divider(),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      )),
    );
  }
}

/// Middle Product Table Widget
class _MiddleProductTableWidget extends StatelessWidget {
  const _MiddleProductTableWidget();

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final ScrollController horizontalController = ScrollController();
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        List<ProductModel>? productsToDisplay = [];
        if (context.read<CategoryCubit>().selectedSubCategory?.id != null) {
          productsToDisplay =
              state.categorizedProducts?[context.read<CategoryCubit>().selectedSubCategory?.id] ??
                  [];
        }
        return Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: context.dynamicHeight(0.52),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Middle Table Widget
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
                                        _TableCellTitleWidget(title: 'Option Name'),
                                        _TableCellTitleWidget(title: 'Price'),
                                        _TableCellTitleWidget(title: 'L Price'),
                                        _TableCellTitleWidget(title: 'H Price'),
                                        _TableCellTitleWidget(title: 'D Price'),
                                        _TableCellTitleWidget(title: 'T Price'),
                                        _TableCellTitleWidget(title: 'Tax'),
                                        _TableCellTitleWidget(title: 'BarTax'),
                                      ],
                                    ),
                                    ...productsToDisplay.map((product) {
                                      return TableRow(
                                        decoration: BoxDecoration(
                                          color: product.id == state.selectedProduct?.id!
                                              ? context.colorScheme.tertiary
                                              : null,
                                        ),

                                        /// Table Cell TITLE lIST Text Widget
                                        //!  Middle Table Cell
                                        children: [
                                          BlocListener<ProductCubit, ProductState>(
                                            listener: (context, state) {},
                                            listenWhen: (previous, current) =>
                                                previous.selectedProduct?.title !=
                                                    current.selectedProduct?.title ||
                                                previous.selectedProduct?.options !=
                                                    current.selectedProduct?.options ||
                                                previous.selectedProduct?.options!.length !=
                                                    current.selectedProduct?.options!.length,
                                            child: _MiddleTableCellTextWidget(
                                              product: product,
                                              text: product.title ?? '',
                                            ),
                                          ),
                                          _MiddleTableCellTextWidget(
                                            product: product,
                                            text: product.prices!.isNotEmpty
                                                ? product.prices!.first.price.toString()
                                                : '',
                                          ),
                                          _MiddleTableCellTextWidget(
                                            product: product,
                                            text: product.prices!.isNotEmpty
                                                ? product.prices!.first.amount.toString()
                                                : '',
                                          ),
                                          _MiddleTableCellTextWidget(
                                            product: product,
                                            text: product.prices!.isNotEmpty
                                                ? product.prices!.first.amount.toString()
                                                : '',
                                          ),
                                          _MiddleTableCellTextWidget(
                                            product: product,
                                            text: product.prices!.isNotEmpty
                                                ? product.prices!.first.amount.toString()
                                                : '',
                                          ),
                                          _MiddleTableCellTextWidget(
                                            product: product,
                                            text: product.prices!.isNotEmpty
                                                ? product.prices!.first.amount.toString()
                                                : '',
                                          ),
                                          _MiddleTableCellTextWidget(
                                            product: product,
                                            text: product.prices!.isNotEmpty
                                                ? product.prices!.first.vatRate.toString()
                                                : '',
                                          ),
                                          _MiddleTableCellTextWidget(
                                            product: product,
                                            text: '0',
                                            // text: product.prices!.isNotEmpty
                                            //     ? product.prices!.first.amount.toString()
                                            //     : '',
                                          ),
                                        ],
                                      );
                                    }),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                    RightOptionTableWidget(
                      key: ValueKey(state.selectedProduct?.id),
                    ),
                  ],
                ),
              ),
              //! Bottom Widgets (Textfield-imageField-browseButton)
              const Expanded(
                child: _BottomWidgets(),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Right Side Small Table Option List
class RightOptionTableWidget extends StatelessWidget {
  const RightOptionTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController smallTableScrollController = ScrollController();
    final ScrollController smallTableHorizontalController = ScrollController();

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final selectedProduct = state.selectedProduct;
        String productId = selectedProduct?.id ?? '';
        var selectedOptionIds = state.productOptions[productId] ?? [];
        if (selectedProduct == null) {
          return const Center(child: Text('No product selected'));
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Container(
                width: context.dynamicWidth(0.3),
                height: context.dynamicHeight(0.4),
                decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
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
                                _TableCellTitleWidget(title: 'Select'),
                                _TableCellTitleWidget(title: 'Option Group'),
                                _TableCellTitleWidget(title: 'Maximum Options'),
                              ],
                            ),
                            ...state.allOptions.map((option) {
                              bool isSelected = selectedOptionIds
                                  .any((selectedOption) => selectedOption.id == option?.id);

                              return TableRow(
                                decoration: BoxDecoration(
                                  color: option == state.selectedOption
                                      ? context.colorScheme.tertiary
                                      : null,
                                ),
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const AppPadding.minAll(),
                                      child: Checkbox(
                                        value: isSelected,
                                        onChanged: (value) {
                                          context.read<ProductCubit>().toggleOptionToProduct(
                                                productId,
                                                ProductOptionModel(
                                                    id: option!.id!, isForcedChoice: false),
                                                context
                                                    .read<CategoryCubit>()
                                                    .selectedSubCategory!
                                                    .id!,
                                              );
                                        },
                                      ),
                                    ),
                                  ),
                                  TableRowInkWell(
                                    onTap: () =>
                                        context.read<ProductCubit>().setSelectedOption(option),
                                    child: _TableCellTextWidget(text: option!.name!),
                                  ),
                                  TableRowInkWell(
                                    onTap: () =>
                                        context.read<ProductCubit>().setSelectedOption(option),
                                    child:
                                        _TableCellTextWidget(text: option.chooseLimit.toString()),
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
                      // readOnly: !selectedSmallTableData[selectedSmallTableIndex!]['select'],
                      controller: TextEditingController(),
                      style: CustomFontStyle.formsTextStyle
                          .copyWith(fontSize: context.dynamicWidth(0.01)),
                      onChanged: (value) {
                        // if (selectedSmallTableIndex != null) {
                        //   setState(() {
                        //     selectedSmallTableData[selectedSmallTableIndex!]['maximumOptions'] =
                        //         int.tryParse(value) ??
                        //             selectedSmallTableData[selectedSmallTableIndex!]
                        //                 ['maximumOptions'];
                        //   });
                        // }
                      },
                      decoration: const InputDecoration(
                          // label: Text(  selectedSmallTableData[0]['maximumOptions'].toString()),
                          label: Text('maximum option'),
                          hintText: '',
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          border: OutlineInputBorder(borderSide: BorderSide(width: 2))),
                    )),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

/// Bottom Widgets( textfield-imageField-browseButton )
class _BottomWidgets extends StatelessWidget {
  const _BottomWidgets();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductCubit, ProductState, String?>(
      selector: (state) => state.selectedProduct?.image,
      builder: (context, imageString) {
        return Column(
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
                  BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      return Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  const Expanded(flex: 1, child: Text('Option Group')),
                                  Expanded(
                                    flex: 2,
                                    child:
                                        BlocSelector<CategoryCubit, CategoryState, CategoryModel>(
                                      selector: (state) {
                                        return state.selectedSubCategory ?? CategoryModel.empty();
                                      },
                                      builder: (context, selectedSubCategory) {
                                        return CustomBorderAllTextfield(
                                          isReadOnly: true,
                                          controller: TextEditingController(
                                              text: selectedSubCategory.title ?? ""),
                                          onChanged: (value) {},
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  const Expanded(flex: 1, child: Text('Item Name')),
                                  Expanded(
                                    flex: 2,
                                    child: CustomBorderAllTextfield(
                                      isReadOnly:
                                          state.selectedProduct?.prices?.first.priceName == null,
                                      controller:
                                          context.read<ProductCubit>().productNameController,
                                      onChanged: (value) {
                                        context.read<ProductCubit>().updateSelectedProductName(
                                            value,
                                            context.read<CategoryCubit>().selectedSubCategory!.id!);
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
                                      onChanged: (value) {},
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
                                      isReadOnly:
                                          state.selectedProduct?.prices?.first.priceName == null,
                                      controller:
                                          context.read<ProductCubit>().productPriceController ??
                                              TextEditingController(text: ''),
                                      onChanged: (value) {
                                        context.read<ProductCubit>().updateSelectedProductPrice(
                                            double.tryParse(value) ?? 0.0,
                                            context.read<CategoryCubit>().selectedSubCategory!.id!);
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
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                const Expanded(flex: 1, child: Text('HappyHour Price')),
                                Expanded(
                                  flex: 2,
                                  child: CustomBorderAllTextfield(
                                    // controller: _happyHourController,
                                    controller: TextEditingController(),
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Row(
                              children: [
                                const Expanded(flex: 1, child: Text('Delivery Price')),
                                Expanded(
                                  flex: 2,
                                  child: CustomBorderAllTextfield(
                                    // controller: _deliveryPriceController,
                                    controller: TextEditingController(),
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Row(
                              children: [
                                const Expanded(flex: 1, child: Text('TakeOut Price')),
                                Expanded(
                                  flex: 2,
                                  child: CustomBorderAllTextfield(
                                    // controller: _takeOutPriceController,
                                    controller: TextEditingController(),
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text('Tax% '),
                                ),
                                Expanded(
                                  flex: 2,
                                  //todo: tax controller
                                  child: CustomBorderAllTextfield(
                                    controller: context.read<ProductCubit>().taxController ??
                                        TextEditingController(text: ''),
                                    onChanged: (value) => context
                                        .read<ProductCubit>()
                                        .updateSelectedProductTax(value,
                                            context.read<CategoryCubit>().selectedSubCategory!.id!),
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
                            onTap: () {},
                            child: Container(
                              width: context.dynamicHeight(0.1),
                              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                              child: imageString == null || imageString.isEmpty
                                  ? null
                                  : imageString.length < 500
                                      ? Image.network(imageString)
                                      : Image.memory(base64Decode(imageString)),
                              // child: imageString == null ||
                              //         imageString.isEmpty
                              //     ? selectedColor != null
                              //         ? ColoredBox(color: selectedColor)
                              //         : state.productImage != null
                              //             ? Image.file(
                              //                 state.productImage!)
                              //             : null
                              //     : Image.memory(
                              //         base64Decode(imageString)),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LightBlueButton(
                                buttonText: 'Browse',
                                onTap: () => context.read<ProductCubit>().getProductImage(),
                              ),
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
                                                context
                                                    .read<ProductCubit>()
                                                    .setSelectedColor(value);
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
                                  child: const LightBlueButton(buttonText: 'Color')),
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
        );
      },
    );
  }
}
