part of '../../view/sales_report_view.dart';

/// Top Table Widget
class _TopTableWidget extends StatelessWidget {
  const _TopTableWidget();

  @override
  Widget build(BuildContext context) {
    final ScrollController verticalScrollController = ScrollController();
    final ScrollController horizontalScrollController = ScrollController();
    // Category list ve karşılık gelen model field'ları
    final List<MapEntry<String, String>> categoryMap = [
      const MapEntry('Guests', 'guests'),
      const MapEntry('Type', 'type'),
      const MapEntry('Quantity', 'quantity'),
      const MapEntry('Tax', 'tax'),
      const MapEntry('Discount', 'discount'),
      const MapEntry('Total Service Fee', 'totalServiceFee'),
      const MapEntry('Tip', 'tip'),
      const MapEntry('Cash', 'cash'),
      const MapEntry('Credit Card', 'creditCard'),
      const MapEntry('Sub Total', 'subTotal'),
      const MapEntry('Total', 'total'),
    ];
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        if (state.status == ReportStatus.loading) {
          return SizedBox(
              width: context.dynamicWidth(0.7),
              height: context.dynamicHeight(0.7),
              child: const Center(child: CircularProgressIndicator()));
        }
        ReportsOrderTypeModel orderTypeReports =
            state.orderTypeReports ?? ReportsOrderTypeModel.empty();

        return Container(
          width: context.dynamicWidth(0.7),
          height: context.dynamicHeight(0.7),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Scrollbar(
            controller: verticalScrollController,
            thumbVisibility: true,
            child: Scrollbar(
              controller: horizontalScrollController,
              thumbVisibility: true,
              notificationPredicate: (notification) => notification.depth == 1,
              child: SingleChildScrollView(
                controller: verticalScrollController,
                child: SingleChildScrollView(
                  controller: horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    constraints: BoxConstraints(minWidth: context.dynamicWidth(0.75)),
                    height: context.dynamicHeight(0.75),
                    child: Table(
                      border: TableBorder.all(),
                      defaultColumnWidth: const IntrinsicColumnWidth(),
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(color: Colors.grey),
                          children: [
                            TableCellTitleWidget(title: 'Category'),
                            TableCellTitleWidget(title: 'Dine-In'),
                            TableCellTitleWidget(title: 'Delivery'),
                            TableCellTitleWidget(title: 'Take Out'),
                            TableCellTitleWidget(title: 'Q-Service'),
                            TableCellTitleWidget(title: 'Bar'),
                            TableCellTitleWidget(title: 'Grand Total'),
                          ],
                        ),
                        ...categoryMap.map((category) {
                          return TableRow(
                            children: [
                              // Kategori ismi
                              _MiddleTableCellOrderTextWidget(
                                orderTypeModel: orderTypeReports.dineIn ?? OrderTypeModel.empty(),
                                text: category.key,
                              ),
                              // Dine-In
                              _buildTableCell(orderTypeReports.dineIn, category.value),
                              // Delivery
                              _buildTableCell(orderTypeReports.delivery, category.value),
                              // Take Out
                              _buildTableCell(orderTypeReports.takeOut, category.value),
                              // Quick Service
                              _buildTableCell(orderTypeReports.quickService, category.value),
                              // Bar
                              _buildTableCell(orderTypeReports.bar, category.value),
                              // Grand Total
                              _buildTableCell(orderTypeReports.grandTotal, category.value),
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
        );
      },
    );
  }

  Widget _buildTableCell(OrderTypeModel? model, String field) {
    String value = '0';
    if (model != null) {
      switch (field) {
        case 'guests':
          value = model.guests?.toString() ?? '0';
          break;
        case 'type':
          value = model.type?.toString() ?? '0';
          break;
        case 'quantity':
          value = model.quantity?.toString() ?? '0';
          break;
        case 'tax':
          value = (model.tax?.toStringAsFixed(2) ?? '0.00');
          break;
        case 'discount':
          value = (model.discount?.toStringAsFixed(2) ?? '0.00');
          break;
        case 'totalServiceFee':
          value = (model.totalServiceFee?.toStringAsFixed(2) ?? '0.00');
          break;
        case 'tip':
          value = (model.tip?.toStringAsFixed(2) ?? '0.00');
          break;
        case 'cash':
          value = (model.cash?.toStringAsFixed(2) ?? '0.00');
          break;
        case 'creditCard':
          value = (model.creditCard?.toStringAsFixed(2) ?? '0.00');
          break;
        case 'subTotal':
          value = (model.subTotal?.toStringAsFixed(2) ?? '0.00');
          break;
        case 'total':
          value = (model.total?.toStringAsFixed(2) ?? '0.00');
          break;
      }
    }
    return _TableCellTextWidget(text: value);
  }
}
