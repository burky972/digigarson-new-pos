import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_request_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class IReportsService {
  BaseResponseData<BaseResponseModel> getProductReports({
    required ReportsRequestModel requestReportModel,
  });
  BaseResponseData<BaseResponseModel> getCategoryReports({
    required ReportsRequestModel requestReportModel,
  });
}
