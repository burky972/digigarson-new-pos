part of 'table_right_widget.dart';

class _ProductListWidget extends StatefulWidget {
  const _ProductListWidget();

  @override
  State<_ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<_ProductListWidget> with TableRightMixin {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: (context.dynamicWidth(.32) + (context.dynamicWidth(.06) - 60)) / 4,
          constraints: const BoxConstraints(
            minWidth: 60,
            maxWidth: 110,
          ),
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
        BlocBuilder<BranchCubit, BranchState>(
            builder: ((context, state) => state.states == BranchStates.loading
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
                      itemCount: productLength(state.selectedCategory, state.filter.toString(),
                          state.branchModel != null ? state.branchModel!.products! : []),
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () {
                                // context.read<TableCubit>()
                                // // Provider.of<TableListProvider>(context, listen: false)
                                // //     .setSendFirst(false);
                                //     context.read<TableCubit>().setS
                                // Provider.of<TableListProvider>(context, listen: false)
                                //     .setSelectedProduct(
                                //         productList[index],
                                //         Provider.of<TableListProvider>(context, listen: false)
                                //             .NewOrderProductAmount);

                                // Provider.of<TableListProvider>(context, listen: false)
                                //     .setSelectedOptionItemClear();
                                // Provider.of<TableListProvider>(context, listen: false)
                                //     .setSelectedPrice(productList[index].prices.first);
                                // if (productList[index].options.isNotEmpty) {
                                //   Iterable<Options_> option = myBranchProvider.myBranch!.options
                                //       .where((option) =>
                                //           option.sId == productList[index].options.first.optionId);
                                //   Provider.of<TableListProvider>(context, listen: false)
                                //       .setSelectedOption(option.isNotEmpty ? option.first : null);
                                //   Provider.of<TableListProvider>(context, listen: false)
                                //       .setSelectedOptionId(
                                //           productList[index].options.first.optionId);
                                //   if (productList[index]
                                //       .options
                                //       .any((element) => element.isForcedChoice)) {
                                //     ProductDetailDialog().showOptionsDialog(context, false);
                                // } else {
                                //   addNewOrderProduct(productList[index], "");
                                //   Provider.of<TableListProvider>(context, listen: false)
                                //       .setNewOrderAmount("0", true);
                                // }
                                // } else if (productList[index].saleType == 2) {
                                //   ProductDetailDialog().showOptionsDialog(context, false);
                                // } else {
                                //   addNewOrderProduct(productList[index], "");
                                //   Provider.of<TableListProvider>(context, listen: false)
                                //       .setNewOrderAmount("0", true);
                                // }
                              },
                              child: Container(
                                height: 170,
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    color: context.colorScheme.primary,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                    border: BorderConstants.borderAllSmall),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      child: Image.network(
                                        productList[index].image,
                                        loadingBuilder: (BuildContext context, Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded /
                                                        (loadingProgress.expectedTotalBytes ?? 1)
                                                    : null,
                                              ),
                                            );
                                          }
                                        },
                                        errorBuilder: (BuildContext context, Object error,
                                            StackTrace? stackTrace) {
                                          Logger().i(error);
                                          return const Text('Resim yüklenirken bir hata oluştu.');
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
                                            productList[index].title,
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
                                              productList[index].prices.first.price.toString(),
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
                                              // Provider.of<TableListProvider>(context, listen: false)
                                              //     .setSendFirst(false);
                                              // Provider.of<TableListProvider>(context, listen: false)
                                              //     .setSelectedProduct(
                                              //         productList[index],
                                              //         Provider.of<TableListProvider>(context,
                                              //                 listen: false)
                                              //             .NewOrderProductAmount);

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
                  ))),
      ],
    );
  }

  void addNewOrderProduct(ProductsModel productList, String note) {
    if (note.isEmpty) {
      // if (Provider.of<TableListProvider>(context, listen: false).NewProducts.products.any(
      //     (element) => (element.priceId == productList.prices.first.sId &&
      //         element.product == productList.sId &&
      //         element.options.length < 1 &&
      //         element.note.isEmpty))) {
      //   int index = Provider.of<TableListProvider>(context, listen: false)
      //       .newProducts
      //       .products
      //       .indexWhere((element) =>
      //           element.product == productList.sId &&
      //           element.options.length < 1 &&
      //           element.note.isEmpty);

      //   if (index >= 0) {
      //     Provider.of<TableListProvider>(context, listen: false)
      //             .newProducts
      //             .products[index]
      //             .quantity +=
      //         Provider.of<TableListProvider>(context, listen: false).NewOrderProductAmount;
      //     print(
      //         "${Provider.of<TableListProvider>(context, listen: false).newProducts.products[index].price} ${productList.prices.first.price}");
      //     print(Provider.of<TableListProvider>(context, listen: false)
      //         .newProducts
      //         .products[index]
      //         .price);
      //     return;
      //   }
      // }
    }
    // Provider.of<TableListProvider>(context, listen: false).NewProducts.products.add(NewOrderProduct(
    //     isFirst: false,
    //     product: productList.sId,
    //     categoryId: productList.category,
    //     quantity: Provider.of<TableListProvider>(context, listen: false).NewOrderProductAmount,
    //     priceId: productList.prices.first.sId,
    //     price: double.parse(productList.prices.first.price),
    //     note: note,
    //     priceName: productList.prices.first.priceName,
    //     productName: productList.title,
    //     options: []));
  }

  Future<void> handleButtonAction(
      TableCubit tableCubit, TableState state, ButtonAction action, BuildContext context) async {
    switch (action.index) {
      ///cancel product
      case 0:
        var productList = state.selectProducts;

        var filteredProducts =
            productList.where((product) => product.status != 0 && product.isServe != true).toList();
        tableCubit.setSelectedProducts(filteredProducts);

        if (filteredProducts.isNotEmpty) {
          // CancelProductDialog()
          //     .showCancelProductDialogDialog(GlobalKey(), context);
        } else if (productList.isNotEmpty) {
          showOrderErrorDialog(context, 'Lütfen Uygun Ürün Seçiniz');
        } else {
          showOrderDialogWithOutCustomDuration(context,
              'Lütfen ilk önce sipariş oluşturun, ardından iptal edilecek ürünleri seçiniz');
        }
        break;

      /// move product
      case 1:
        if (state.selectProducts.isNotEmpty) {
          context
              .read<BranchCubit>()
              .setSectionMoveSelected(context.read<BranchCubit>().branchModel!.sections!.first);
          tableCubit.setSelectedMoveTable(null);

          // MoveProductDialog().showMoveProductDialog(context);
        } else {
          showOrderDialogWithOutCustomDuration(context, 'Lütfen Ürün Seçiniz');
        }
        break;

      /// QR Approve
      case 2:
        if (state.selectProducts.isNotEmpty) {
          var productList = state.selectProducts;

          var filteredProducts =
              productList.where((product) => product.user != null && product.status == 1).toList();
          List<String> productIdList = [];
          for (var element in filteredProducts) {
            productIdList.add(element.id.toString());
          }

          if (productIdList.isEmpty) {
            showOrderErrorDialog(context, 'Lütfen Doğru Ürün Seçiniz');

            return;
          }
          showOrderWarningDialog(context, "Ürün Onaylanıyor...");
          // bool return_ =
          //     await tableCubit
          //         .tableQrOrderApprove(
          //             context,
          //             QrProduct(
          //                 tableId: Provider.of<TableListProvider>(context,
          //                         listen: false)
          //                     .selectedTable_!
          //                     .id
          //                     .toString(),
          //                 products: productIdList),
          //             Provider.of<AuthProvider>(context, listen: false)
          //                 .userModel);
          // if (return_) {
          //   Provider.of<TableListProvider>(context, listen: false)
          //       .setSelectedProducts([]);
          //   Navigator.of(context).pop();
          //   showOrderSuccesDialog(context, "Ürün Onaylandı");
          // } else {
          //   Navigator.of(context).pop();
          //   showOrderErrorDialog(context, 'Ürün Onaylanmadı');
          // }
        } else {
          showOrderErrorDialog(context, 'Lütfen Ürün Seçiniz');
        }
        break;

      /// QR Cancel
      case 3:
        if (state.selectProducts.isNotEmpty) {
          var productList = state.selectProducts;

          var filteredProducts =
              productList.where((product) => product.user != null && product.status == 1).toList();
          List<String> productIdList = [];
          for (var element in filteredProducts) {
            productIdList.add(element.id.toString());
          }

          if (productIdList.isEmpty) {
            showOrderErrorDialog(context, 'Lütfen Doğru Ürün Seçiniz');
            return;
          }
          showOrderWarningDialog(context, "Ürün İptal Ediliyor...");
          // bool return_ =
          // await Provider.of<TableListProvider>(context, listen: false)
          //     .tableQrOrderCancel(
          //         context,
          //         QrProduct(
          //             tableId: Provider.of<TableListProvider>(context,
          //                     listen: false)
          //                 .selectedTable_!
          //                 .id
          //                 .toString(),
          //             products: productIdList),
          //         Provider.of<AuthProvider>(context, listen: false)
          //             .userModel);
          // if (return_) {
          //   Provider.of<TableListProvider>(context, listen: false)
          //       .setSelectedProducts([]);
          //   Navigator.of(context).pop();
          //   showOrderSuccesDialog(context, "Ürün İptal Edildi");
          // } else {
          //   Navigator.of(context).pop();
          //   showOrderErrorDialog(context, 'Ürün İptal Edilmedi');
          // }
        } else {
          showOrderErrorDialog(context, 'Lütfen Ürün Seçiniz');
        }
        break;

      /// Cover
      case 4:
        // CoverDialog().showCoverDialog(context);
        break;

      /// Edit Customer Count
      case 5:
        if (state.selectedTable!.orders.isNotEmpty) {
          // EditCustomerCountDialog().show(context);
        } else {
          showOrderDialogWithOutCustomDuration(context, 'Kapalı masalar için bu işlem yapılamaz!',
              type: DialogType.warning);
        }
        break;

      /// cash Open
      case 6:
        break;

      /// Change Price
      case 7:
        var productList = state.selectProducts;

        /// check if product is cancelled !
        for (var i = 0; i < productList.length; i++) {
          if (productList[i].status == 0) {
            showOrderDialogWithOutCustomDuration(
                context, 'İptal edilen ürünün fiyatı değiştirilemez!');
            return;
          }
        }
        if (state.selectedTable!.orders.isEmpty) {
          showOrderDialogWithOutCustomDuration(
              context, 'Lütfen önce fiyatı değişecek ürünleri seçiniz');
          return;
        }
        if (productList.isNotEmpty) {
          // ChangeProductPriceDialog().showChangeProductPriceDialog(context,
          //     orderNum: state.selectedTable!.orders.first.orderNum!);
        } else {
          showOrderErrorDialog(context, 'Lütfen Ürün Seçiniz');
        }

        break;

      /// Close Table
      case 8:
        if (state.selectedTable!.orders.isNotEmpty) {
          showCloseTableDialog(context, onOkPressed: () async {
            // bool isClosed =
            //     await Provider.of<TableListProvider>(context, listen: false)
            //         .tableClose(
            //   context,
            //   Provider.of<AuthProvider>(context, listen: false).userModel,
            //   Provider.of<TableListProvider>(context, listen: false)
            //       .selectedTable_!
            //       .id
            //       .toString(),
            // );
            // if (isClosed) {
            //   Provider.of<TableListProvider>(context, listen: false)
            //       .tableGet(Provider.of<AuthProvider>(context, listen: false)
            //           .userModel)
            //       .then((_) => Navigator.of(context).pushAndRemoveUntil(
            //           MaterialPageRoute(builder: (context) => MainScreen()),
            //           (route) => true));
            // }
          });
        } else {
          showOrderErrorDialog(context, 'Kapalı olan masa kapatılamaz!');
        }
        break;
      default:
        break;
    }
  }
}

