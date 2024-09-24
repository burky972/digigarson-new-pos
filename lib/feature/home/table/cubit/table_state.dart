// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/model/product_model.dart';
import 'package:core/core.dart';

import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/global/model/branch/branch_model.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';

class TableState extends BaseState {
  const TableState({
    required this.states,
    required this.tableModel,
    required this.selectedTable,
    required this.selectedMoveTable,
    required this.newProducts,
    required this.newProduct,
    required this.optionSelectedId,
    required this.optionSelected,
    required this.optionItem,
    required this.prices,
    required this.newOrderProduct,
    required this.newOrderProducts,
    required this.newOrderProductEdit,
    required this.originalOrderProduct,
    required this.newOrderProductAmount,
    required this.newOrderProductQuantity,
    required this.selectedProductItemsTotalPrice,
    required this.selectProducts,
    required this.tablesBySectionList,
    required this.isTableSaving,
    required this.isDeleteSuccess,
    required this.totalPrice,
    required this.subPrice,
    required this.exception,
    required this.paidProducts,
    required this.willPaidProducts,
    required this.totalDue,
    required this.checkOutRemainingPrice,
    required this.checkoutInput,
    required this.allProductsList,
    required this.isQuickService,
    required this.serveList,
    required this.isServeExpanded,
    required this.isServiceFeeExpanded,
    required this.isCoverExpanded,
  });

  factory TableState.initial() {
    return TableState(
      states: TableStates.initial,
      tableModel: const [],
      selectedTable: null,
      selectedMoveTable: null,
      newProducts: NewOrderModel(tableId: "", products: const [], totalTax: 0, totalPrice: 0),
      newProduct: null,
      subPrice: 0.0,
      optionSelectedId: '',
      optionSelected: null,
      optionItem: const [],
      prices: null,
      newOrderProduct: null,
      newOrderProducts: const [],
      newOrderProductEdit: null,
      originalOrderProduct: null,
      newOrderProductAmount: 1.0,
      newOrderProductQuantity: 1.0,
      selectedProductItemsTotalPrice: 0.0,
      selectProducts: const [],
      tablesBySectionList: const {},
      isTableSaving: false,
      isDeleteSuccess: false,
      totalPrice: 0.0,
      exception: null,
      paidProducts: const [],
      willPaidProducts: const [],
      totalDue: 0.0,
      checkOutRemainingPrice: 0.0,
      checkoutInput: '0.0',
      allProductsList: const [],
      isQuickService: false,
      serveList: const [],
      isServeExpanded: false,
      isServiceFeeExpanded: false,
      isCoverExpanded: false,
    );
  }

  final TableStates states;
  final List<TableModel> tableModel;
  final TableModel? selectedTable;
  final TableModel? selectedMoveTable;
  final NewOrderModel newProducts;
  final ProductsModel? newProduct;
  final String optionSelectedId;
  final OptionsModel? optionSelected;
  final List<Item> optionItem;
  final Prices? prices;
  final double totalPrice;
  final double subPrice;
  final OrderProductModel? newOrderProduct;
  final OrderProductModel? newOrderProductEdit;
  final OrderProductModel? originalOrderProduct;
  final List<OrderProductModel> newOrderProducts;
  final double newOrderProductAmount;
  final double newOrderProductQuantity;
  final double selectedProductItemsTotalPrice;
  final List<ProductModel> selectProducts;
  final Map<String, List<TableModel>>? tablesBySectionList;
  final bool? isTableSaving;
  final bool? isDeleteSuccess;
  final AppException? exception;
  final List<Product>? paidProducts;
  final List<Product>? willPaidProducts;
  final double totalDue;
  final double checkOutRemainingPrice;
  final String checkoutInput;
  final List<Product> allProductsList;
  final List<Product> serveList;
  final bool isQuickService;
  final bool isServeExpanded;
  final bool isServiceFeeExpanded;
  final bool isCoverExpanded;

  @override
  List<Object?> get props => [
        states,
        tableModel,
        selectedTable,
        selectedMoveTable,
        newProducts,
        newProduct,
        optionSelectedId,
        optionSelected,
        totalPrice,
        subPrice,
        optionItem,
        prices,
        newOrderProduct,
        newOrderProducts,
        originalOrderProduct,
        newOrderProductAmount,
        newOrderProductQuantity,
        selectedProductItemsTotalPrice,
        selectProducts,
        tablesBySectionList,
        isTableSaving,
        isDeleteSuccess,
        exception,
        paidProducts,
        willPaidProducts,
        totalDue,
        checkOutRemainingPrice,
        checkoutInput,
        allProductsList,
        isQuickService,
        serveList,
        isServeExpanded,
        isServiceFeeExpanded,
        isCoverExpanded
      ];

