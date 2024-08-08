import 'package:a_pos_flutter/feature/home/printer/cubit/printer_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/i_table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/feature/home/table/service/i_table_service.dart';
import 'package:a_pos_flutter/feature/home/table/service/table_service.dart';
import 'package:a_pos_flutter/product/global/model/branch/branch_model.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/global/model/print/print_invoice_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/widget/invoices/invoice_widget.dart';
import 'package:a_pos_flutter/product/widget/printer/printer_widget.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableCubit extends ITableCubit {
  TableCubit() : super(TableState.initial()) {
    init();
  }

  late ITableService _tableService;
  final TAG = "TableCubit";
  List<TableModel> tableModel = [];
  NewOrderModel newProducts = NewOrderModel(tableId: "", products: []);
  TableModel? selectedTable;
  TableModel? selectedMoveTable;
  ProductsModel? newProduct;
  String optionSelectedId = "";
  @override
  void init() {
    _tableService = TableService();
  }

  /// get table api request
  @override
  Future getTable(UserModel userModel) async {
    tableModel.clear();
    emit(state.copyWith(states: TableStates.loading, tableModel: tableModel));
    final response = await _tableService.getTable(userModel: userModel);
    response.fold((_) => emit(state.copyWith(states: TableStates.error)), (r) {
      r.data.forEach((table) {
        List<Product> listProduct = [];
        TableModel tableModel_ = TableModel.fromJson(table);
        APosLogger.instance!.info('Table CUBIT GET TABLE', tableModel_.toJson().toString());
        if (tableModel_.orders.isNotEmpty) {
          for (var order in tableModel_.orders) {
            for (var product in order.products) {
              listProduct.add(product!);
            }
          }
          listProduct.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
          if (listProduct.isNotEmpty) {
            //TODO: ADD LAST ORDER DATE TO MODEL
            // tableModel_.lastOrderDate = listProduct.first.createdAt;
          }
        }
        tableModel_.section != null ? tableModel.add(tableModel_) : null;
      });

      emit(state.copyWith(tableModel: tableModel, states: TableStates.completed));
    });
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
          // tableModel_.lastOrderDate = listProduct.first.createdAt;
        }
      }
      tableModel_.section != null ? tableModel.add(tableModel_) : null;
    }
    emit(state.copyWith(tableModel: tableModel));
  }

  Future<bool> postTableNewOrder(BuildContext context, UserModel userModel) async {
    emit(state.copyWith(states: TableStates.loading));
    final response = await _tableService.postTableNewOrder(
        userModel: userModel,
        newOrderModel: state.newProducts,
        tableId: state.selectedTable!.id.toString());

    response.fold((_) {
      emit(state.copyWith(states: TableStates.error));
      return false;
    }, (r) {
      selectedTable!.checkNo = TableModel.fromJson(r.data).orders.last.orderNum;
      emit(state.copyWith(selectedTable: selectedTable)); //! check here later!

      context.read<PrinterCubit>().customPrinterList.forEach(
        (customPrinterList) {
          Iterable<NewOrderProduct> products = state.newProducts.products.where((o) =>
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
      newProducts = NewOrderModel(tableId: "", products: []);

      emit(state.copyWith(newProducts: newProducts));
      return true;
    });
    return false;
  }

  Future<void> setSelectedTable(TableModel table) async {
    newProducts = NewOrderModel(tableId: table.id.toString(), products: []);
    APosLogger.instance!.warning('TABLE: ', table.toJson().toString());
    emit(state.copyWith(
        newProducts: newProducts,
        selectProducts: [],
        selectedTable: table,
        originalOrderProduct: null,
        newOrderProductAmount: 0));
    APosLogger.instance!.warning('TABLE: ', state.selectedTable.toString());
  }

  Future<void> setSelectedMoveTable(TableModel? table) async {
    selectedMoveTable = table;
    emit(state.copyWith(selectedMoveTable: selectedMoveTable));
  }

  Future<void> setSelectedProducts(List<Product> list) async {
    emit(state.copyWith(selectProducts: list));
  }

  Future<void> setSelectedOption(OptionsModel option) async {
    emit(state.copyWith(optionSelected: option));
  }
}
