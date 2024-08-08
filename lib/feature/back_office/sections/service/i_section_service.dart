import 'package:a_pos_flutter/feature/back_office/sections/model/section_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class ISectionService {
  BaseResponseData<BaseResponseModel> getSections();
  BaseResponseData<BaseResponseModel> postSections({required SectionModel sectionModel});
  BaseResponseData<BaseResponseModel> putSections(
      {required String sectionId, required SectionModel sectionModel});
  BaseResponseData<BaseResponseModel> deleteSections({required String sectionId});
}
