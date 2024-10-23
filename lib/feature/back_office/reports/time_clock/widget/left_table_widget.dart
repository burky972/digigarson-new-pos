part of '../view/time_clock_view.dart';

class _LeftTableWidget extends StatelessWidget {
  const _LeftTableWidget();

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
          width: context.dynamicWidth(0.35),
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
                  child: SizedBox(
                    width: context.dynamicWidth(0.35),
                    height: context.dynamicHeight(0.7),
                    child: Table(
                      border: TableBorder.all(),
                      defaultColumnWidth: const IntrinsicColumnWidth(),
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(color: Colors.grey),
                          children: [
                            TableCellTitleWidget(title: 'Employee NO'),
                            TableCellTitleWidget(title: 'Name'),
                            TableCellTitleWidget(title: 'Wage/Per Hour'),
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
