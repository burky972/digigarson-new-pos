import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/view/roles_view.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/cubit/reports_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/cubit/reports_state.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_request_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_waiter_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/widget/select_date_widget.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/utils/helper/date_helper.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/text/from_to_title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WaiterReportView extends StatelessWidget {
  const WaiterReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController endDateController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: context.dynamicWidth(0.9),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Waiter Report', style: CustomFontStyle.titleBoldTertiaryStyle),
                const Row(
                  children: [
                    _PaymentTableWidget(),
                    Spacer(),
                    _ProductTableWidget(),
                  ],
                ),
                const _ExpenseTableWidget(),
                SizedBox(
                  height: context.dynamicHeight(0.12),
                  width: context.dynamicWidth(0.9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const FromToTitle(title: 'From'),
                                  Expanded(
                                    child: SelectDateWidget(
                                      startDateController: startDateController,
                                      endDateController: endDateController,
                                      isStartDay: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Row(
                                children: [
                                  const FromToTitle(title: 'To'),
                                  Expanded(
                                    child: SelectDateWidget(
                                      startDateController: startDateController,
                                      endDateController: endDateController,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),

                      /// Bottom Buttons
                      LightBlueButton(
                        buttonText: LocaleKeys.search.tr(),
                        onTap: () async {
                          if (startDateController.text.isEmpty || endDateController.text.isEmpty) {
                            return;
                          }
                          var startDate = DateHelper.stringToTimestamp(startDateController.text);
                          final endDate = DateHelper.nextDay(endDateController.text);

                          await context.read<ReportsCubit>().getWaiterReports(
                                ReportsRequestModel(
                                  startDate: startDate.toString(),
                                  endDate: endDate.toString(),
                                ),
                              );
                        },
                      ),
                      LightBlueButton(
                        buttonText: LocaleKeys.print.tr(),
                        onTap: () => routeManager.pop(),
                      ),
                      LightBlueButton(
                        buttonText: LocaleKeys.export.tr(),
                        onTap: () => routeManager.pop(),
                      ),
                      LightBlueButton(
                        buttonText: LocaleKeys.send_email.tr(),
                        onTap: () => routeManager.pop(),
                      ),
                      LightBlueButton(
                        buttonText: LocaleKeys.refund.tr(),
                        onTap: () => routeManager.pop(),
                      ),
                      LightBlueButton(
                        buttonText: LocaleKeys.exit.tr(),
                        onTap: () => routeManager.pop(),
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

/// Payment Table Widget
class _PaymentTableWidget extends StatelessWidget {
  const _PaymentTableWidget();

  @override
  Widget build(BuildContext context) {
    final ScrollController smallTableScrollController = ScrollController();
    final ScrollController smallTableHorizontalController = ScrollController();

    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        ReportsWaiterModel report = state.waiterReports.isEmpty
            ? ReportsWaiterModel.empty()
            : state.waiterReports.first ?? ReportsWaiterModel.empty();

        return Padding(
          padding: const AppPadding.minAll(),
          child: Column(
            children: [
              Padding(
                padding: const AppPadding.minAll().copyWith(bottom: 10, top: 2),
                child: const Text('Payment Report', style: CustomFontStyle.titleBoldTertiaryStyle),
              ),
              Container(
                width: context.dynamicWidth(0.4),
                height: context.dynamicHeight(0.35),
                decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
                child: Scrollbar(
                  controller: smallTableScrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: smallTableScrollController,
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      controller: smallTableHorizontalController,
                      child: SizedBox(
                        width: context.dynamicWidth(0.4),
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            const TableRow(
                              decoration: BoxDecoration(color: Colors.grey),
                              children: [
                                TableCellTitleWidget(title: 'Payment Type'),
                                TableCellTitleWidget(title: 'Total'),
                                TableCellTitleWidget(title: 'Currency'),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCellTitleWidget(title: 'Cash'),
                                TableCellTitleWidget(
                                  title: report.payments.isNotEmpty && report.payments.first != null
                                      ? report.payments
                                              .where((element) => element?.type == 2)
                                              .firstOrNull
                                              ?.amount
                                              ?.toStringAsFixed(2) ??
                                          '0'
                                      : '0',
                                ),
                                const TableCellTitleWidget(title: 'USD'),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCellTitleWidget(title: 'Credit Card'),
                                TableCellTitleWidget(
                                  title: report.payments.isNotEmpty && report.payments.first != null
                                      ? report.payments
                                              .where((element) => element?.type == 1)
                                              .firstOrNull
                                              ?.amount
                                              ?.toStringAsFixed(2) ??
                                          '0'
                                      : '0',
                                ),
                                const TableCellTitleWidget(title: 'USD'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Products Table Widget
class _ProductTableWidget extends StatelessWidget {
  const _ProductTableWidget();

  @override
  Widget build(BuildContext context) {
    final ScrollController smallTableScrollController = ScrollController();
    final ScrollController smallTableHorizontalController = ScrollController();

    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        ReportsWaiterModel selectedWaiter = state.waiterReports.isEmpty
            ? ReportsWaiterModel.empty()
            : state.waiterReports.first ?? ReportsWaiterModel.empty();
        return Padding(
          padding: const AppPadding.minAll(),
          child: Column(
            children: [
              Padding(
                padding: const AppPadding.minAll().copyWith(bottom: 10, top: 2),
                child: const Text('Product Report', style: CustomFontStyle.titleBoldTertiaryStyle),
              ),
              Container(
                width: context.dynamicWidth(0.4),
                height: context.dynamicHeight(0.35),
                decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
                child: Scrollbar(
                  controller: smallTableScrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: smallTableScrollController,
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      controller: smallTableHorizontalController,
                      child: SizedBox(
                        width: context.dynamicWidth(0.4),
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            const TableRow(
                              decoration: BoxDecoration(color: Colors.grey),
                              children: [
                                TableCellTitleWidget(title: 'Product Name'),
                                TableCellTitleWidget(title: 'Quantity'),
                                TableCellTitleWidget(title: 'Total'),
                              ],
                            ),
                            if (selectedWaiter.products.isNotEmpty)
                              ...selectedWaiter.products.map(
                                (product) => TableRow(
                                  children: [
                                    TableCellTitleWidget(
                                      title: product?.productName ?? '',
                                    ),
                                    TableCellTitleWidget(
                                      title: product?.quantity.toString() ?? '',
                                    ),
                                    TableCellTitleWidget(
                                      title: product?.price.toString() ?? '',
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Expense Table Widget
class _ExpenseTableWidget extends StatelessWidget {
  const _ExpenseTableWidget();

  @override
  Widget build(BuildContext context) {
    final ScrollController smallTableScrollController = ScrollController();
    final ScrollController smallTableHorizontalController = ScrollController();

    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        ReportsWaiterModel selectedWaiter = state.waiterReports.isEmpty
            ? ReportsWaiterModel.empty()
            : state.waiterReports.first ?? ReportsWaiterModel.empty();

        return Padding(
          padding: const AppPadding.minAll(),
          child: Column(
            children: [
              Padding(
                padding: const AppPadding.minAll().copyWith(bottom: 10, top: 2),
                child: const Text('Expense Report', style: CustomFontStyle.titleBoldTertiaryStyle),
              ),
              Container(
                width: context.dynamicWidth(0.4),
                height: context.dynamicHeight(0.35),
                decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
                child: Scrollbar(
                  controller: smallTableScrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: smallTableScrollController,
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      controller: smallTableHorizontalController,
                      child: SizedBox(
                        width: context.dynamicWidth(0.4),
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            const TableRow(
                              decoration: BoxDecoration(color: Colors.grey),
                              children: [
                                TableCellTitleWidget(title: 'Title'),
                                TableCellTitleWidget(title: 'Description'),
                                TableCellTitleWidget(title: 'Payment Type'),
                                TableCellTitleWidget(title: 'Total'),
                                TableCellTitleWidget(title: 'Currency'),
                                TableCellTitleWidget(title: 'Created At'),
                              ],
                            ),
                            if (selectedWaiter.waiterExpenses.isNotEmpty)
                              ...selectedWaiter.waiterExpenses.map(
                                (expense) => TableRow(
                                  children: [
                                    TableCellTitleWidget(
                                      title: expense?.title ?? '',
                                    ),
                                    TableCellTitleWidget(
                                      title: expense?.description.toString() ?? '-',
                                    ),
                                    TableCellTitleWidget(
                                      title: expense?.paymentType.toString() ?? '-',
                                    ),
                                    TableCellTitleWidget(
                                      title: expense?.amount?.toStringAsFixed(2) ?? '0',
                                    ),
                                    const TableCellTitleWidget(
                                      title: 'USD',
                                    ),
                                    TableCellTitleWidget(
                                      title: expense?.createdAt.toString().split(' ')[0] ?? '-',
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
