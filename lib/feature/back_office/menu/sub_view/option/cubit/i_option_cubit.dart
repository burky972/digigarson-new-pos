import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/cubit/option_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/cubit/option_state.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_request_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

abstract class IOptionCubit extends BaseCubit<OptionState> {
  IOptionCubit(super.initialState);
  OptionModel? get option;
  Future getOptions();
  Future postOptions({required OptionRequestModel optionModel});
  Future putOptions({required OptionModel optionModel, required String optionId});
  Future patchOptions({required String optionId});
  void setSelectedOption(OptionModel option);
  setSelectedItem(Item item);
  void updateOptionNameOrDesc(String value, {bool isName});
  Future<void> addNewItem();
  void updateSelectedItemValue(UpdatedItemValue updatedItemValue, String? value);
  String generateUniqueId();
  Future<void> addNewOption();
  Future<void> saveChanges();
  Future<void> saveItemChanges();
}
