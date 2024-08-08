import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_state.dart';
import 'package:a_pos_flutter/feature/back_office/sections/model/section_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

abstract class ISectionCubit extends BaseCubit<SectionState> {
  ISectionCubit(super.initialState);
  // SectionModel? get section;
  Future getSections();
  Future postSections({required SectionModel sectionModel});
  Future deleteSections({required SectionModel sectionModel, required String sectionId});
  Future putSections({required SectionModel sectionModel, required String sectionId});

  ///SETTER
  void setSelectedSection({required String sectionTitle});
}
