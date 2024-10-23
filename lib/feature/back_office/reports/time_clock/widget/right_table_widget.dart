part of '../view/time_clock_view.dart';

/// Right Table Widget
class _RightTableWidget extends StatelessWidget {
  const _RightTableWidget();

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
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8.0),
              width: context.dynamicWidth(0.6),
              height: context.dynamicHeight(0.65),
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
                        width: context.dynamicWidth(0.6),
                        height: context.dynamicHeight(0.65),
                        child: Table(
                          border: TableBorder.all(),
                          defaultColumnWidth: const IntrinsicColumnWidth(),
                          children: [
                            const TableRow(
                              decoration: BoxDecoration(color: Colors.grey),
                              children: [
                                TableCellTitleWidget(title: 'Time In'),
                                TableCellTitleWidget(title: 'Time Out'),
                                TableCellTitleWidget(title: 'Duration(Hours)'),
                                TableCellTitleWidget(title: 'Is Valid'),
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
                                  MiddleTableCellTextWidget(
                                    onTap: () {},
                                    text: product.title ?? '',
                                  ),
                                  MiddleTableCellTextWidget(
                                    onTap: () {},
                                    text: product.title ?? '',
                                  ),
                                  MiddleTableCellTextWidget(
                                    onTap: () {},
                                    text: product.title ?? '',
                                  ),
                                  Checkbox(
                                    value: false,
                                    onChanged: (newValue) {
                                      if (newValue != null) {
                                        appLogger.info('selected value:', '$newValue');
                                      }
                                    },
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: context.dynamicWidth(0.6),
                height: context.dynamicHeight(0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '# of Records: ',
                        style: CustomFontStyle.titleBoldTertiaryStyle.copyWith(fontSize: 18),
                        children: [
                          TextSpan(
                            text: '${productsToDisplay.length}',
                            style: CustomFontStyle.titlesTextStyle.copyWith(
                              fontSize: 20,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Total Hours: ',
                        style: CustomFontStyle.titleBoldTertiaryStyle.copyWith(fontSize: 18),
                        children: [
                          TextSpan(
                            text: '${productsToDisplay.length}',
                            style: CustomFontStyle.titlesTextStyle.copyWith(
                              fontSize: 20,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
