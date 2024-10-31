import 'package:a_pos_flutter/feature/back_office/reports/sales_report/cubit/i_reports_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/cubit/reports_state.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_cancel_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_category_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_expense_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_order_type_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_product_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_request_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_waiter_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/service/i_reports_service.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';

class ReportsCubit extends IReportsCubit {
  ReportsCubit(this._reportsService) : super(ReportsState.initial());
  final IReportsService _reportsService;

  @override
  void init() {
    _setDefaultDateRange();
  }

  /// Set default date range for initial state
  Future<void> _setDefaultDateRange() async {
    final now = DateTime.now();
    final startDateParts = now.subtract(const Duration(days: 7)).toString().split(' ');
    final startDate = startDateParts[0];
    final endDateParts = now.add(const Duration(days: 1)).toString().split(' ');
    final endDate = endDateParts[0];

    await getSalesReports(
      ReportsRequestModel(
        startDate: _parseDate(startDate).toString(),
        endDate: _parseDate(endDate).toString(),
      ),
    );
  }

  int _parseDate(String dateStr) {
    final parts = dateStr.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);
    return DateTime(year, month, day).millisecondsSinceEpoch;
  }

  //! Call all sales reports in same func
  Future<bool> getSalesReports(ReportsRequestModel requestModel) async {
    emit(state.copyWith(status: ReportStatus.loading));
    try {
      await Future.wait([
        getOrderTypeReports(requestModel),
        getExpenseReports(requestModel),
        getCancelReports(requestModel),
        getWaiterReports(requestModel),
      ]);
      return true;
    } catch (e) {
      appLogger.error('GET SALES REPORTS ERROR', e.toString());
      return false;
    }
  }

  //! Get Product Reports
  @override
  Future<bool> getProductReports(ReportsRequestModel requestModel) async {
    emit(state.copyWith(status: ReportStatus.loading));
    final response = await _reportsService.getProductReports(requestReportModel: requestModel);
    response.fold(
      (l) => emit(state.copyWith(status: ReportStatus.failure)),
      (r) {
        final response = (r.data as List).map((e) => ReportsProductModel.fromJson(e)).toList();
        emit(state.copyWith(status: ReportStatus.success, productReports: response));
      },
    );

    return response.isRight();
  }

  //! Get Category Reports
  @override
  Future<bool> getCategoryReports(ReportsRequestModel requestModel) async {
    final response = await _reportsService.getCategoryReports(requestReportModel: requestModel);
    response.fold(
      (l) => emit(state.copyWith(status: ReportStatus.failure)),
      (r) {
        final categories = (r.data as List).map((e) => ReportsCategoryModel.fromJson(e)).toList();
        emit(state.copyWith(
            status: ReportStatus.success,
            categoryReports: categories,
            selectedCategoryReport: () => categories.isEmpty ? null : categories.first));
      },
    );

    return response.isRight();
  }

  //! Get Order Type Reports
  @override
  Future<bool> getOrderTypeReports(ReportsRequestModel requestModel) async {
    emit(state.copyWith(status: ReportStatus.loading));
    final response = await _reportsService.getOrderTypeReports(requestReportModel: requestModel);
    response.fold(
      (l) => emit(state.copyWith(status: ReportStatus.failure)),
      (r) {
        final response = ReportsOrderTypeModel.fromJson(r.data);
        emit(state.copyWith(status: ReportStatus.success, orderTypeReports: response));
      },
    );
    return response.isRight();
  }

  //! Get Expense Reports
  @override
  Future<bool> getExpenseReports(ReportsRequestModel requestModel) async {
    emit(state.copyWith(status: ReportStatus.loading));
    final response = await _reportsService.getExpenseReports(requestReportModel: requestModel);
    response.fold(
      (l) => emit(state.copyWith(status: ReportStatus.failure)),
      (r) {
        try {
          final response = (r.data as List).map((e) => ReportsExpenseModel.fromJson(e)).toList();
          appLogger.info('getExpenseReports length', response.length.toString());
          emit(state.copyWith(status: ReportStatus.success, expenseReports: response));
        } catch (e) {
          appLogger.info('getExpenseReports length', e.toString());
          emit(state.copyWith(status: ReportStatus.failure));
        }
      },
    );

    return response.isRight();
  }

  //! Get Cancel Reports
  @override
  Future<bool> getCancelReports(ReportsRequestModel requestModel) async {
    emit(state.copyWith(status: ReportStatus.loading));
    final response = await _reportsService.getCancelReports(requestReportModel: requestModel);
    response.fold(
      (l) => emit(state.copyWith(status: ReportStatus.failure)),
      (r) {
        final response = (r.data as List).map((e) => ReportsCancelModel.fromJson(e)).toList();
        emit(state.copyWith(status: ReportStatus.success, cancelReports: response));
      },
    );

    return response.isRight();
  }

  //! Get Waiter Reports
  @override
  Future<bool> getWaiterReports(ReportsRequestModel requestModel) async {
    emit(state.copyWith(status: ReportStatus.loading));
    final response = await _reportsService.getWaiterReports(requestReportModel: requestModel);
    response.fold(
      (l) => emit(state.copyWith(status: ReportStatus.failure)),
      (r) {
        final response = (r.data as List).map((e) => ReportsWaiterModel.fromJson(e)).toList();
        emit(state.copyWith(status: ReportStatus.success, waiterReports: response));
      },
    );

    return response.isRight();
  }

  // Toggles the "Select All" button and selects/deselects products accordingly
  void toggleSelectAll(List<ReportsProductModel?> productReports) {
    if (state.isSelectAll) {
      emit(state.copyWith(selectedProducts: [], isSelectAll: false));
    } else {
      final allProductIds = productReports
          .expand((product) => product?.products?.map((p) => p.id) ?? [])
          .whereType<String>()
          .toList();
      emit(state.copyWith(selectedProducts: allProductIds, isSelectAll: true));
    }
  }

  // Toggles the "Select All" button and selects/deselects Category accordingly
  void toggleSelectAllCategories(List<ReportsCategoryModel?> categoryReports) {
    if (state.isSelectAll) {
      emit(state.copyWith(allSelectedCategoryReport: [], isSelectAll: false));
    } else {
      emit(state.copyWith(allSelectedCategoryReport: categoryReports, isSelectAll: true));
    }
  }

  // select one product and toggle selection
  void toggleSelection(String productId, List<ReportsProductModel?> productReports) {
    final updatedSelectedProducts = List<String>.from(state.selectedProducts as Iterable);

    if (updatedSelectedProducts.contains(productId)) {
      updatedSelectedProducts.remove(productId);
    } else {
      updatedSelectedProducts.add(productId);
    }

    // Check if all product selected or not
    final allProductIds = productReports
        .expand((product) => product?.products?.map((p) => p.id) ?? [])
        .whereType<String>()
        .toList();
    final isAllSelected = updatedSelectedProducts.length == allProductIds.length;

    emit(state.copyWith(selectedProducts: updatedSelectedProducts, isSelectAll: isAllSelected));
  }

  // select one CATEGORY and toggle selection
  void toggleCategorySelection(ReportsCategoryModel category) {
    final updatedSelectedCategories =
        List<ReportsCategoryModel>.from(state.allSelectedCategoryReport);

    if (updatedSelectedCategories.contains(category)) {
      updatedSelectedCategories.remove(category);
    } else {
      updatedSelectedCategories.add(category);
    }

    final isAllSelected =
        updatedSelectedCategories.length == state.allSelectedCategoryReport.length;

    emit(state.copyWith(
        allSelectedCategoryReport: updatedSelectedCategories, isSelectAll: isAllSelected));
  }

  // Selected Products list as a List<String>
  void printSelectedProducts() {
    if (state.selectedProducts?.isEmpty == true) {
      return;
    }
    final selectedProductNames = state.productReports
        .expand((product) => product?.products ?? [])
        .where((product) => state.selectedProducts!.contains(product.id))
        .map((product) => product.title)
        .whereType<String>()
        .toList();
    appLogger.info('Selected Products:', ' ${selectedProductNames.join(', ')}');
  }

  void setSelectedCategoryReport(ReportsCategoryModel selectedCategory) =>
      emit(state.copyWith(selectedCategoryReport: () => selectedCategory));
}
