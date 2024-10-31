part of '../../../view/sales_report_view.dart';

/// Right Side Small Table Expense List
class _ExpenseTableWidget extends StatelessWidget {
  const _ExpenseTableWidget();

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
                                TableCellTitleWidget(title: 'Description'),
                                TableCellTitleWidget(title: 'Amount'),
                                TableCellTitleWidget(title: 'Created By'),
                              ],
                            ),
                            ...state.expenseReports.map((expense) {
                              return TableRow(
                                decoration: const BoxDecoration(
                                    // color: option == state.selectedOption
                                    //     ? context.colorScheme.tertiary
                                    //     : null,
                                    ),
                                children: [
                                  TableRowInkWell(
                                    onTap: () {},
                                    //  =>
                                    // context.read<ProductCubit>().setSelectedOption(option),
                                    child: _TableCellTextWidget(text: expense!.title ?? ''),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(
                                        text: expense.expenseAmount.toString()),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {},
                                    child: _TableCellTextWidget(
                                        text:
                                            '${expense.caseReportModel?.user?.name} ${expense.caseReportModel?.user?.lastName}'),
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