mixin TableRightMixin on State<_ProductListWidget> {
  List<ProductsModel> productList = [];
  List<String> btnList = [
    "Cancel Product",
    "Move Product",
    "QR Approve",
    "QR Cancel",
    "Cover",
    // "Mainsaway",
    "Edit customer count",
    "Cash Open",
    "Change price",
    "Close Table"
  ];

  productLength(CategoriesModel? category, String filter, List<ProductsModel> listProduct) {
    bool isInCategoryOrSubcategory(CategoriesModel category_, ProductsModel product) {
      if (category_.sId == product.category) {
        return true;
      }

      for (var subCategory in category_.subCategory) {
        if (isInCategoryOrSubcategory(subCategory, product)) {
          return true;
        }
      }

      return false;
    }

    productList.clear();
    for (var product in listProduct) {
      if (category != null) {
        ProductsModel? products;
        if (category.sId == product.category || isInCategoryOrSubcategory(category, product)) {
          products = product;
        }
        if (filter.isNotEmpty && products != null) {
          if (products.title.toLowerCase().contains(filter.toLowerCase())) {
            productList.add(product);
          } else if (products.title.toUpperCase().contains(filter.toUpperCase())) {
            productList.add(product);
          }
        } else {
          products != null ? productList.add(product) : null;
        }
      } else {
        if (filter.isNotEmpty) {
          if (product.title.toLowerCase().contains(filter.toLowerCase())) {
            productList.add(product);
          } else if (product.title.toUpperCase().contains(filter.toUpperCase())) {
            productList.add(product);
          }
        } else {
          productList.add(product);
        }
      }
    }
    return productList.length;
  }
}
