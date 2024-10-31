// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_cancel_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_category_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_expense_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_order_type_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_product_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_waiter_model.dart';
import 'package:core/core.dart';

class ReportsState extends BaseState {
  const ReportsState({
    required this.status,
    required this.orderTypeReports,
    required this.productReports,
    required this.selectedProducts,
    required this.isSelectAll,
    required this.categoryReports,
    required this.selectedCategoryReport,
    required this.allSelectedCategoryReport,
    required this.cancelReports,
    required this.expenseReports,
    required this.waiterReports,
  });
  factory ReportsState.initial() {
    return const ReportsState(
      status: ReportStatus.initial,
      orderTypeReports: null,
      productReports: [],
      selectedProducts: [],
      isSelectAll: false,
      categoryReports: [],
      selectedCategoryReport: null,
      allSelectedCategoryReport: [],
      cancelReports: [],
      expenseReports: [],
      waiterReports: [],
    );
  }
  final ReportStatus status;
  final ReportsOrderTypeModel? orderTypeReports;
  final List<ReportsProductModel?> productReports;
  final List<ReportsCategoryModel?> categoryReports;
  final ReportsCategoryModel? selectedCategoryReport;
  final List<ReportsCategoryModel?> allSelectedCategoryReport;
  final List<String>? selectedProducts;
  final bool isSelectAll;
  final List<ReportsCancelModel?> cancelReports;
  final List<ReportsExpenseModel?> expenseReports;
  final List<ReportsWaiterModel?> waiterReports;
  @override
  List<Object?> get props => [
        status,
        orderTypeReports,
        productReports,
        selectedProducts,
        isSelectAll,
        categoryReports,
        selectedCategoryReport,
        allSelectedCategoryReport,
        cancelReports,
        expenseReports,
        waiterReports,
      ];

  ReportsState copyWith({
    ReportStatus? status,
    ReportsOrderTypeModel? orderTypeReports,
    List<ReportsProductModel?>? productReports,
    List<String>? selectedProducts,
    bool? isSelectAll,
    List<ReportsCategoryModel?>? categoryReports,
    ReportsCategoryModel? Function()? selectedCategoryReport,
    List<ReportsCategoryModel?>? allSelectedCategoryReport,
    List<ReportsCancelModel?>? cancelReports,
    List<ReportsExpenseModel?>? expenseReports,
    List<ReportsWaiterModel?>? waiterReports,
  }) {
    return ReportsState(
      status: status ?? this.status,
      orderTypeReports: orderTypeReports ?? this.orderTypeReports,
      productReports: productReports ?? this.productReports,
      selectedProducts: selectedProducts ?? this.selectedProducts,
      isSelectAll: isSelectAll ?? this.isSelectAll,
      categoryReports: categoryReports ?? this.categoryReports,
      selectedCategoryReport:
          selectedCategoryReport != null ? selectedCategoryReport() : this.selectedCategoryReport,
      allSelectedCategoryReport: allSelectedCategoryReport ?? this.allSelectedCategoryReport,
      cancelReports: cancelReports ?? this.cancelReports,
      expenseReports: expenseReports ?? this.expenseReports,
      waiterReports: waiterReports ?? this.waiterReports,
    );
  }
}

enum ReportStatus {
  initial,
  loading,
  success,
  failure,
}
