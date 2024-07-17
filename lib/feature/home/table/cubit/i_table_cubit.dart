import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';

import 'package:a_pos_flutter/product/global/model/user_model.dart';

import 'package:core/core.dart';

abstract class ITableCubit extends BaseCubit<TableState> {
  ITableCubit(super.initialState);
  Future getTable(UserModel userModel);
  Future<void> setNewTableList(List<TableModel> newTableList);
}
