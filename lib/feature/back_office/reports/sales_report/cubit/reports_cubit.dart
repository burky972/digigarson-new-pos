import 'package:a_pos_flutter/feature/back_office/reports/sales_report/cubit/i_reports_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/cubit/reports_state.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_request_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/service/i_reports_service.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';

class ReportsCubit extends IReportsCubit {
  ReportsCubit(this._reportsService) : super(ReportsState.initial());
  final IReportsService _reportsService;

  @override
  void init() {}
  @override
  Future<bool> getProductReports(ReportsRequestModel requestModel) async {
    final response = await _reportsService.getProductReports(requestReportModel: requestModel);
    response.fold(
      (l) => emit(state.copyWith(status: ReportStatus.failure)),
      (r) {
        appLogger.info('getReports', 'success-> ${r.data}');
        emit(state.copyWith(status: ReportStatus.success));
      },
    );

    return response.isRight();
  }

  @override
  Future<bool> getCategoryReports(ReportsRequestModel requestModel) async {
    final response = await _reportsService.getCategoryReports(requestReportModel: requestModel);
    response.fold(
      (l) => emit(state.copyWith(status: ReportStatus.failure)),
      (r) {
        appLogger.info('getReports', 'success-> ${r.data}');
        emit(state.copyWith(status: ReportStatus.success));
      },
    );

    return response.isRight();
  }
}
