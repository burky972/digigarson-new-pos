import 'package:a_pos_flutter/feature/home/table/cubit/i_table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/feature/home/table/service/i_table_service.dart';
import 'package:a_pos_flutter/feature/home/table/service/table_service.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';

class TableCubit extends ITableCubit {
  TableCubit() : super(TableState.initial()) {
    init();
  }

  late ITableService _tableService;
  final TAG = "TableCubit";
  List<TableModel> tableModel = [];
  @override
  void init() {
    _tableService = TableService();
  }

  @override
  Future getTable(UserModel userModel) async {
    tableModel.clear();
    emit(state.copyWith(states: TableStates.loading, tableModel: tableModel));
    final response = await _tableService.getTable(userModel: userModel);
    response.fold((_) => emit(state.copyWith(states: TableStates.error)), (r) {
      r.data.forEach((table) {
        List<Product> listProduct = [];
        TableModel tableModel_ = TableModel.fromJson(table);
        if (tableModel_.orders.isNotEmpty) {
          for (var order in tableModel_.orders) {
            for (var product in order.products) {
              listProduct.add(product!);
            }
          }
          listProduct.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
          if (listProduct.isNotEmpty) {
            tableModel_.lastOrderDate = listProduct.first.createdAt;
          }
        }
        tableModel_.section != null ? tableModel.add(tableModel_) : null;
      });

      emit(state.copyWith(tableModel: tableModel, states: TableStates.completed));
    });
  }

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
          tableModel_.lastOrderDate = listProduct.first.createdAt;
        }
      }
      tableModel_.section != null ? tableModel.add(tableModel_) : null;
    }
    emit(state.copyWith(tableModel: tableModel));
  }
}
