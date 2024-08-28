import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

class OptionState extends BaseState {
  const OptionState({
    required this.states,
    required this.option,
    required this.selectedOption,
    required this.selectedItem,
    required this.allOptions,
    required this.allItems,
  });

  factory OptionState.initial() {
    return const OptionState(
      states: OptionStates.initial,
      option: null,
      selectedOption: null,
      selectedItem: null,
      allOptions: [],
      allItems: [],
    );
  }

  final OptionStates states;
  final OptionModel? option;
  final OptionModel? selectedOption;
  final Item? selectedItem;
  final List<OptionModel?> allOptions;
  final List<Item?> allItems;

  @override
  List<Object?> get props => [states, option, allOptions, selectedOption, selectedItem, allItems];

  OptionState copyWith({
    OptionStates? states,
    OptionModel? option,
    OptionModel? selectedOption,
    Item? selectedItem,
    List<OptionModel?>? allOptions,
    List<Item?>? allItems,
  }) {
    return OptionState(
      states: states ?? this.states,
      option: option ?? this.option,
      selectedOption: selectedOption ?? this.selectedOption,
      selectedItem: selectedItem ?? this.selectedItem,
      allOptions: allOptions ?? this.allOptions,
      allItems: allItems ?? this.allItems,
    );
  }
}

enum OptionStates { initial, loading, completed, error }
