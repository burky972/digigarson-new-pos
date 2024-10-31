part of '../../../view/sales_report_view.dart';

/// Right Side Small Table Expense List
class _CancelReportsTableWidget extends StatelessWidget {
  const _CancelReportsTableWidget();

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
                                TableCellTitleWidget(title: 'Cancelled by'),
                                TableCellTitleWidget(title: 'Product'),
                                TableCellTitleWidget(title: 'Price'),
                                TableCellTitleWidget(title: 'Qty'),
                                TableCellTitleWidget(title: 'Cancel Reason'),
                                TableCellTitleWidget(title: 'Cancelled Date'),
                              ],
                            ),
                            ...state.cancelReports.map((report) {
                              return TableRow(
                                decoration: const BoxDecoration(),
                                children: [
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(text: report?.cancelledBy ?? ''),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(text: report?.product?.title ?? ''),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(
                                        text: report?.product?.price.toString() ?? ''),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(
                                        text: report?.product?.quantity.toString() ?? ''),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child:
                                        _TableCellTextWidget(text: report?.cancelledReason ?? ''),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(
                                        text: report?.cancelledDate.toString() ?? ''),
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
