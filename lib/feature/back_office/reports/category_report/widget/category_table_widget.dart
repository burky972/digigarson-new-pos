part of '../view/category_report_view.dart';

const double cellWidth = 150.0; // Width for each cell

class _CategoryTableWidget extends StatelessWidget {
  const _CategoryTableWidget();

  @override
  Widget build(BuildContext context) {
    final ScrollController verticalScrollController = ScrollController();
    final ScrollController horizontalScrollController = ScrollController();

    const List<String> tableTitles = [
      'Select',
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

        List<ReportsCategoryModel?> categoryReports = state.categoryReports;

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
                    onChanged: (_) =>
                        context.read<ReportsCubit>().toggleSelectAllCategories(categoryReports),
                  ),
                  InkWell(
                    onTap: () =>
                        context.read<ReportsCubit>().toggleSelectAllCategories(categoryReports),
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
                                      children: categoryReports.map((category) {
                                    final cells = [
                                      category?.categoryTitle ?? '',
                                      category?.dineInQuantity.toString() ?? '',
                                      category?.dineInTotal.toString() ?? '',
                                      category?.takeOutQuantity.toString() ?? '',
                                      category?.takeOutTotal.toString() ?? '',
                                      category?.deliveryQuantity.toString() ?? '',
                                      category?.deliveryTotal.toString() ?? '',
                                      category?.quickServiceQuantity.toString() ?? '',
                                      category?.quickServiceTotal.toString() ?? '',
                                      category?.barQuantity.toString() ?? '',
                                      category?.barTotal.toString() ?? '',
                                      category?.grandQuantity.toString() ?? '',
                                      category?.grandTotal.toString() ?? '',
                                      category?.categoryId ?? '',
                                    ];

                                    return ColoredBox(
                                      color: category == state.selectedCategoryReport
                                          ? context.colorScheme.tertiary
                                          : Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          if (category == null) return;
                                          context
                                              .read<ReportsCubit>()
                                              .setSelectedCategoryReport(category);
                                        },
                                        child: Row(
                                          children: [
                                            // Checkbox for each category
                                            Container(
                                              width: cellWidth,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)),
                                              child: Checkbox(
                                                  value: state.allSelectedCategoryReport
                                                      .contains(category),
                                                  onChanged: (_) => context
                                                      .read<ReportsCubit>()
                                                      .toggleCategorySelection(category!)),
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
                                        ),
                                      ),
                                    );
                                  }).toList()),
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

// const double cellWidth = 150.0; // Width for each cell

// class _CategoryTableWidget extends StatelessWidget {
//   const _CategoryTableWidget();

//   @override
//   Widget build(BuildContext context) {
//     final ScrollController verticalScrollController = ScrollController();
//     final ScrollController horizontalScrollController = ScrollController();

//     const List<String> tableTitles = [
//       'Select',
//       'Category Name',
//       'DineIn Quantity',
//       'DineIn Total',
//       'TakeOut Quantity',
//       'TakeOut Total',
//       'Delivery Quantity',
//       'Delivery Total',
//       'Q.Service Quantity',
//       'Q.Service Total',
//       'Bar Quantity',
//       'Bar Total',
//       'Grand Quantity',
//       'Grand Total',
//       'Category ID',
//     ];

//     return BlocBuilder<ReportsCubit, ReportsState>(
//       builder: (context, state) {
//         if (state.status == ReportStatus.loading) {
//           return const Align(
//             alignment: Alignment.topCenter,
//             child: CircularProgressIndicator(),
//           );
//         }

//         List<ReportsCategoryModel?> categoryReports = state.categoryReports;

//         return Column(
//           children: [
//             // "Select All" button
//             Align(
//               alignment: Alignment.topRight,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Checkbox(
//                     value: state.isSelectAll ? true : false,
//                     onChanged: (newValue) {
//                       // Toggle select all logic
//                     },
//                   ),
//                   InkWell(
//                     onTap: () {
//                       // Toggle select all logic
//                     },
//                     child: const Text(
//                       'Select All',
//                       style: CustomFontStyle.titleBoldTertiaryStyle,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.only(left: 8.0),
//               width: context.dynamicWidth(0.9),
//               height: context.dynamicHeight(0.6),
//               decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Scrollbar(
//                       controller: horizontalScrollController,
//                       thumbVisibility: true,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         controller: horizontalScrollController,
//                         child: Column(
//                           children: [
//                             // Header
//                             Row(
//                               children: tableTitles.map((title) {
//                                 return Container(
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.black),
//                                     color: Colors.grey,
//                                   ),
//                                   width: cellWidth,
//                                   child: TableCellTitleWidget(title: title),
//                                 );
//                               }).toList(),
//                             ),
//                             // Data rows
//                             Expanded(
//                               child: Scrollbar(
//                                 controller: verticalScrollController,
//                                 thumbVisibility: true,
//                                 child: SingleChildScrollView(
//                                   controller: verticalScrollController,
//                                   child: Column(
//                                     children: categoryReports.map((category) {
//                                       return Row(
//                                         children: [
//                                           SizedBox(
//                                             width: cellWidth,
//                                             child: Checkbox(
//                                               value: false,
//                                               onChanged: (newValue) {
//                                                 // Checkbox logic
//                                               },
//                                             ),
//                                           ),
//                                           _MiddleTableText(text: category?.categoryTitle ?? ''),
//                                           _MiddleTableText(
//                                               text: category?.dineInQuantity.toString() ?? '0'),
//                                           _MiddleTableText(
//                                               text: category?.dineInTotal.toString() ?? '0'),
//                                           _MiddleTableText(
//                                               text: category?.takeOutQuantity.toString() ?? '0'),
//                                           _MiddleTableText(
//                                               text: category?.takeOutTotal.toString() ?? '0'),
//                                           _MiddleTableText(
//                                               text: category?.deliveryQuantity.toString() ?? '0'),
//                                           _MiddleTableText(
//                                               text: category?.deliveryTotal.toString() ?? '0'),
//                                           _MiddleTableText(
//                                               text:
//                                                   category?.quickServiceQuantity.toString() ?? '0'),
//                                           _MiddleTableText(
//                                               text: category?.quickServiceTotal.toString() ?? '0'),
//                                           _MiddleTableText(
//                                               text: category?.barQuantity.toString() ?? '0'),
//                                           _MiddleTableText(
//                                               text: category?.barTotal.toString() ?? '0'),
//                                           _MiddleTableText(
//                                               text: category?.grandQuantity.toString() ?? '0'),
//                                           _MiddleTableText(
//                                               text: category?.grandTotal.toString() ?? '0'),
//                                         ],
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class TableCellTitleWidget extends StatelessWidget {
//   final String title;

//   const TableCellTitleWidget({
//     super.key,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 14,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }

// class _TableCellTextWidget extends StatelessWidget {
//   const _TableCellTextWidget({required this.text});
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const AppPadding.minAll(),
//       child: Center(
//         child: Text(
//           text,
//           maxLines: 1,
//           overflow: TextOverflow.visible,
//         ),
//       ),
//     );
//   }
// }

// class _MiddleTableText extends StatelessWidget {
//   const _MiddleTableText({required this.text});
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//       width: cellWidth,
//       child: _TableCellTextWidget(text: text),
//     );
//   }
// }
