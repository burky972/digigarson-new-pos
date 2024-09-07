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
import 'package:a_pos_flutter/product/widget/invoices/invoice_widget.dart';
import 'package:a_pos_flutter/product/widget/printer/printer_widget.dart';
import 'package:core/base/exception/exception.dart';
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
  List<String> newAddedTableIds = [];
  String checkoutInput = '';

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
  void addIdToNewAddedTableIds(String id) => newAddedTableIds.add(id);

  /// get table api request
  @override
  Future getTable() async {
    tableModel.clear();
    emit(state.copyWith(states: TableStates.loading, tableModel: tableModel));
    final response = await _tableService.getTable();
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
              } else {}
            }
          }
          listProduct.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
          if (listProduct.isNotEmpty) {
            tableModel_ = tableModel_.copyWith(lastOrderDate: listProduct.first.createdAt);
          }
        }
        if (tableModel_.section != null) {
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
  Future postTable(TableRequestModel tableModel) async {
    bool alreadyExists = false;

    // We are checking if the utility items already exist or not.
    for (MapEntry<String, List<TableModel>> entry in state.tablesBySectionList?.entries ?? {}) {
      final sectionId = entry.key;
      final utilityItems = entry.value;
      for (var utilityItem in utilityItems) {
        if (sectionId == tableModel.section &&
            tableModel.tableType == utilityItem.tableType &&
            tableModel.title == utilityItem.title &&
            tableModel.location?.xCoordinate == utilityItem.location?.xCoordinate &&
            tableModel.location?.yCoordinate == utilityItem.location?.yCoordinate) {
          alreadyExists = true;
          break;
        }
      }
      if (alreadyExists) break;
    }

    // If it already exists, return without making a request.
    if (alreadyExists) {
      return false;
    }
    emit(state.copyWith(states: TableStates.loading));
    final response = await _tableService.postTable(tableModel: tableModel);
    response.fold((_) => emit(state.copyWith(states: TableStates.error)), (r) async {
      await getTable();
      emit(state.copyWith(states: TableStates.completed));
    });
  }

  /// delete all tables
  @override
  Future<bool> deleteAllTables() async {
    emit(state.copyWith(states: TableStates.loading));
    final response = await _tableService.deleteAllTables();
    response.fold((err) {
      appLogger.info('Table CUBIT DELETE ALL TABLES', '${err.message} ${err.statusCode}');
      emit(state.copyWith(
          states: TableStates.error,
          exception: () => AppException(message: err.message, statusCode: err.statusCode)));
    }, (r) async {
      appLogger.info('Table CUBIT DELETE ALL TABLES', 'Success');
      emit(state.copyWith(states: TableStates.completed));
    });
    return response.isRight();
  }

  /// set selected new product
  void setSelectedEditProduct(OrderProductModel? newProduct) {
    emit(state.copyWith(newOrderProduct: () => newProduct));
  }

  /// update isDeletedSuccess
  void updateDeletedSuccess(bool value) => emit(state.copyWith(isDeleteSuccess: value));

  /// Delete table api request
  @override
  Future<bool> deleteTable(String tableId) async {
    appLogger.info('Table CUBIT DELETE TABLE', tableId);
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
  Future<bool> postTableNewOrder(BuildContext context) async {
    appLogger.info('Table CUBIT POST TABLE NEW ORDER', state.newProducts.toJson().toString());
    bool? isSuccess;
    emit(state.copyWith(states: TableStates.loading));
    final response = await _tableService.postTableNewOrder(
        newOrderModel: state.newProducts, tableId: state.selectedTable!.id.toString());

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
    deletedTableIds.clear();
    tablesBySection.clear();
    newAddedTableIds.clear();
    emit(TableState.initial());
  }

  /// set selected table
  Future<void> setSelectedTable(TableModel table) async {
    clearPriceInfos();
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
        state.newOrderProducts.fold(0.0, (sum, product) => sum + (product.price ?? 0)) +
            (state.selectedTable!.totalPrice ?? 0);
    double itemsPrice = 0.0;
    for (var element in state.newProducts.products) {
      for (var option in element.options) {
        for (var item in option.items) {
          itemsPrice += item.price ?? 0;
        }
      }
    }

    newOrderProductPrice += itemsPrice;

    emit(state.copyWith(subPrice: newOrderProductPrice));
  }

  clearPriceInfos() => emit(state.copyWith(totalPrice: 0, subPrice: 0, newOrderProducts: []));

  /// calculate total price
  double calculateTotalPrice() {
    double finalTotal = state.subPrice + calculateTotalTax();
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
      return sum + ((product.price ?? 0) * ((product.tax ?? 0) / 100));
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

  ///---------------------------------CHECKOUT FUNCTIONS -----------------------------------

  /// set new order products for checkOut view
  void setInitialCheckoutProducts() {
    if (state.selectedTable == null || state.selectedTable!.orders.isEmpty) {
      appLogger.error(TAG, 'Table CUBIT SET INITIAL PRODUCTS: No selected table or orders');
      return;
    }
    List<Product> initialProducts = [];
    for (var order in state.selectedTable!.orders) {
      initialProducts.addAll(order.products
          .where((product) => product != null && product.quantity != product.paidQuantity)
          .whereType<Product>());
    }

    emit(state.copyWith(
        willPaidProducts: initialProducts,
        paidProducts: [],
        totalDue: 0.0,
        checkOutRemainingPrice: state.selectedTable!.remainingPrice ?? 0.0));
  }

  /// add product to paid products in checkout view
  void addProductToPaidProducts(Product product) {
    double newTotalDue = state.totalDue + product.priceAfterTax!;
    double newRemainingPrice = state.checkOutRemainingPrice - product.priceAfterTax!;
    List<Product> newPaidProducts = List.from(state.paidProducts ?? []);
    List<Product> newWillPaidProducts = List.from(state.willPaidProducts ?? []);

    newPaidProducts.add(product);
    newWillPaidProducts.remove(product);
    if (newTotalDue > state.selectedTable!.remainingPrice!) {
      emit(state.copyWith(
        paidProducts: newPaidProducts,
        willPaidProducts: newWillPaidProducts,
        totalDue: state.selectedTable!.remainingPrice!,
        checkOutRemainingPrice: 0,
      ));
    } else {
      emit(state.copyWith(
        paidProducts: newPaidProducts,
        willPaidProducts: newWillPaidProducts,
        totalDue: newTotalDue,
        checkOutRemainingPrice: newRemainingPrice,
      ));
    }
  }

  /// delete product from paid products in checkout view
  void deleteOrderToPaidProducts(Product product) {
    List<Product> newPaidProducts = List.from(state.paidProducts ?? []);
    List<Product> newWillPaidProducts = List.from(state.willPaidProducts ?? []);
    newPaidProducts.remove(product);
    newWillPaidProducts.add(product);

    double totalPaidProductsPrice =
        newPaidProducts.fold(0, (sum, item) => sum + (item.priceAfterTax ?? 0));

    double newRemainingPrice = state.selectedTable?.remainingPrice ?? 0 + product.priceAfterTax!;

    double newTotalDue = totalPaidProductsPrice <= state.selectedTable!.remainingPrice!
        ? totalPaidProductsPrice
        : state.selectedTable?.remainingPrice ?? 0;
    double lastRemainingPrice = newRemainingPrice > state.selectedTable!.remainingPrice!
        ? 0.0
        : (state.selectedTable!.remainingPrice! - newTotalDue);
    emit(state.copyWith(
      paidProducts: newPaidProducts,
      willPaidProducts: newWillPaidProducts,
      totalDue: newTotalDue,
      checkOutRemainingPrice: lastRemainingPrice,
    ));
  }

  /// set total due
  void setTotalDue(double totalDue) {
    setInitialCheckoutProducts();
    double newRemainingPrice = state.checkOutRemainingPrice - totalDue;
    emit(state.copyWith(totalDue: totalDue, checkOutRemainingPrice: newRemainingPrice));
  }

  /// set checkout input
  void setCheckoutInput(String value) {
    final newInput = checkoutInput + value;
    final remainingPrice = state.selectedTable?.remainingPrice ?? 0;

    if (double.tryParse(newInput) != null) {
      final inputAmount = double.parse(newInput);
      if (inputAmount <= remainingPrice) {
        checkoutInput = newInput;
        emit(state.copyWith(checkoutInput: checkoutInput, totalDue: inputAmount));
      } else {
        // If the entered value is greater than the remaining amount, set it to the remaining amount
        checkoutInput = remainingPrice.toStringAsFixed(2);
        emit(state.copyWith(checkoutInput: checkoutInput, totalDue: remainingPrice));
      }
    }
  }

  /// clear checkout input
  void clearCheckoutInput() {
    checkoutInput = '';
    emit(state.copyWith(checkoutInput: ''));
  }
}
