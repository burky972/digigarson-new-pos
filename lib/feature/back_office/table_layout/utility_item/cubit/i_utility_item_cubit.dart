import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/cubit/utility_item_state.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/model/utility_item_request_model.dart';
import 'package:core/core.dart';

abstract class IUtilityItemCubit extends BaseCubit<UtilityItemState> {
  IUtilityItemCubit(super.initialState);
  Future<bool> getUtilityItem();
  Future<bool> postUtilityItem({required UtilityItemRequestModel utilityModel});
  Future<bool> deleteUtilityItem({required String itemId});
}
