part of './table_right_widget.dart';

class _ProductListWidget extends StatelessWidget {
  const _ProductListWidget();

  @override
  Widget build(BuildContext context) {
    bool isViewAll = context.read<CategoryCubit>().selectedCategory == null ? true : false;
    return Row(
      children: [
        Container(
          width: (context.dynamicWidth(.32) + (context.dynamicWidth(.06) - 60)) / 4,
          constraints: const BoxConstraints(
            minWidth: 60,
            maxWidth: 110,
          ),

          /// Right vertical buttons field
          child: BlocBuilder<TableCubit, TableState>(
            builder: (context, state) {
              TableCubit tableCubit = context.read<TableCubit>();
              List<MapEntry<ButtonAction, String>> rightVerticalButtonList =
                  ButtonAction.buttonLabels.entries.toList().sublist(0, 10);

              return ListView(
                children: rightVerticalButtonList.map((entry) {
                  final action = entry.key;
                  final label = entry.value;
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () async {
                        await handleButtonAction(tableCubit, state, action, context);
                      },
                      child: TableButtonWidget(label),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),

        /// ALL Product list
        BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state.selectedCategory == null) {
              isViewAll = true;
            } else {
              isViewAll = false;
            }
          },
          listenWhen: (previous, current) => previous.selectedCategory != current.selectedCategory,
          buildWhen: (previous, current) => previous.selectedCategory != current.selectedCategory,
          builder: (context, state) {
            return BlocBuilder<ProductCubit, ProductState>(
                builder: ((context, state) => state.states == ProductStates.loading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    : Container(
                        width: context.dynamicWidth(.62) -
                            ((context.dynamicWidth(.32) + (context.dynamicWidth(.06) - 60)) / 4),
                        constraints: BoxConstraints(
                          minWidth: context.dynamicWidth(.62) - 110,
                          maxWidth: context.dynamicWidth(.62) - 60,
                        ),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150,
                            mainAxisSpacing: 9,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: isViewAll
                              ? state.allProducts.length
                              : state
                                      .categorizedProducts?[
                                          context.read<CategoryCubit>().selectedCategory?.id]
                                      ?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            ProductModel product = isViewAll
                                ? state.allProducts[index] ?? ProductModel.empty()
                                : state.categorizedProducts?[context
                                        .read<CategoryCubit>()
                                        .selectedCategory
                                        ?.id]![index] ??
                                    ProductModel.empty();

                            return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 170,
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        color: context.colorScheme.primary,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)),
                                        border: BorderConstants.borderAllSmall),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 80,
                                          child: product.image == null || product.image!.isEmpty
                                              ? Assets.icon.icLogo.image()
                                              : Image.network(
                                                  product.image!,
                                                  loadingBuilder: (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent? loadingProgress) {
                                                    if (loadingProgress == null) {
                                                      return child;
                                                    } else {
                                                      return Center(
                                                        child: CircularProgressIndicator(
                                                          value:
                                                              loadingProgress.expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      (loadingProgress
                                                                              .expectedTotalBytes ??
                                                                          1)
                                                                  : null,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  errorBuilder: (BuildContext context, Object error,
                                                      StackTrace? stackTrace) {
                                                    return const Text(
                                                        'An error occurred while loading the image.');
                                                  },
                                                ),
                                        ),
                                        Stack(
                                          alignment: Alignment.bottomRight,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 150,
                                              height: 82.0,
                                              child: Text(
                                                product.title!,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 2, right: 2, bottom: 0, top: 0),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(Radius.circular(5)),
                                                  border: BorderConstants.borderAllSmall),
                                              child: Text(
                                                  product.prices?.first.price.toString() ?? '',
                                                  style: TextStyle(
                                                      fontSize: 17.0,
                                                      color: Colors.black.withOpacity(0.8),
                                                      fontWeight: FontWeight.bold)),
                                            ),
                                            Container(
                                              width: 150,
                                              height: 82.0,
                                              padding: const EdgeInsets.only(
                                                  left: 2, right: 2, bottom: 0, top: 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  context.read<ProductCubit>().setSelectedProduct(
                                                      product,
                                                      product.prices?.first ?? PriceModel.empty());
                                                  context.read<TableCubit>().setNewOrderProducts(
                                                      OrderProductModel(
                                                          uniqueTimestamp:
                                                              DateTime.now().toIso8601String(),
                                                          id: product.id ?? '',
                                                          isFirst: false,
                                                          product: product.id!,
                                                          productName: product.title!,
                                                          quantity:
                                                              product.prices?.first.amount ?? 1,
                                                          categoryId: product.category!,
                                                          price: product.prices!.first.price ?? 1,
                                                          tax: product.prices!.first.vatRate ?? 0.0,
                                                          priceId: product.prices?.first.id ?? '',
                                                          cancelStatus: CancelStatus.empty(),
                                                          priceName:
                                                              product.prices!.first.priceName!,
                                                          priceType:
                                                              product.prices?.first.priceType ??
                                                                  'REGULAR',
                                                          note: "",
                                                          options: const []),
                                                      1.0);
                                                  // context
                                                  //     .read<TableCubit>()
                                                  //     .setNewOrderAmount("1", true);
                                                  // Provider.of<TableListProvider>(context, listen: false)
                                                  //     .setSelectedOptionItemClear();
                                                  // Provider.of<TableListProvider>(context, listen: false)
                                                  //     .setSelectedPrice(
                                                  //         productList[index].prices.first);
                                                  // if (productList[index].options.isNotEmpty) {
                                                  //   Iterable<Options_> option = myBranchProvider
                                                  //       .myBranch!.options
                                                  //       .where((option) =>
                                                  //           option.sId ==
                                                  //           productList[index].options.first.optionId);
                                                  //   Provider.of<TableListProvider>(context,
                                                  //           listen: false)
                                                  //       .setSelectedOption(
                                                  //           option.isNotEmpty ? option.first : null);
                                                  //   Provider.of<TableListProvider>(context,
                                                  //           listen: false)
                                                  //       .setSelectedOptionId(
                                                  //           productList[index].options.first.optionId);
                                                  // }
                                                  // ProductDetailDialog()
                                                  //     .showOptionsDialog(context, false);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        ),
                      )));
          },
        ),
      ],
    );
  }
}

void addNewOrderProduct(ProductModel productList, String note, BuildContext context) {
  if (note.isEmpty) {
    if (context.read<TableCubit>().newProducts.products.any((element) =>
        (element.priceId == productList.prices?.first.id && element.product == productList.id))) {
      int index = context
          .read<TableCubit>()
          .newProducts
          .products
          .indexWhere((element) => element.product == productList.id);

      if (index >= 0) {
        double quantity = context.read<TableCubit>().newProducts.products[index].quantity ?? 0;
        quantity += context.read<TableCubit>().state.newOrderProductAmount;
        return;
      }
    }
  }
  context.read<TableCubit>().newProducts.products.add(OrderProductModel(
      id: productList.id ?? '',
      isFirst: false,
      product: productList.id!,
      categoryId: productList.category!,
      tax: productList.prices?.first.vatRate ?? 0,
      quantity: context.read<TableCubit>().state.newOrderProductAmount == 0
          ? 1
          : context.read<TableCubit>().state.newOrderProductAmount,
      priceId: productList.prices?.first.id ?? '',
      price: double.parse(productList.prices?.first.price!.toString() ?? '0'),
      note: note,
      priceName: productList.prices?.first.priceName.toString() ?? '',
      priceType: productList.prices!.first.priceType ?? 'REGULAR',
      productName: productList.title ?? '',
      cancelStatus: CancelStatus.empty(),
      options: const []));
}

Future<void> handleButtonAction(
    TableCubit tableCubit, TableState state, ButtonAction action, BuildContext context) async {
  switch (action.index) {
    ///cancel product
    case 0:
      if (state.selectedTable == null ||
          state.newOrderProduct == null ||
          state.selectedTable?.orders == null ||
          state.selectedTable?.orders.isEmpty == true) return;
      CancelProductDialog().showCancelProductDialogDialog(GlobalKey(), context);
      break;

    /// Move Product
    case 1:
      if (state.newOrderProduct == null) return;
      tableCubit.setSelectedMoveTable(state.selectedTable!);
      if (state.selectedTable?.orders == null || state.selectedTable?.orders.isEmpty == true) {
        return;
      }
      showDialog(
        context: context,
        builder: (context) => const MoveTableProductDialog(isTransfer: false),
      );
      break;

    /// checkout
    case 9:
      appLogger.info('TAG', 'CASE 9 - ${state.newOrderProduct?.productName}');
      if (state.selectedTable == null || state.newOrderProduct == null) return;
      QuickCashDialog().show(context);

      break;
    default:
      break;
  }
}
