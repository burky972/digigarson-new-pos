import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/model/product_model.dart';
import 'package:a_pos_flutter/feature/home/printer/cubit/printer_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/i_table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_request_model.dart';
import 'package:a_pos_flutter/feature/home/table/service/i_table_service.dart';
import 'package:a_pos_flutter/feature/home/table/service/table_service.dart';
import 'package:a_pos_flutter/product/global/model/branch/branch_model.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/global/model/print/print_invoice_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/widget/invoices/invoice_widget.dart';
import 'package:a_pos_flutter/product/widget/printer/printer_widget.dart';
import 'package:core/cache/shared_manager.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableCubit extends ITableCubit {
  TableCubit() : super(TableState.initial()) {
    init();
  }

  late ITableService _tableService;
  final TAG = "TableCubit";
  List<TableModel> tableModel = [];
  List<String> deletedTableIds = [];
  NewOrderModel newProducts =
      NewOrderModel(tableId: "", products: const [], totalTax: 0, totalPrice: 0);
  Map<String, List<TableModel>> tablesBySection = {};
  TableModel? selectedTable;
  TableModel? selectedMoveTable;
  ProductsModel? newProduct;
  String optionSelectedId = "";
  double newOrderProductAmount = 1.0;
  double selectedProductItemsTotalPrice = 0.0;
  List<OrderProductModel> newOrderProducts = [];
  // bool isCalculated = false;
  @override
  void init() {
    _tableService = TableService();
  }

  @override
  void changeIsTableSaving(bool value) => emit(state.copyWith(isTableSaving: value));
  void addIdToDeletedTableIds(String id) => deletedTableIds.add(id);

  /// get table api request
  @override
  Future getTable(UserModel userModel) async {
    appLogger.info('Table CUBIT user model', userModel.toJson().toString());
    tableModel.clear();
    emit(state.copyWith(states: TableStates.loading, tableModel: tableModel));
    final response = await _tableService.getTable(userModel: userModel);
    tablesBySection = {};
    response.fold((_) => emit(state.copyWith(states: TableStates.error)), (r) {
      r.data.forEach((table) {
        List<Product> listProduct = [];
        TableModel tableModel_ = TableModel.fromJson(table);

        if (tableModel_.orders.isNotEmpty) {
          for (var order in tableModel_.orders) {
            for (var product in order.products) {
              if (product?.cancelStatus?.isCancelled != true) {
                listProduct.add(product!);
              } else {
                appLogger.info(
                    'CANCELLED TRUE :>', product?.cancelStatus?.isCancelled.toString() ?? '');
                appLogger.info('CANCELLED TRUE :>', product?.productName ?? '');
              }
            }
          }
          listProduct.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
          if (listProduct.isNotEmpty) {
            //TODO: ADD LAST ORDER DATE TO MODEL
            appLogger.error('LAST ORDER DATE :>',
                '${listProduct.first.productName} - ${listProduct.first.createdAt}');
            tableModel_ = tableModel_.copyWith(lastOrderDate: listProduct.first.createdAt);
            appLogger.error(
                'LAST ORDER DATE :>', '${tableModel_.title}${tableModel_.lastOrderDate}');
          }
        }
        if (tableModel_.section != null) {
          // for (var order in tableModel_.orders) {
          // Remove cancelled products from order
          // order.products.removeWhere((product) => product?.cancelStatus?.isCancelled == true);
          // }
          // Table'ı map'e section ID'si altında ekliyoruz
          if (tablesBySection.containsKey(tableModel_.section)) {
            tablesBySection[tableModel_.section]!.add(tableModel_);
          } else {
            tablesBySection[tableModel_.section!] = [tableModel_];
          }
        }

        tableModel_.section != null ? tableModel.add(tableModel_) : null;
      });
      if (tableModel.isEmpty) {
        tablesBySection = {};
        emit(state.copyWith(tableModel: [], tablesBySectionList: () => null));
      }

      emit(state.copyWith(
          tableModel: tableModel,
          tablesBySectionList: () => tablesBySection,
          states: TableStates.completed));
    });
  }

  /// post table api request
  @override
  Future postTable(TableRequestModel tableModel, UserModel user) async {
    emit(state.copyWith(states: TableStates.loading));
    final response = await _tableService.postTable(tableModel: tableModel);
    response.fold((_) => emit(state.copyWith(states: TableStates.error)), (r) async {
      await getTable(user);
      emit(state.copyWith(states: TableStates.completed));
    });
  }

  /// set selected new product
  void setSelectedEditProduct(OrderProductModel? newProduct) {
    emit(state.copyWith(newOrderProduct: () => newProduct));
  }

  /// update isDeletedSuccess
  set updateDeletedSuccess(bool value) => emit(state.copyWith(isDeleteSuccess: value));

  /// Delete table api request
  @override
  Future<bool> deleteTable(String tableId) async {
    bool? isSuccess;
    emit(state.copyWith(states: TableStates.loading));
    final response = await _tableService.deleteTable(tableId: tableId);

    response.fold((_) {
      appLogger.info('Table CUBIT DELETE TABLE', 'Failed');
      emit(state.copyWith(states: TableStates.error, isDeleteSuccess: false));
      isSuccess = false;
    }, (r) async {
      appLogger.info('Table CUBIT DELETE TABLE', 'Success');
      SharedManager.instance.removeValue(tableId);

      emit(state.copyWith(states: TableStates.completed, isDeleteSuccess: true));
      isSuccess = true;
    });
    return isSuccess ?? false;
  }

  /// set new table
  @override
  Future<void> setNewTableList(List<TableModel> newTableList) async {
    tableModel.clear();
    for (var tableModel_ in newTableList) {
      List<Product> listProduct = [];
      if (tableModel_.orders.isNotEmpty) {
        for (var order in tableModel_.orders) {
          for (var product in order.products) {
            listProduct.add(product!);
          }
        }
        listProduct.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        if (listProduct.isNotEmpty) {
          tableModel_ = tableModel_.copyWith(lastOrderDate: listProduct.first.createdAt);
        }
      }
      tableModel_.section != null ? tableModel.add(tableModel_) : null;
    }
    emit(state.copyWith(tableModel: tableModel));
  }

  /// post table new order
  Future<bool> postTableNewOrder(BuildContext context, UserModel userModel) async {
    appLogger.info('Table CUBIT POST TABLE NEW ORDER', state.newProducts.toJson().toString());
    bool? isSuccess;
    emit(state.copyWith(states: TableStates.loading));
    final response = await _tableService.postTableNewOrder(
        userModel: userModel,
        newOrderModel: state.newProducts,
        tableId: state.selectedTable!.id.toString());

    response.fold((_) {
      emit(state.copyWith(states: TableStates.error));
      isSuccess = false;
      appLogger.info('Table CUBIT POST TABLE NEW ORDER', 'failed : $isSuccess');
    }, (r) {
      selectedTable?.checkNo = TableModel.fromJson(r.data).orders.last.orderNum;
      emit(state.copyWith(selectedTable: selectedTable)); //! check here later!

      context.read<PrinterCubit>().customPrinterList.forEach(
        (customPrinterList) {
          Iterable<OrderProductModel> products = state.newProducts.products.where((o) =>
              (customPrinterList.categoryIdList.contains(o.categoryId.toString()) ||
                  customPrinterList.productIdList.contains(o.product)) &&
              (customPrinterList.tableIdList.isNotEmpty
                  ? customPrinterList.tableIdList.contains(selectedTable!.id)
                  : true));

          if (products.isNotEmpty) {
            PrinterKitchenInvoice invoice = PrinterWidget().invoiceKitchenConvert(
                state.selectedTable, products, context.read<PrinterCubit>().casePrinter, context);
            InvoiceWidget().printKitchen(customPrinterList, invoice);
          }
        },
      );
      newProducts = NewOrderModel(
          tableId: "",
          products: const [],
          totalTax: calculateTotalTax().toInt(),
          totalPrice: state.subPrice);

      emit(state.copyWith(newProducts: newProducts));
      isSuccess = true;
      appLogger.info('Table CUBIT POST TABLE NEW ORDER', 'Success : $isSuccess');
    });
    appLogger.info('Table CUBIT POST TABLE NEW ORDER', 'last : $isSuccess');
    return isSuccess ?? false;
  }

  /// reset
  void reset() {
    tableModel.clear();
    tablesBySection.clear();
    emit(TableState.initial());
  }

  /// set selected table
  Future<void> setSelectedTable(TableModel table) async {
    newProducts = NewOrderModel(
        tableId: table.id.toString(), products: const [], totalTax: 0, totalPrice: 0.0);
    emit(state.copyWith(
        newProducts: newProducts,
        selectProducts: [],
        selectedTable: table,
        originalOrderProduct: null,
        newOrderProductAmount: 0));
    calculateTotalTax();
    calculateSubPrice();
    calculateTotalPrice();
  }

  /// set new order products
  Future<void> setNewOrderProducts(OrderProductModel product, double qty) async {
    // Product options içerisindeki items'ların toplam fiyatını hesapla
    double selectedProductItemsTotalPrice = 0.0;
    for (var element in product.options) {
      for (var item in element.items) {
        selectedProductItemsTotalPrice += item.price!.toDouble();
      }
    }

    final updatedProducts = List<OrderProductModel>.from(state.newProducts.products);
    // int existingIndex = updatedProducts.indexWhere((p) => p.productName == product.productName);

    // Yeni ürün eklenirken de item'ların fiyatlarını dahil et
    product = product.copyWith(price: product.price! + selectedProductItemsTotalPrice);
    updatedProducts.add(product);
    // }

    final totalTax =
        updatedProducts.map((product) => product.tax).fold(0.0, (sum, tax) => sum + tax!);

    final updatedNewProducts = NewOrderModel(
        products: updatedProducts,
        tableId: state.selectedTable!.id.toString(),
        totalTax: totalTax.toInt(),
        totalPrice: state.selectedTable!.totalPrice ?? 0.0);

    final updatedNewOrderProducts = List<OrderProductModel>.from(updatedProducts);

    emit(state.copyWith(
      newOrderProducts: updatedNewOrderProducts,
      newProducts: updatedNewProducts,
    ));

    calculateSubPrice();
    calculateTotalPrice();
  }

  /// update New Order Product(ADDING OPTION;S ITEMS)

  Future<void> updateNewOrderProducts(
      OrderProductModel product, String timestamp, List<Options> newOptions) async {
    double newItemsTotalPrice = 0.0;

    // Find the existing product in the newProducts list using the timestamp
    final updatedProducts = List<OrderProductModel>.from(state.newProducts.products);
    int existingIndex = updatedProducts.indexWhere((p) => p.uniqueTimestamp == timestamp);

    if (existingIndex != -1) {
      // Get the existing product
      var existingProduct = updatedProducts[existingIndex];

      // // Reset tax for recalculation
      // for (var option in existingProduct.options) {
      //   for (var item in option.items) {
      //     if ((item.vatRate ?? 0) > 0) {
      //       double oldRate = item.price! * (item.vatRate! / 100);
      //       double newValue = product.tax!;
      //       newValue -= oldRate;
      //     }
      //   }
      // }

      // Merge new options with the existing options
      List<Options> updatedOptions = List.from(existingProduct.options);

      for (var newOption in newOptions) {
        int existingOptionIndex =
            updatedOptions.indexWhere((opt) => opt.optionId == newOption.optionId);

        if (existingOptionIndex != -1) {
          var existingItems = updatedOptions[existingOptionIndex].items;
          var combinedItems = List<Item>.from(existingItems);

          for (var newItem in newOption.items) {
            // Eğer item daha önce eklenmediyse ekle
            if (!combinedItems.any((item) => item.itemId == newItem.itemId)) {
              combinedItems.add(newItem);
            }
          }

          // Mevcut option'u güncellenmiş item'larla değiştir
          var updatedOption = updatedOptions[existingOptionIndex].copyWith(items: combinedItems);
          updatedOptions[existingOptionIndex] = updatedOption;
        } else {
          // Eğer option daha önce eklenmediyse, doğrudan listeye ekle
          updatedOptions.add(newOption);
        }
      }

      // Recalculate totalItemRate only for items with vatRate > 0
      double totalItemRate = 0;
      for (var option in updatedOptions) {
        for (var item in option.items) {
          if ((item.vatRate ?? 0) > 0) {
            double newRate = item.price! * (item.vatRate! / 100);
            totalItemRate += newRate;
          }
        }
      }

      // Update the product with new options and recalculate the price and tax
      double newQuantity = existingProduct.quantity!; // Assuming quantity remains the same
      double unitPrice =
          (existingProduct.price! / existingProduct.quantity!) + newItemsTotalPrice / newQuantity;

      double newTax = product.tax! + totalItemRate;
      updatedProducts[existingIndex] = existingProduct.copyWith(
        options: updatedOptions,
        price: unitPrice * newQuantity,
        tax: newTax,
      );
    }

    // Recalculate total tax
    final totalTax =
        updatedProducts.map((product) => product.tax).fold(0.0, (sum, tax) => sum + tax!);

    // Create the updated NewOrderModel
    final updatedNewProducts = NewOrderModel(
      products: updatedProducts,
      tableId: state.selectedTable!.id.toString(),
      totalTax: totalTax.toInt(),
      totalPrice: state.selectedTable!.totalPrice ?? 0.0,
    );
    for (var element in updatedNewProducts.products) {
      for (var x in element.options) {
        appLogger.warning("TAG", x.name.toString());
        for (var z in x.items) {
          appLogger.warning("TAG", z.itemName.toString());
        }
      }
    }

    // Emit the updated state with the new order products
    emit(state.copyWith(
      newOrderProducts: updatedProducts,
      newProducts: updatedNewProducts,
    ));

    calculateTotalTax();
    calculateSubPrice();
    calculateTotalPrice();
  }

  /// Remove New Order Product
  void removeNewOrderProduct(OrderProductModel product) {
    final updatedProductsList = List<OrderProductModel>.from(state.newProducts.products);
    updatedProductsList.remove(product);

    // Durum güncellemesi ve hesaplama işlemleri
    emit(state.copyWith(
      newProducts: state.newProducts.copyWith(products: updatedProductsList),
      newOrderProducts: List<OrderProductModel>.from(updatedProductsList),
    ));

    // Ürün çıkarıldıktan sonra fiyat ve vergi hesaplamaları
    calculateTotalTax();
    calculateSubPrice();
    calculateTotalPrice();
  }

  /// Remove Item From Product
  void removeItemFromProduct(OrderProductModel product, Item itemToRemove) {
    double itemTax = 0.0;

    // Item'in vergisini hesaplarken eğer vatRate 0'dan büyükse dikkate alın.
    if ((itemToRemove.vatRate ?? 0) > 0) {
      itemTax = itemToRemove.price! * (itemToRemove.vatRate! / 100);
      double newValue = product.tax ?? 0;
      newValue -= itemTax; // Ürün vergisini item vergisi kadar düşür
    }

    // Güncellenmiş item listesi ile options'ı oluşturun
    final updatedOptions = product.options.map((option) {
      final updatedItems = List<Item>.from(option.items)..remove(itemToRemove);
      return option.copyWith(items: updatedItems);
    }).toList();

    // Güncellenmiş options ve fiyat ile yeni bir OrderProductModel oluşturun
    final updatedProduct = product.copyWith(
      options: updatedOptions,
    );

    // newProducts listesini güncellemek için mevcut listenin kopyasını oluşturun
    final updatedProductsList = List<OrderProductModel>.from(state.newProducts.products);

    // Güncellenmiş ürünü orijinal ürün ile değiştirin
    final productIndex = updatedProductsList.indexOf(product);
    if (productIndex != -1) {
      updatedProductsList[productIndex] = updatedProduct;
    }

    // newOrderProducts listesini güncellemek için de benzer şekilde işlem yapın
    final updatedNewOrderProducts = List<OrderProductModel>.from(state.newOrderProducts);
    final orderProductIndex = updatedNewOrderProducts.indexOf(product);
    if (orderProductIndex != -1) {
      updatedNewOrderProducts[orderProductIndex] = updatedProduct;
    }

    // Durum güncellemesi
    emit(state.copyWith(
      newProducts: state.newProducts.copyWith(products: updatedProductsList),
      newOrderProducts: updatedNewOrderProducts,
    ));

    // Ürün çıkarıldıktan sonra fiyat ve vergi hesaplamaları
    calculateSubPrice();
    calculateTotalPrice();
    calculateTotalTax(); // Vergi güncellemelerini burada çağırarak hesaplayın
  }

  /// clear new order products LIST
  void clearNewOrderProducts() => emit(state.copyWith(
      newOrderProducts: [], totalPrice: 0, subPrice: 0, newProducts: NewOrderModel.empty()));

  /// calculate Sub total price(without tax)
  void calculateSubPrice() {
    double newOrderProductPrice =
        state.newOrderProducts.fold(0.0, (sum, product) => sum + product.price!) +
            state.selectedTable!.remainingPrice!;
    double itemsPrice = 0.0;
    for (var element in state.newProducts.products) {
      for (var option in element.options) {
        for (var item in option.items) {
          itemsPrice += item.price ?? 0;
        }
      }
    }

    newOrderProductPrice += itemsPrice;
    appLogger.info('Table CUBIT SUB PRICE', itemsPrice.toString());
    emit(state.copyWith(subPrice: newOrderProductPrice));
  }

  /// calculate total price
  double calculateTotalPrice() {
    // double newOrderProductPrice = state.newOrderProducts.fold(0.0, (sum, product) {
    //   double productTotal = product.price * (1 + (product.tax / product.quantity) / 100);
    //   return sum + productTotal;
    // });
    appLogger.info('Table CUBIT subPrice PRICE', state.subPrice.toString());
    double finalTotal = state.subPrice + calculateTotalTax();
    appLogger.info('Table CUBIT TOTAL PRICE', finalTotal.toString());

    emit(state.copyWith(totalPrice: finalTotal));

    return finalTotal;
  }

  /// calculate total tax
  double calculateTotalTax() {
    double totalTax = 0.0;
    double newProductsTax = 0.0;
    // Calculate tax of products in existing orders
    if (state.selectedTable != null && state.selectedTable!.orders.isNotEmpty) {
      totalTax = state.selectedTable?.totalTax ?? 0.0;
    }
    newProductsTax = state.newProducts.products.fold(0.0, (sum, product) {
      return sum + (product.tax ?? 0);
    });

    return totalTax + newProductsTax;
  }

  /// set selected move table
  Future<void> setSelectedMoveTable(TableModel? table) async {
    selectedMoveTable = table;
    emit(state.copyWith(selectedMoveTable: selectedMoveTable));
  }

  /// set selected products
  Future<void> setSelectedProducts(List<ProductModel> list) async {
    emit(state.copyWith(selectProducts: list));
  }

  /// set selected option
  Future<void> setSelectedOption(OptionsModel option) async {
    emit(state.copyWith(optionSelected: option));
  }
}
