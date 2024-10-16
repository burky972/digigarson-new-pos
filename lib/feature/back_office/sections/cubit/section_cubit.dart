import 'dart:math';

import 'package:a_pos_flutter/feature/back_office/sections/cubit/i_section_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_state.dart';
import 'package:a_pos_flutter/feature/back_office/sections/model/section_model.dart';
import 'package:a_pos_flutter/feature/back_office/sections/service/i_section_service.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class SectionCubit extends ISectionCubit {
  SectionCubit(this._sectionService) : super(SectionState.initial());

  final ISectionService _sectionService;
  final TextEditingController sectionController = TextEditingController();
  List<SectionModel> originalSections = [];
  List<SectionModel> allSectionList = [];

  ///init
  @override
  void init() {
    appLogger.info('SECTION CUBIT', 'INITIALIZED!!');
    getSections();
  }

  /// set Selected Section
  @override
  void setSelectedSection({required SectionModel sectionModel}) {
    sectionController.text = sectionModel.title ?? '';
    emit(state.copyWith(selectedSection: () => sectionModel));
  }

  /// add new section
  @override
  void addNewSection() {
    appLogger.info('TAG', 'ADD MEW SECTION INITIALIZED!!');
    if (state.allSections != null && state.allSections!.isNotEmpty) {
      if (state.allSections!.last.title == null || state.allSections!.last.title!.isEmpty) {
        return;
      }
    }
    sectionController.clear();

    /// create new section and make id unique
    Random random = Random();
    int randomNumber = random.nextInt(1000000);
    final newSection = SectionModel.empty().copyWith(id: randomNumber.toString());
    final updatedSections = List<SectionModel>.from(state.allSections ?? [])..add(newSection);
    emit(state.copyWith(allSections: updatedSections));
    allSectionList = updatedSections;
    setSelectedSection(sectionModel: state.allSections!.lastOrNull ?? SectionModel.empty());
    sectionController.text = state.allSections!.lastOrNull?.title ?? '';
  }

  /// Delete Section form all SectionList
  void deleteSection() {
    if (state.selectedSection == null) return;
    // Remove the selected section from the list
    final updatedSections = List<SectionModel>.from(state.allSections ?? [])
      ..removeWhere((section) => section.id == state.selectedSection!.id);

    // Emit the new state with the updated list
    emit(state.copyWith(allSections: updatedSections));
    allSectionList = updatedSections;

    // Clear the selected section or select another section if the list is not empty
    if (updatedSections.isNotEmpty) {
      setSelectedSection(sectionModel: updatedSections.first);
    } else {
      Random random = Random();
      int randomNumber = random.nextInt(1000000);
      // Clear the selected section
      setSelectedSection(sectionModel: SectionModel.empty().copyWith(id: randomNumber.toString()));
    }

    // Clear the controller
    sectionController.clear();
  }

  /// update selected section's title
  @override
  void updateSectionTitle({required String sectionTitle}) {
    if (state.selectedSection == null) return;

    final updatedSections = List<SectionModel>.from(state.allSections ?? []);

    // Find the index of the section to update
    final index = updatedSections.indexWhere((element) => element == state.selectedSection);

    if (index != -1) {
      // Update the section title
      updatedSections[index] = updatedSections[index].copyWith(title: sectionTitle);

      // Emit the updated state
      emit(state.copyWith(allSections: updatedSections));
      allSectionList = updatedSections;

      // Update the selected section
      setSelectedSection(sectionModel: updatedSections[index]);
      sectionController.text = sectionTitle;
    }
  }

  /// save sections
  @override
  Future<void> saveChanges(List<SectionModel>? allSections) async {
    // Optionally handle deleted sections
    for (var originalSection in originalSections) {
      final isDeleted = !(allSections?.any((section) => section.id == originalSection.id) ?? false);
      if (isDeleted) {
        await deleteSections(sectionId: originalSection.id!, sectionModel: originalSection);
      }
    }

    for (var section in allSections ?? []) {
      final originalSection = originalSections.firstWhere(
        (original) => original.id == section.id,
        orElse: () => SectionModel.empty(),
      );
      if (originalSection.id != section.id) {
        if (section.title != null && section.title!.isNotEmpty) {
          await postSections(sectionModel: section);
        } else {}
      } else if (originalSection.title != section.title) {
        // If the section exists but its title has changed, perform a PUT
        await putSections(sectionModel: section, sectionId: section.id);
      }
    }

    originalSections = allSections ?? [];
    appLogger.info('section originalLength', '${originalSections.length}!!');
    emit(state.copyWith(originalSections: originalSections, allSections: originalSections));
    await getSections();
  }

  ///getSections
  @override
  Future getSections() async {
    appLogger.info('SECTION CUBIT', 'GET SECTIONS!!');
    emit(state.copyWith(states: SectionStates.loading));
    final response = await _sectionService.getSections();

    response.fold((l) {
      emit(state.copyWith(states: SectionStates.error));
    }, (r) {
      List<SectionModel> sections =
          List<SectionModel>.from(r.data.map((x) => SectionModel.fromJson(x))).toList();
      if (sections.isNotEmpty) {
        setSelectedSection(sectionModel: sections.first);
      }
      originalSections = sections;
      allSectionList = sections;
      emit(state.copyWith(originalSections: originalSections));

      emit(state.copyWith(
          allSections: sections,
          selectedSection: () => sections.isNotEmpty ? sections.first : null,
          states: SectionStates.completed));
    });
  }

  ///postSections
  @override
  Future postSections({required SectionModel sectionModel}) async {
    emit(state.copyWith(states: SectionStates.loading));
    final response = await _sectionService.postSections(sectionModel: sectionModel);
    response.fold((l) {
      emit(state.copyWith(states: SectionStates.error));
    }, (r) {
      // SectionModel section = SectionModel.fromJson(r.data);
      emit(state.copyWith(states: SectionStates.completed));
    });
  }

  ///deleteSections SERVICE REQUEST
  @override
  Future deleteSections({required SectionModel sectionModel, required String sectionId}) async {
    emit(state.copyWith(states: SectionStates.loading));
    final response = await _sectionService.deleteSections(sectionId: sectionId);
    response.fold((l) {
      appLogger.error('SECTION CUBIT', l.message);
      emit(state.copyWith(
        states: SectionStates.error,
        exception: () => AppException(message: l.message, statusCode: '505'),
      ));
    }, (r) {
      //TODO: check response after deleting!
      // SectionModel section = SectionModel.fromJson(r.data);
      // emit(state.copyWith(section: section, states: SectionStates.completed));
    });
  }

  ///putSections
  @override
  Future putSections({required SectionModel sectionModel, required String sectionId}) async {
    emit(state.copyWith(states: SectionStates.loading));
    final response =
        await _sectionService.putSections(sectionId: sectionId, sectionModel: sectionModel);
    response.fold((l) {
      emit(state.copyWith(states: SectionStates.error));
    }, (r) {
      // SectionModel section = SectionModel.fromJson(r.data);
      // emit(state.copyWith(section: section, states: SectionStates.completed));
    });
  }
}
