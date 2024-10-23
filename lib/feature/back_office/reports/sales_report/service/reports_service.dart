import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_request_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/service/i_reports_service.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';

class ReportsService implements IReportsService {
  const ReportsService(this._dioClient);
  final DioClient _dioClient;
  @override
  BaseResponseData<BaseResponseModel> getProductReports({
    required ReportsRequestModel requestReportModel,
  }) async {
    BaseResponseModel responseModel = await _dioClient.get(
      NetworkConstants.reportProduct,
      queryParameters: requestReportModel.toJson(),
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }

  @override
  BaseResponseData<BaseResponseModel> getCategoryReports({
    required ReportsRequestModel requestReportModel,
  }) async {
    BaseResponseModel responseModel = await _dioClient.get(
      NetworkConstants.reportCategory,
      queryParameters: requestReportModel.toJson(),
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }
}
