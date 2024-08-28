part of '../view/option_view.dart';

/// Left Side Table Option Group List
class _LeftSideOptionGroupTable extends StatelessWidget {
  const _LeftSideOptionGroupTable();

  @override
  Widget build(BuildContext context) {
    OptionCubit optionCubit = context.read<OptionCubit>();
    return BlocBuilder<OptionCubit, OptionState>(
      builder: (context, state) {
        return SizedBox(
          width: context.dynamicWidth(0.2),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const Text(
                'Group Name',
                style: CustomFontStyle.titlesTextStyle,
              ),
              const SizedBox(height: 10),
              Column(
                children: state.allOptions
                    .map((option) => GestureDetector(
                          onTap: () {
                            optionCubit.setSelectedOption(option ?? OptionModel.empty());
                          },
                          child: Container(
                            color: option == state.selectedOption
                                ? context.colorScheme.tertiary
                                : null,
                            child: Column(
                              children: [
                                Text(' ${option?.name}'),
                                const Divider(),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          )),
        );
      },
    );
  }
}

class _MiddleOptionsTable extends StatelessWidget {
  const _MiddleOptionsTable();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionCubit, OptionState>(
      builder: (context, state) {
        OptionModel selectedOption = state.selectedOption ?? OptionModel.empty();
        return Container(
          decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
          child: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
                2: FixedColumnWidth(80.0),
                3: FixedColumnWidth(80.0),
                4: FixedColumnWidth(80.0),
                5: FixedColumnWidth(80.0),
                6: FixedColumnWidth(80.0),
                7: FixedColumnWidth(80.0),
                8: FixedColumnWidth(80.0),
                9: FixedColumnWidth(80.0),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    TableCell(
                      child: Center(
                          child:
                              Text('Option Name', style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    TableCell(
                      child: Center(
                          child:
                              Text('Description', style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    TableCell(
                      child: Center(
                          child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    TableCell(
                      child: Center(
                          child: Text('L Price', style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    TableCell(
                      child: Center(
                          child: Text('H Price', style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    TableCell(
                      child: Center(
                          child: Text('D Price', style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    TableCell(
                      child: Center(
                          child: Text('T Price', style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    TableCell(
                      child:
                          Center(child: Text('Tax', style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    TableCell(
                      child: Center(
                          child: Text('BarTax', style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                  ],
                ),
                ...selectedOption.items!.map((item) {
                  return TableRow(
                    decoration: BoxDecoration(
                        color: item == state.selectedItem ? context.colorScheme.tertiary : null),
                    children: [
                      _TableCellTextWidget(
                        item: item,
                        text: item.itemName.toString(),
                      ),
                      _TableCellTextWidget(
                        item: item,
                        text: state.selectedOption!.specialName.toString(),
                      ),
                      _TableCellTextWidget(
                        item: item,
                        text: item.price.toString(),
                      ),
                      _TableCellTextWidget(
                        item: item,
                        text: item.lunchPrice.toString(),
                      ),
                      _TableCellTextWidget(
                        item: item,
                        text: item.happyHourPrice.toString(),
                      ),
                      _TableCellTextWidget(
                        item: item,
                        text: item.deliveryPrice.toString(),
                      ),
                      _TableCellTextWidget(
                        item: item,
                        text: item.takeOutPrice.toString(),
                      ),
                      _TableCellTextWidget(
                        item: item,
                        text: item.vatRate.toString(),
                      ),
                      _TableCellTextWidget(
                        item: item,
                        // text: item.amount.toString(),
                        text: '0',
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
