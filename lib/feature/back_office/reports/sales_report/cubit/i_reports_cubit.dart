import 'package:a_pos_flutter/feature/back_office/reports/sales_report/cubit/reports_state.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_request_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

abstract class IReportsCubit extends BaseCubit<ReportsState> {
  IReportsCubit(super.initialState);
  Future<bool> getProductReports(ReportsRequestModel requestModel);
  Future<bool> getCategoryReports(ReportsRequestModel requestModel);
}
