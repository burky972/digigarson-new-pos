part of '../../../view/sales_report_view.dart';

/// Right Side Small Table Waiter List
class _WaiterTableWidget extends StatelessWidget {
  const _WaiterTableWidget();

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
                                _TableCellTitleWidget(title: 'Waiter'),
                                _TableCellTitleWidget(title: 'Qty'),
                                _TableCellTitleWidget(title: 'Cash'),
                                _TableCellTitleWidget(title: 'Card'),
                                _TableCellTitleWidget(title: 'Amount'),
                                _TableCellTitleWidget(title: 'Ch. Tip'),
                                _TableCellTitleWidget(title: 'Cd. Tip'),
                                _TableCellTitleWidget(title: 'Gratuity'),
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
                                  TableRowInkWell(
                                    onTap: () =>
                                        context.read<ProductCubit>().setSelectedOption(option),
                                    child:
                                        _TableCellTextWidget(text: option.chooseLimit.toString()),
                                  ),
                                  TableRowInkWell(
                                    onTap: () =>
                                        context.read<ProductCubit>().setSelectedOption(option),
                                    child:
                                        _TableCellTextWidget(text: option.chooseLimit.toString()),
                                  ),
                                  TableRowInkWell(
                                    onTap: () =>
                                        context.read<ProductCubit>().setSelectedOption(option),
                                    child:
                                        _TableCellTextWidget(text: option.chooseLimit.toString()),
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
