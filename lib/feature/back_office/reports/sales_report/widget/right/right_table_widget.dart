part of '../../view/sales_report_view.dart';

/// Right Side Small Table Option List
class _RightTableWidget extends StatelessWidget {
  const _RightTableWidget();

  @override
  Widget build(BuildContext context) {
    final ScrollController smallTableScrollController = ScrollController();
    final ScrollController smallTableHorizontalController = ScrollController();

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final selectedProduct = state.selectedProduct;
        String productId = selectedProduct?.id ?? '';
        var selectedOptionIds = state.productOptions[productId] ?? [];
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
                          columnWidths: const <int, TableColumnWidth>{
                            0: FlexColumnWidth(30.0),
                            1: FixedColumnWidth(200.0),
                            2: FixedColumnWidth(200.0),
                          },
                          children: [
                            const TableRow(
                              decoration: BoxDecoration(color: Colors.grey),
                              children: [
                                _TableCellTitleWidget(title: 'Select'),
                                _TableCellTitleWidget(title: 'Option Group'),
                                _TableCellTitleWidget(title: 'Maximum Options'),
                              ],
                            ),
                            ...state.allOptions.map((option) {
                              bool isSelected = selectedOptionIds
                                  .any((selectedOption) => selectedOption.id == option?.id);

                              return TableRow(
                                decoration: BoxDecoration(
                                  color: option == state.selectedOption
                                      ? context.colorScheme.tertiary
                                      : null,
                                ),
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const AppPadding.minAll(),
                                      child: Checkbox(
                                        value: isSelected,
                                        onChanged: (value) {
                                          context.read<ProductCubit>().toggleOptionToProduct(
                                                productId,
                                                ProductOptionModel(
                                                    id: option!.id!, isForcedChoice: false),
                                                context
                                                    .read<CategoryCubit>()
                                                    .selectedSubCategory!
                                                    .id!,
                                              );
                                        },
                                      ),
                                    ),
                                  ),
                                  TableRowInkWell(
                                    onTap: () =>
                                        context.read<ProductCubit>().setSelectedOption(option),
                                    child: _TableCellTextWidget(text: option!.name!),
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
