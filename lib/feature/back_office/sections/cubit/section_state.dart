import 'package:a_pos_flutter/feature/back_office/sections/model/section_model.dart';
import 'package:core/core.dart';

class SectionState extends BaseState {
  const SectionState({
    required this.states,
    required this.allSections,
    required this.originalSections,
    required this.selectedSection,
    required this.exception,
  });

  factory SectionState.initial() {
    return const SectionState(
      states: SectionStates.initial,
      allSections: null,
      originalSections: null,
      selectedSection: null,
      exception: null,
    );
  }

  final SectionStates states;
  final List<SectionModel>? allSections;
  final List<SectionModel>? originalSections;
  final SectionModel? selectedSection;
  final AppException? exception;
  @override
  List<Object?> get props => [
        states,
        allSections,
        originalSections,
        selectedSection,
        exception,
      ];

  SectionState copyWith({
    SectionStates? states,
    List<SectionModel>? allSections,
    List<SectionModel>? originalSections,
    SectionModel? Function()? selectedSection,
    AppException? Function()? exception,
  }) {
    return SectionState(
      states: states ?? this.states,
      allSections: allSections ?? this.allSections,
      originalSections: originalSections ?? this.originalSections,
      selectedSection: selectedSection != null ? selectedSection() : this.selectedSection,
      exception: exception != null ? exception() : this.exception,
    );
  }
}

enum SectionStates { initial, loading, completed, error }
