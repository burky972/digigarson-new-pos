import 'package:a_pos_flutter/feature/back_office/sections/cubit/i_section_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_state.dart';
import 'package:a_pos_flutter/feature/back_office/sections/model/section_model.dart';
import 'package:a_pos_flutter/feature/back_office/sections/service/i_section_service.dart';
import 'package:a_pos_flutter/feature/back_office/sections/service/section_service.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:flutter/material.dart';

class SectionCubit extends ISectionCubit {
  SectionCubit() : super(SectionState.initial());

  final ISectionService _sectionService = SectionService();
  final TextEditingController sectionController = TextEditingController();

  ///init
  @override
  void init() {
    APosLogger.instance?.info('SECTION CUBIT', 'INITIALIZED!!');
    getSections();
  }

  ///section
  // @override
  // SectionModel? get sections => state.allSections;

  /// set Selected Section
  @override
  void setSelectedSection({required String sectionTitle}) {
    sectionController.text = sectionTitle;
    emit(state.copyWith(selectedSection: () => sectionTitle));
  }

  ///getSections
  @override
  Future getSections() async {
    APosLogger.instance?.info('SECTION CUBIT', 'GET SECTIONS!!');
    emit(state.copyWith(states: SectionStates.loading));
    final response = await _sectionService.getSections();

    response.fold((l) {
      emit(state.copyWith(states: SectionStates.error));
    }, (r) {
      List<SectionModel> sections =
          List<SectionModel>.from(r.data.map((x) => SectionModel.fromJson(x))).toList();
      emit(state.copyWith(
          allSections: sections,
          selectedSection: () => sections.isNotEmpty ? sections.first.title : null,
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
      SectionModel section = SectionModel.fromJson(r.data);
      // emit(state.copyWith(section: section, states: SectionStates.completed));
    });
  }

  ///deleteSections
  @override
  Future deleteSections({required SectionModel sectionModel, required String sectionId}) async {
    emit(state.copyWith(states: SectionStates.loading));
    final response = await _sectionService.deleteSections(sectionId: sectionId);
    response.fold((l) {
      emit(state.copyWith(states: SectionStates.error));
    }, (r) {
      //TODO: check response after deleting!
      SectionModel section = SectionModel.fromJson(r.data);
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
      SectionModel section = SectionModel.fromJson(r.data);
      // emit(state.copyWith(section: section, states: SectionStates.completed));
    });
  }
}
