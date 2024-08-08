import 'package:core/base/cubit/base_cubit.dart';
import 'package:a_pos_flutter/product/global/cubit/global_state.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';

abstract class IGlobalCubit extends BaseCubit<GlobalState> {
  IGlobalCubit(super.initialState);
  void setUser(UserModel user);
  void setSelectedTableName(String selectedTableName);
  UserModel get user;
  String get selectedTableName;
}
