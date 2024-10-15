part of '../../../view/sales_report_view.dart';

/// Right Side Small Table Option List
class _OrderDetailTableWidget extends StatelessWidget {
  const _OrderDetailTableWidget();

  @override
  Widget build(BuildContext context) {
    final ScrollController smallTableScrollController = ScrollController();
    final ScrollController smallTableHorizontalController = ScrollController();

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final selectedProduct = state.selectedProduct;
        if (selectedProduct == null) {
          return const Center(child: Text('No product selected'));
        }
        return Padding(
          padding: const AppPadding.minAll(),
          child: Column(
            children: [
              Container(
                width: context.dynamicWidth(0.25),
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
                        width: context.dynamicWidth(0.3),
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            const TableRow(
                              decoration: BoxDecoration(color: Colors.grey),
                              children: [
                                _TableCellTitleWidget(title: 'ST'),
                                _TableCellTitleWidget(title: 'Item'),
                                _TableCellTitleWidget(title: 'Price'),
                                _TableCellTitleWidget(title: 'Qty'),
                              ],
                            ),
                            ...state.allOptions.map((option) {
                              return TableRow(
                                decoration: BoxDecoration(
                                  color: option == state.selectedOption
                                      ? context.colorScheme.tertiary
                                      : null,
                                ),
                                children: [
                                  TableRowInkWell(
                                    onTap: () =>
                                        context.read<ProductCubit>().setSelectedOption(option),
                                    child: _TableCellTextWidget(text: option!.name!),
                                  ),
                                  TableRowInkWell(
                                    onTap: () =>
                                        context.read<ProductCubit>().setSelectedOption(option),
                                    child: _TableCellTextWidget(text: option.name!),
                                  ),
                                  TableRowInkWell(
                                    onTap: () =>
                                        context.read<ProductCubit>().setSelectedOption(option),
                                    child: _TableCellTextWidget(text: option.name!),
                                  ),
                                  TableRowInkWell(
                                    onTap: () =>
                                        context.read<ProductCubit>().setSelectedOption(option),
                                    child:
                                        _TableCellTextWidget(text: option.chooseLimit.toString()),
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
