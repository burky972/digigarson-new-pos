// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/model/utility_item_model.dart';
import 'package:core/core.dart';

class UtilityItemState implements BaseState {
  const UtilityItemState({required this.states, this.utilityBySectionList, this.allUtilityItem});

  final UtilityItemStates states;
  final Map<String, List<UtilityItemModel>>? utilityBySectionList;
  final List<UtilityItemModel>? allUtilityItem;

  factory UtilityItemState.initial() {
    return const UtilityItemState(
      states: UtilityItemStates.initial,
      utilityBySectionList: null,
      allUtilityItem: [],
    );
  }

  @override
  List<Object?> get props => [states, utilityBySectionList, allUtilityItem];

  @override
  bool? get stringify => true;

  UtilityItemState copyWith({
    UtilityItemStates? states,
    Map<String, List<UtilityItemModel>>? utilityBySectionList,
    List<UtilityItemModel>? allUtilityItem,
  }) {
    return UtilityItemState(
      states: states ?? this.states,
      utilityBySectionList: utilityBySectionList ?? this.utilityBySectionList,
      allUtilityItem: allUtilityItem ?? this.allUtilityItem,
    );
  }
}

enum UtilityItemStates { initial, loading, success, failure }
