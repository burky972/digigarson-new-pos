part of '../../../view/sales_report_view.dart';

/// Right Side Small Table Waiter List
class _WaiterTableWidget extends StatelessWidget {
  const _WaiterTableWidget();

  @override
  Widget build(BuildContext context) {
    final ScrollController smallTableScrollController = ScrollController();
    final ScrollController smallTableHorizontalController = ScrollController();

    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        return Padding(
          padding: const AppPadding.minAll(),
          child: Column(
            children: [
              Container(
                width: context.dynamicWidth(0.3),
                height: context.dynamicHeight(0.67),
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
                        width: context.dynamicWidth(0.3),
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            const TableRow(
                              decoration: BoxDecoration(color: Colors.grey),
                              children: [
                                TableCellTitleWidget(title: 'Waiter'),
                                TableCellTitleWidget(title: 'Cash Qty'),
                                TableCellTitleWidget(title: 'Card Qty'),
                                TableCellTitleWidget(title: 'Cash'),
                                TableCellTitleWidget(title: 'Card'),
                                TableCellTitleWidget(title: 'Amount'),
                                TableCellTitleWidget(title: 'Total Tip'),
                                TableCellTitleWidget(title: 'Total Discount'),
                              ],
                            ),
                            ...state.waiterReports.map((report) {
                              return TableRow(
                                decoration: const BoxDecoration(
                                    // color: option == state.selectedOption
                                    //     ? context.colorScheme.tertiary
                                    //     : null,
                                    ),
                                children: [
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(text: report?.name ?? ''),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(
                                        text: report?.cashQuantity.toString() ?? ''),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(
                                        text: report?.cardQuantity.toString() ?? ''),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(
                                        text: report?.payments != null &&
                                                report!.payments.isNotEmpty &&
                                                report.payments.first != null &&
                                                report.payments.first != null
                                            ? report.payments
                                                    .where((element) => element?.type == 2)
                                                    .first
                                                    ?.amount
                                                    ?.toStringAsFixed(2) ??
                                                ''
                                            : '0'),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(
                                        text: report?.payments != null &&
                                                report!.payments.isNotEmpty &&
                                                report.payments.first != null
                                            ? report.payments
                                                    .where((element) => element?.type == 1)
                                                    .first
                                                    ?.amount
                                                    ?.toStringAsFixed(2) ??
                                                ''
                                            : '0'),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(
                                        text: report?.total?.toStringAsFixed(2) ?? '0'),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(
                                        text: report?.totalTip.toString() ?? '0'),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(
                                        text: report?.totalDiscount.toString() ?? '0'),
                                  ),
                                ],
                              );
                            }),
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
