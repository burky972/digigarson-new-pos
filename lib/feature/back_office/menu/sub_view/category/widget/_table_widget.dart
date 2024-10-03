part of '../view/category_view.dart';

class _TableWidget extends StatelessWidget {
  const _TableWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        switch (state.states) {
          case CategoryStates.loading:
            return const Center(child: CircularProgressIndicator());
          case CategoryStates.error:
            return const Center(child: Text('An error occurred please try again!'));
          case CategoryStates.completed:
            return Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
                2: FixedColumnWidth(80.0),
                3: FixedColumnWidth(80.0),
                4: FixedColumnWidth(80.0),
                5: FixedColumnWidth(80.0),
                6: FixedColumnWidth(80.0),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    _TableCellTitleText(title: 'Group Name'),
                    _TableCellTitleText(title: 'Group Description'),
                    _TableCellTitleText(title: 'Dine In'),
                    _TableCellTitleText(title: 'Quick Service'),
                  ],
                ),
                ...state.subCategories.map((category) {
                  return TableRow(
                    decoration: BoxDecoration(
                      color: category == state.selectedSubCategory
                          ? context.colorScheme.tertiary
                          : null,
                    ),
                    children: [
                      BlocListener<CategoryCubit, CategoryState>(
                        listener: (context, state) {},
                        listenWhen: (previous, current) =>
                            previous.selectedSubCategory?.title !=
                            current.selectedSubCategory?.title,
                        child: TableRowInkWell(
                          onTap: () =>
                              context.read<CategoryCubit>().setSelectedSubCategory(category),
                          child: _TableCellContentText(content: category.title ?? ''),
                        ),
                      ),
                      TableRowInkWell(
                        onTap: () => context.read<CategoryCubit>().setSelectedSubCategory(category),
                        child: const _TableCellContentText(
                          content: '',
                        ),
                      ),
                      TableRowInkWell(
                        onTap: () => context
                            .read<CategoryCubit>()
                            .toggleActiveStatus(category.id.toString(), OrderType.DINE_IN),
                        child: _TableUnOnPressedCheckBox(
                          value: category.activeList?.contains(OrderType.DINE_IN.value) ?? false,
                        ),
                      ),
                      TableRowInkWell(
                        onTap: () => context
                            .read<CategoryCubit>()
                            .toggleActiveStatus(category.id.toString(), OrderType.QUICK_SERVICE),
                        child: _TableUnOnPressedCheckBox(
                          value:
                              category.activeList?.contains(OrderType.QUICK_SERVICE.value) ?? false,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            );

          default:
        }
        return const SizedBox();
      },
    );
  }
}

class _TableCellTitleText extends StatelessWidget {
  const _TableCellTitleText({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}

class _TableCellContentText extends StatelessWidget {
  const _TableCellContentText({required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const AppPadding.minAll(),
      child: Center(
        child: Text(
          content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _TableUnOnPressedCheckBox extends StatelessWidget {
  const _TableUnOnPressedCheckBox({required this.value});
  final bool? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const AppPadding.minAll(),
      child: Center(
        child: Checkbox(
          value: value,
          onChanged: null,
        ),
      ),
    );
  }
}
