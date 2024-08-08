import 'package:a_pos_flutter/feature/back_office/sections/model/section_model.dart';
import 'package:a_pos_flutter/feature/back_office/sections/service/i_section_service.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';

class SectionService extends ISectionService {
  /// GET SECTIONS
  @override
  BaseResponseData<BaseResponseModel> getSections() async {
    BaseResponseModel responseModel = await DioClient.instance.get(NetworkConstants.section);
    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// POST SECTIONS
  @override
  BaseResponseData<BaseResponseModel> postSections({required SectionModel sectionModel}) async {
    BaseResponseModel responseModel = await DioClient.instance.post(
      NetworkConstants.section,
      data: sectionModel.toJson(),
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// DELETE SECTIONS
  @override
  BaseResponseData<BaseResponseModel> deleteSections({required String sectionId}) async {
    BaseResponseModel responseModel =
        await DioClient.instance.delete('${NetworkConstants.section}/$sectionId');
    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// PUT SECTIONS
  @override
  BaseResponseData<BaseResponseModel> putSections(
      {required String sectionId, required SectionModel sectionModel}) async {
    BaseResponseModel responseModel = await DioClient.instance.put(
      '${NetworkConstants.section}/$sectionId',
      data: sectionModel.toJson(),
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }
}
