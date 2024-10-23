part of '../../view/sales_report_view.dart';

/// Top Table Widget
class _TopTableWidget extends StatelessWidget {
  const _TopTableWidget();

  @override
  Widget build(BuildContext context) {
    final ScrollController verticalScrollController = ScrollController();
    final ScrollController horizontalScrollController = ScrollController();
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        List<ProductModel>? productsToDisplay = [];
        if (context.read<CategoryCubit>().selectedSubCategory?.id != null) {
          productsToDisplay =
              state.categorizedProducts?[context.read<CategoryCubit>().selectedSubCategory?.id] ??
                  [];
        }
        return Container(
          padding: const EdgeInsets.only(left: 8.0),
          width: context.dynamicWidth(0.75),
          height: context.dynamicHeight(0.5),
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
                  child: SizedBox(
                    width: context.dynamicWidth(0.75),
                    height: context.dynamicHeight(0.5),
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
                            TableCellTitleWidget(title: 'Pick Up'),
                            TableCellTitleWidget(title: 'Q-Service'),
                            TableCellTitleWidget(title: 'Bar'),
                            TableCellTitleWidget(title: 'Grand Total'),
                          ],
                        ),
                        ...productsToDisplay.map((product) {
                          return TableRow(
                            decoration: BoxDecoration(
                              color: product.id == state.selectedProduct?.id
                                  ? context.colorScheme.tertiary
                                  : null,
                            ),
                            children: [
                              _MiddleTableCellTextWidget(
                                product: product,
                                text: product.title ?? '',
                              ),
                              _MiddleTableCellTextWidget(
                                product: product,
                                text: product.prices!.isNotEmpty
                                    ? product.prices!.first.price.toString()
                                    : '',
                              ),
                              _MiddleTableCellTextWidget(
                                product: product,
                                text: product.prices!.isNotEmpty
                                    ? product.prices!.first.amount.toString()
                                    : '',
                              ),
                              _MiddleTableCellTextWidget(
                                product: product,
                                text: product.prices!.isNotEmpty
                                    ? product.prices!.first.amount.toString()
                                    : '',
                              ),
                              _MiddleTableCellTextWidget(
                                product: product,
                                text: product.prices!.isNotEmpty
                                    ? product.prices!.first.amount.toString()
                                    : '',
                              ),
                              _MiddleTableCellTextWidget(
                                product: product,
                                text: product.prices!.isNotEmpty
                                    ? product.prices!.first.amount.toString()
                                    : '',
                              ),
                              _MiddleTableCellTextWidget(
                                product: product,
                                text: product.prices!.isNotEmpty
                                    ? product.prices!.first.vatRate.toString()
                                    : '',
                              ),
                              _MiddleTableCellTextWidget(
                                product: product,
                                text: '0',
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
        );
      },
    );
  }
}
