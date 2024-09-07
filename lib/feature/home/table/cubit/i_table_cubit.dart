import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_request_model.dart';
import 'package:core/core.dart';

abstract class ITableCubit extends BaseCubit<TableState> {
  ITableCubit(super.initialState);
  Future getTable();
  Future postTable(TableRequestModel tableModel);
  Future<bool> deleteTable(String tableId);
  Future<void> setNewTableList(List<TableModel> newTableList);
  void changeIsTableSaving(bool value);
  Future<bool> deleteAllTables();
}
