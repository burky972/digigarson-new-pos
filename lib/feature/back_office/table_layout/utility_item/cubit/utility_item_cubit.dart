import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/cubit/i_utility_item_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/cubit/utility_item_state.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/model/utility_item_model.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/model/utility_item_request_model.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/service/i_utility_item_service.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/service/utility_item_service.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:core/cache/shared_manager.dart';

class UtilityItemCubit extends IUtilityItemCubit {
  UtilityItemCubit() : super(UtilityItemState.initial()) {
    init();
  }
  Map<String, List<UtilityItemModel>> sectionMap = {};
  List<String> deletedUtilityItemIds = [];
  void reset() {
    deletedUtilityItemIds.clear();
    sectionMap.clear();
    sectionMap = {};
    emit(UtilityItemState.initial());
  }

  final IUtilityItemService _service = UtilityItemService();
  void addIdToDeletedUtilityItemIds(String id) => deletedUtilityItemIds.add(id);
  @override
  Future<void> init() async {
    appLogger.info('UTILITY ITEM CUBIT', 'INITIALIZED!!');
    await getUtilityItem();
  }

  /// Group utility items by section id

  Future<Map<String, List<UtilityItemModel>>> groupItemsBySectionId(
      List<UtilityItemModel> items) async {
    sectionMap = {};
    for (var item in items) {
      final sectionId = item.section;
      if (sectionId != null) {
        if (!sectionMap.containsKey(sectionId)) {
          sectionMap[sectionId] = [];
        }
        sectionMap[sectionId]!.add(item);
      }
    }
    return sectionMap;
  }

  @override
  Future<bool> getUtilityItem() async {
    final response = await _service.getUtilityItem();
    sectionMap.clear();
    return response.fold(
      (failure) {
        emit(state.copyWith(states: UtilityItemStates.failure));
        return false;
      },
      (success) async {
        final List<UtilityItemModel> typedItems = (success.data as List<dynamic>?)
                ?.map((item) => UtilityItemModel.fromJson(item as Map<String, dynamic>))
                .toList() ??
            [];

        final groupedItems = await groupItemsBySectionId(typedItems);
        emit(state.copyWith(
          states: UtilityItemStates.success,
          utilityBySectionList: groupedItems,
          allUtilityItem: typedItems,
        ));
        return true;
      },
    );
  }

  /// post utility items to service
  @override
  Future<bool> postUtilityItem({required UtilityItemRequestModel utilityModel}) async {
    bool alreadyExists = false;

    // Eğer utilityBySectionList boşsa, kontrolü atla
    if (state.utilityBySectionList == null) {
      return false; // Liste yoksa zaten mevcut olamaz
    }

    // Tüm utility items'ları kontrol et
    for (MapEntry<String, List<UtilityItemModel>> entry in state.utilityBySectionList!.entries) {
      final sectionId = entry.key;
      final utilityItems = entry.value;

      for (var utilityItem in utilityItems) {
        // Tüm alanların eşleştiğinden emin olun
        if (sectionId == utilityModel.section &&
            utilityModel.type == utilityItem.type &&
            utilityModel.location?.xCoordinate == utilityItem.location?.xCoordinate &&
            utilityModel.location?.yCoordinate == utilityItem.location?.yCoordinate) {
          alreadyExists = true;
          break;
        }
      }

      if (alreadyExists) break;
    }

    // Eğer zaten mevcutsa, istek yapmadan geri dön
    if (alreadyExists) {
      return false;
    }

    emit(state.copyWith(states: UtilityItemStates.loading));
    final response = await _service.postUtilityItem(utilityModel: utilityModel);
    response.fold(
      (l) => emit(state.copyWith(states: UtilityItemStates.failure)),
      (res) async {
        await getUtilityItem();
        emit(state.copyWith(states: UtilityItemStates.success));
      },
    );

    return response.isRight();
  }

  @override
  Future<bool> deleteUtilityItem({required String itemId}) async {
    appLogger.info('Table CUBIT LOAD ALL TABLES 1', itemId);
    emit(state.copyWith(states: UtilityItemStates.loading));
    final response = await _service.deleteUtilityItem(itemId: itemId);
    response.fold(
      (l) {
        emit(state.copyWith(states: UtilityItemStates.failure));
      },
      (res) async {
        await SharedManager.instance.removeValue(itemId);
        emit(state.copyWith(states: UtilityItemStates.success));
      },
    );
    return response.isRight();
  }

  @override
  Future<bool> updateUtilityItem(
      {required String itemId, required UtilityItemUpdateRequestModel utilityModel}) async {
    emit(state.copyWith(states: UtilityItemStates.loading));
    final response = await _service.putUtilityItem(itemId: itemId, utilityModel: utilityModel);
    response.fold(
      (l) => emit(state.copyWith(states: UtilityItemStates.failure)),
      (res) async {
        await getUtilityItem();
        emit(state.copyWith(states: UtilityItemStates.success));
      },
    );
    return response.isRight();
  }
}