  TableState copyWith({
    TableStates? states,
    List<TableModel>? tableModel,
    TableModel? selectedTable,
    TableModel? selectedMoveTable,
    NewOrderModel? newProducts,
    ProductsModel? newProduct,
    String? optionSelectedId,
    OptionsModel? optionSelected,
    List<Item>? optionItem,
    Prices? prices,
    double? totalPrice,
    double? subPrice,
    OrderProductModel? Function()? newOrderProduct,
    List<OrderProductModel>? newOrderProducts,
    OrderProductModel? newOrderProductEdit,
    OrderProductModel? originalOrderProduct,
    double? newOrderProductAmount,
    double? newOrderProductQuantity,
    double? selectedProductItemsTotalPrice,
    List<ProductModel>? selectProducts,
    Map<String, List<TableModel>>? Function()? tablesBySectionList,
    bool? isTableSaving,
    bool? isDeleteSuccess,
    AppException? Function()? exception,
    List<Product>? paidProducts,
    List<Product>? willPaidProducts,
    double? totalDue,
    double? checkOutRemainingPrice,
    String? checkoutInput,
    List<Product>? allProductsList,
    bool? isQuickService,
    List<Product>? serveList,
    bool? isServeExpanded,
    bool? isServiceFeeExpanded,
    bool? isCoverExpanded,
  }) {
    return TableState(
      states: states ?? this.states,
      tableModel: tableModel ?? this.tableModel,
      selectedTable: selectedTable ?? this.selectedTable,
      selectedMoveTable: selectedMoveTable ?? this.selectedMoveTable,
      newProducts: newProducts ?? this.newProducts,
      newProduct: newProduct ?? this.newProduct,
      optionSelectedId: optionSelectedId ?? this.optionSelectedId,
      optionSelected: optionSelected ?? this.optionSelected,
      optionItem: optionItem ?? this.optionItem,
      totalPrice: totalPrice ?? this.totalPrice,
      subPrice: subPrice ?? this.subPrice,
      prices: prices ?? this.prices,
      newOrderProduct: newOrderProduct != null ? newOrderProduct() : this.newOrderProduct,
      newOrderProducts: newOrderProducts ?? this.newOrderProducts,
      newOrderProductEdit: newOrderProductEdit ?? this.newOrderProductEdit,
      originalOrderProduct: originalOrderProduct ?? this.originalOrderProduct,
      newOrderProductAmount: newOrderProductAmount ?? this.newOrderProductAmount,
      newOrderProductQuantity: newOrderProductQuantity ?? this.newOrderProductQuantity,
      selectedProductItemsTotalPrice:
          selectedProductItemsTotalPrice ?? this.selectedProductItemsTotalPrice,
      selectProducts: selectProducts ?? this.selectProducts,
      tablesBySectionList:
          tablesBySectionList != null ? tablesBySectionList() : this.tablesBySectionList,
      isTableSaving: isTableSaving ?? this.isTableSaving,
      isDeleteSuccess: isDeleteSuccess ?? this.isDeleteSuccess,
      exception: exception != null ? exception() : this.exception,
      paidProducts: paidProducts ?? this.paidProducts,
      willPaidProducts: willPaidProducts ?? this.willPaidProducts,
      totalDue: totalDue ?? this.totalDue,
      checkOutRemainingPrice: checkOutRemainingPrice ?? this.checkOutRemainingPrice,
      checkoutInput: checkoutInput ?? this.checkoutInput,
      allProductsList: allProductsList ?? this.allProductsList,
      isQuickService: isQuickService ?? this.isQuickService,
      serveList: serveList ?? this.serveList,
      isServeExpanded: isServeExpanded ?? this.isServeExpanded,
      isServiceFeeExpanded: isServiceFeeExpanded ?? this.isServiceFeeExpanded,
      isCoverExpanded: isCoverExpanded ?? this.isCoverExpanded,
    );
  }
}

enum TableStates { initial, loading, completed, error }
