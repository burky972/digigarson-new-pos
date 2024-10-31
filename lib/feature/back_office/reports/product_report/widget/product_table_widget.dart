part of '../view/product_report_view.dart';

const double cellWidth = 150.0; // Width for each cell

class _ProductTableWidget extends StatelessWidget {
  const _ProductTableWidget();

  @override
  Widget build(BuildContext context) {
    final ScrollController verticalScrollController = ScrollController();
    final ScrollController horizontalScrollController = ScrollController();

    const List<String> tableTitles = [
      'Select',
      'Product Name',
      'Category',
      'DineIn Quantity',
      'DineIn Total',
      'TakeOut Quantity',
      'TakeOut Total',
      'Delivery Quantity',
      'Delivery Total',
      'Q.Service Quantity',
      'Q.Service Total',
      'Bar Quantity',
      'Bar Total',
      'Grand Quantity',
      'Grand Total',
      'Category ID',
    ];

    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        if (state.status == ReportStatus.loading) {
          return const Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(),
          );
        }

        List<ReportsProductModel?> productReports = state.productReports;

        return Column(
          children: [
            // "Select All" button
            Align(
              alignment: Alignment.topRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: state.isSelectAll ? true : false,
                    onChanged: (newValue) =>
                        context.read<ReportsCubit>().toggleSelectAll(productReports),
                  ),
                  InkWell(
                    onTap: () => context.read<ReportsCubit>().toggleSelectAll(productReports),
                    child: const Text(
                      'Select All',
                      style: CustomFontStyle.titleBoldTertiaryStyle,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8.0),
              width: context.dynamicWidth(0.9),
              height: context.dynamicHeight(0.6),
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      controller: horizontalScrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: horizontalScrollController,
                        child: Column(
                          children: [
                            // Header
                            Row(
                              children: tableTitles.map((title) {
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black), color: Colors.grey),
                                  width: cellWidth,
                                  child: TableCellTitleWidget(title: title),
                                );
                              }).toList(),
                            ),
                            // Data rows
                            Expanded(
                              child: Scrollbar(
                                controller: verticalScrollController,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  controller: verticalScrollController,
                                  child: Column(
                                    children: productReports.expand((product) {
                                      return (product?.products ?? []).map((productItem) {
                                        final cells = [
                                          productItem.title ?? '',
                                          product?.categoryTitle ?? '',
                                          productItem.dineInQuantity?.toString() ?? '0',
                                          productItem.dineInTotal?.toString() ?? '0',
                                          productItem.takeOutQuantity?.toString() ?? '0',
                                          productItem.takeOutTotal?.toString() ?? '0',
                                          productItem.deliveryQuantity?.toString() ?? '0',
                                          productItem.deliveryTotal?.toString() ?? '0',
                                          productItem.quickServiceQuantity?.toString() ?? '0',
                                          productItem.quickServiceTotal?.toString() ?? '0',
                                          productItem.barQuantity?.toString() ?? '0',
                                          productItem.barTotal?.toString() ?? '0',
                                          productItem.grandQuantity?.toString() ?? '0',
                                          productItem.grandTotal?.toString() ?? '0',
                                          product?.categoryId ?? '',
                                        ];

                                        return Row(
                                          children: [
                                            // Checkbox for each product
                                            Container(
                                              width: cellWidth,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)),
                                              child: Checkbox(
                                                value: state.selectedProducts
                                                    ?.contains(productItem.id),
                                                onChanged: (_) => context
                                                    .read<ReportsCubit>()
                                                    .toggleSelection(
                                                        productItem.id!, productReports),
                                              ),
                                            ),
                                            ...cells.map((cell) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black)),
                                                width: cellWidth,
                                                child: _TableCellTextWidget(text: cell),
                                              );
                                            }),
                                          ],
                                        );
                                      }).toList();
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class TableCellTitleWidget extends StatelessWidget {
  final String title;

  const TableCellTitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _TableCellTextWidget extends StatelessWidget {
  const _TableCellTextWidget({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const AppPadding.minAll(),
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
