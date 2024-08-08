// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    required this.newOrderProductEdit,
    required this.originalOrderProduct,
    required this.newOrderProductAmount,
    required this.newOrderProductQuantity,
    required this.selectedProductItemsTotalPrice,
    required this.optionsList,
    required this.selectProducts,
  });

  factory TableState.initial() {
    return TableState(
      states: TableStates.initial,
      tableModel: const [],
      selectedTable: null,
      selectedMoveTable: null,
      newProducts: NewOrderModel(tableId: "", products: []),
      newProduct: null,
      optionSelectedId: '',
      optionSelected: null,
      optionItem: const [],
      prices: null,
      newOrderProduct: null,
      newOrderProductEdit: null,
      originalOrderProduct: null,
      newOrderProductAmount: 1.0,
      newOrderProductQuantity: 1.0,
      selectedProductItemsTotalPrice: 0.0,
      optionsList: const [],
      selectProducts: const [],
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
  final NewOrderProduct? newOrderProduct;
  final NewOrderProduct? newOrderProductEdit;
  final NewOrderProduct? originalOrderProduct;
  final double newOrderProductAmount;
  final double newOrderProductQuantity;
  final double selectedProductItemsTotalPrice;
  final List<NewOrderOption> optionsList;
  final List<Product> selectProducts;

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
        optionItem,
        prices,
        newOrderProduct,
        originalOrderProduct,
        newOrderProductAmount,
        newOrderProductQuantity,
        selectedProductItemsTotalPrice,
        optionsList,
        selectProducts,
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
    NewOrderProduct? newOrderProduct,
    NewOrderProduct? newOrderProductEdit,
    NewOrderProduct? originalOrderProduct,
    double? newOrderProductAmount,
    double? newOrderProductQuantity,
    double? selectedProductItemsTotalPrice,
    List<NewOrderOption>? optionsList,
    List<Product>? selectProducts,
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
      prices: prices ?? this.prices,
      newOrderProduct: newOrderProduct ?? this.newOrderProduct,
      newOrderProductEdit: newOrderProductEdit ?? this.newOrderProductEdit,
      originalOrderProduct: originalOrderProduct ?? this.originalOrderProduct,
      newOrderProductAmount: newOrderProductAmount ?? this.newOrderProductAmount,
      newOrderProductQuantity: newOrderProductQuantity ?? this.newOrderProductQuantity,
      selectedProductItemsTotalPrice:
          selectedProductItemsTotalPrice ?? this.selectedProductItemsTotalPrice,
      optionsList: optionsList ?? this.optionsList,
      selectProducts: selectProducts ?? this.selectProducts,
    );
  }
}

enum TableStates { initial, loading, completed, error }
