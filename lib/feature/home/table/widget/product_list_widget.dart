part of './table_right_widget.dart';

class _ProductListWidget extends StatelessWidget {
  const _ProductListWidget();

  @override
  Widget build(BuildContext context) {
    OrderProductModel createOrderProductModel(ProductModel product, String randomNumber) {
      return OrderProductModel(
        uniqueTimestamp: DateTime.now().millisecondsSinceEpoch.toString() + randomNumber,
        id: product.id ?? '',
        isFirst: false,
        product: product.id!,
        productName: product.title!,
        quantity: product.prices?.first.amount ?? 1,
        categoryId: product.category!,
        price: product.prices!.first.price ?? 1,
        tax: product.prices!.first.vatRate ?? 0.0,
        priceId: product.prices?.first.id ?? '',
        priceAfterTax: 0.0,
        selectedOptions: const [],
        cancelStatus: CancelStatus.empty(),
        serveInfo: ServeInfoModel.empty(),
        priceName: product.prices!.first.priceName!,
        priceType: product.prices?.first.priceType ?? 'REGULAR',
        note: "",
        options: const [],
        isOptionForced: (product.options?.isNotEmpty ?? false) ? true : false,
      );
    }

    void showOptionMultipleProductDialog(
        BuildContext context, OrderProductModel product, ProductState state) {
      showDialog(
        context: context,
        builder: (context) => OptionMultipleProductDialog(
          product: product,
          isForce: state.selectedProduct?.options?.isNotEmpty ?? false,
        ),
      );
    }

    void showOptionCheckDialog(
        BuildContext context, OrderProductModel product, ProductState state) {
      showDialog(
        context: context,
        builder: (context) => OptionCheckDialog(
          product: product,
          isForce: state.selectedProduct?.options?.isNotEmpty ?? false,
          isExistProduct: false,
          onUpdate: (updatedOptions, selectedItems) {
            context.read<TableCubit>().setNewMultipleOrderProducts(
                  product.copyWith(
                    selectedOptions: updatedOptions,
                    quantity: 1,
                  ),
                  1,
                  updatedOptions,
                );
          },
        ),
      );
    }

    void onProductTap(
        BuildContext context, ProductModel product, ProductState state, String randomId) {
      context
          .read<ProductCubit>()
          .setSelectedProduct(product, product.prices?.first ?? PriceModel.empty());

      final orderProduct = createOrderProductModel(
        product,
        Random().nextInt(10000).toString(),
      );

      if (product.options != null && product.options!.isNotEmpty) {
        appLogger.info('options', product.options!.toString());
        context.read<ProductCubit>().getProductOptions(product);

        if ((state.selectedProductQuantity ?? -1) > 0) {
          showOptionMultipleProductDialog(context, orderProduct, state);
        } else {
          showOptionCheckDialog(context, orderProduct, state);
        }
      } else {
        if ((state.selectedProductQuantity ?? -1) > 0) {
          for (var i = 0; i < state.selectedProductQuantity!; i++) {
            randomId += Random().nextInt(10000).toString();
            final uniqueOrderProduct = orderProduct.copyWith(
              uniqueTimestamp: DateTime.now().millisecondsSinceEpoch.toString() + randomId,
            );
            context.read<TableCubit>().setNewOrderProducts(uniqueOrderProduct, 1.0);
          }
          context.read<ProductCubit>().setSelectedProductQuantity(null);
        } else {
          context.read<TableCubit>().setNewOrderProducts(orderProduct, 1.0);
        }
      }
      // Reset the quantity after adding all products
      // context.read<ProductCubit>().setSelectedProductQuantity(null);
    }

    bool isViewAll = context.read<CategoryCubit>().selectedSubCategory == null ? true : false;
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
              List<MapEntry<ButtonAction, String>> rightVerticalButtonList = state.isQuickService
                  ? []
                  : ButtonAction.buttonLabels.entries.toList().sublist(0, 12);

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
            if (state.selectedSubCategory == null) {
              isViewAll = true;
            } else {
              isViewAll = false;
            }
          },
          listenWhen: (previous, current) =>
              previous.selectedSubCategory != current.selectedSubCategory,
          buildWhen: (previous, current) =>
              previous.selectedSubCategory != current.selectedSubCategory,
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
                                          context.read<CategoryCubit>().selectedSubCategory?.id]
                                      ?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            ProductModel product = isViewAll
                                ? state.allProducts[index] ?? ProductModel.empty()
                                : state.categorizedProducts?[context
                                        .read<CategoryCubit>()
                                        .selectedSubCategory
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
                                    child: GestureDetector(
                                      onTap: () {
                                        debugPrint('onProductTap initilaized!!!');
                                        onProductTap(context, product, state,
                                            Random().nextInt(10000).toString());
                                      },
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
                                                            value: loadingProgress
                                                                        .expectedTotalBytes !=
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
                                                    errorBuilder: (BuildContext context,
                                                        Object error, StackTrace? stackTrace) {
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
                                            ],
                                          ),
                                        ],
                                      ),
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
    case 4:
      if (state.selectedTable?.orders != null && state.selectedTable!.orders.isNotEmpty) {
        CoverDialog().show(context);
      }
      break;

    /// Edit Customer Count
    case 5:
      if (state.selectedTable?.orders != null && state.selectedTable!.orders.isNotEmpty) {
        tableCubit.setCustomerCount(state.selectedTable!.customerCount.toString());
        EditCustomerCountDialog().show(context);
      }

    /// close table
    case 8:
      if (state.selectedTable == null || state.newOrderProduct == null) return;
      tableCubit.setInitialCheckoutProducts();
      showCloseTableDialog(context, onOkPressed: () async {
        bool isClosed = await tableCubit.closeTable(state.selectedTable!.id!);
        ResponseActionService.getTableAndNavigate(
          context: context,
          response: isClosed,
          tableCubit: tableCubit,
          action: ButtonAction.closeTable,
        );
      });
      break;

    /// checkout
    case 9:
      if (state.selectedTable == null ||
          state.newOrderProduct == null ||
          state.selectedTable?.orders == null ||
          state.selectedTable?.orders.isEmpty == true) return;
      tableCubit.setInitialCheckoutProducts();
      NewCheckoutDialog.show(context);
      break;
    case 10:
      appLogger.warning("TAG", "10 list product clicked");
    case 12:
      appLogger.warning("TAG", "12 list product clicked");
    case 11:

      // New Sale
      if (state.newProducts.products.isEmpty) return;

      final response = await context.read<TableCubit>().postTableNewOrder(context);
      ResponseActionService.getTableAndNavigate(
        context: context,
        response: response,
        tableCubit: tableCubit,
        action: ButtonAction.newSale,
      );

      break;

    default:
      break;
  }
}
