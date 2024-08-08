import 'package:a_pos_flutter/feature/back_office/sections/model/section_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

class SectionState extends BaseState {
  const SectionState({
    required this.states,
    required this.allSections,
    required this.selectedSection,
  });

  factory SectionState.initial() {
    return const SectionState(
      states: SectionStates.initial,
      allSections: null,
      selectedSection: null,
    );
  }

  final SectionStates states;
  final List<SectionModel>? allSections;
  final String? selectedSection;
  @override
  List<Object?> get props => [
        states,
        allSections,
        selectedSection,
      ];

  SectionState copyWith({
    SectionStates? states,
    List<SectionModel>? allSections,
    String? Function()? selectedSection,
  }) {
    return SectionState(
      states: states ?? this.states,
      allSections: allSections ?? this.allSections,
      selectedSection: selectedSection != null ? selectedSection() : this.selectedSection,
    );
  }
}

enum SectionStates { initial, loading, completed, error }
