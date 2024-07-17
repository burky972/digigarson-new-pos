// import 'package:a_pos_flutter/product/extension/context/context.dart';
// import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
// import 'package:a_pos_flutter/product/responsive/paddings.dart';
// import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
// import 'package:flutter/material.dart';

// class MenuItemsView extends StatefulWidget {
//   const MenuItemsView({super.key});

//   @override
//   State<MenuItemsView> createState() => _MenuItemsViewState();
// }

// class _MenuItemsViewState extends State<MenuItemsView> with _MenuItemsMixin {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const AppPadding.minAll(),
//       child: Column(
//         children: [
//           SizedBox(
//             height: context.dynamicHeight(0.8),
//             child: Row(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//                   width: context.dynamicWidth(0.2),
//                   child: SingleChildScrollView(
//                       child: Column(
//                     children: [
//                       const Text(
//                         'Group Name',
//                         style: CustomFontStyle.titlesTextStyle,
//                       ),
//                       const SizedBox(height: 10),
//                       Column(
//                         children: List.generate(40, (int index) {
//                           return GestureDetector(
//                             onTap: () {},
//                             child: Container(
//                               // color: index == selectedGroupIndex ? context.colorScheme.tertiary : null,
//                               child: Column(
//                                 children: [
//                                   Text('data $index'),
//                                   const Divider(),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                     ],
//                   )),
//                 ),
//                 Column(
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: context.dynamicWidth(0.4),
//                           height: context.dynamicHeight(0.4),
//                           decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//                           child: Scrollbar(
//                             controller: scrollController,
//                             thumbVisibility: true,
//                             child: SingleChildScrollView(
//                               controller: scrollController,
//                               scrollDirection: Axis.horizontal,
//                               child: SingleChildScrollView(
//                                 controller: horizontalController,
//                                 child: SizedBox(
//                                   width: context.dynamicWidth(0.4),
//                                   child: Table(
//                                     border: TableBorder.all(),
//                                     columnWidths: const <int, TableColumnWidth>{
//                                       0: FlexColumnWidth(80.0),
//                                       1: FixedColumnWidth(70.0),
//                                       2: FixedColumnWidth(70.0),
//                                       3: FixedColumnWidth(70.0),
//                                       4: FixedColumnWidth(70.0),
//                                       5: FixedColumnWidth(70.0),
//                                       6: FixedColumnWidth(70.0),
//                                       7: FixedColumnWidth(70.0),
//                                       8: FixedColumnWidth(70.0),
//                                     },
//                                     children: [
//                                       const TableRow(
//                                         decoration: BoxDecoration(color: Colors.grey),
//                                         children: [
//                                           TableCell(
//                                             child: Center(
//                                                 child: Text('Option Name',
//                                                     style: TextStyle(fontWeight: FontWeight.bold))),
//                                           ),
//                                           TableCell(
//                                             child: Center(
//                                                 child: Text('Price',
//                                                     style: TextStyle(fontWeight: FontWeight.bold))),
//                                           ),
//                                           TableCell(
//                                             child: Center(
//                                                 child: Text('L Price',
//                                                     style: TextStyle(fontWeight: FontWeight.bold))),
//                                           ),
//                                           TableCell(
//                                             child: Center(
//                                                 child: Text('H Price',
//                                                     style: TextStyle(fontWeight: FontWeight.bold))),
//                                           ),
//                                           TableCell(
//                                             child: Center(
//                                                 child: Text('D Price',
//                                                     style: TextStyle(fontWeight: FontWeight.bold))),
//                                           ),
//                                           TableCell(
//                                             child: Center(
//                                                 child: Text('T Price',
//                                                     style: TextStyle(fontWeight: FontWeight.bold))),
//                                           ),
//                                           TableCell(
//                                             child: Center(
//                                                 child: Text('Tax',
//                                                     style: TextStyle(fontWeight: FontWeight.bold))),
//                                           ),
//                                           TableCell(
//                                             child: Center(
//                                                 child: Text('BarTax',
//                                                     style: TextStyle(fontWeight: FontWeight.bold))),
//                                           ),
//                                         ],
//                                       ),
//                                       ...selectedOptionData.asMap().entries.map((entry) {
//                                         int index = entry.key;
//                                         Map<String, dynamic> row = entry.value;
//                                         return TableRow(
//                                           decoration: BoxDecoration(
//                                             color: index == selectedOptionIndex
//                                                 ? context.colorScheme.tertiary
//                                                 : null,
//                                           ),
//                                           children: [
//                                             _TableCellTextWidget(
//                                               onTap: () => onRowTap(index),
//                                               text: row['itemName']!.toString(),
//                                             ),
//                                             _TableCellTextWidget(
//                                               onTap: () => onRowTap(index),
//                                               text: row['price']!.toString(),
//                                             ),
//                                             _TableCellTextWidget(
//                                               onTap: () => onRowTap(index),
//                                               text: row['lPrice']!.toString(),
//                                             ),
//                                             _TableCellTextWidget(
//                                               onTap: () => onRowTap(index),
//                                               text: row['hPrice']!.toString(),
//                                             ),
//                                             _TableCellTextWidget(
//                                               onTap: () => onRowTap(index),
//                                               text: row['dPrice']!.toString(),
//                                             ),
//                                             _TableCellTextWidget(
//                                               onTap: () => onRowTap(index),
//                                               text: row['tPrice']!.toString(),
//                                             ),
//                                             _TableCellTextWidget(
//                                               onTap: () => onRowTap(index),
//                                               text: row['tax']!.toString(),
//                                             ),
//                                             _TableCellTextWidget(
//                                               onTap: () => onRowTap(index),
//                                               text: row['barTax']!.toString(),
//                                             ),
//                                           ],
//                                         );
//                                       }),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Row(
//                       children: [],
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           const Spacer(),
//           // const _BottomButtonFields(),
//         ],
//       ),
//     );
//   }
// }

// class _TableCellTextWidget extends StatelessWidget {
//   const _TableCellTextWidget({required this.onTap, required this.text});
//   final VoidCallback onTap;
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return TableCell(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Padding(
//           padding: const AppPadding.minAll(),
//           child: Center(
//             child: Text(
//               text,
//               maxLines: 24,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// mixin _MenuItemsMixin on State<MenuItemsView> {
//   late List<Map<String, dynamic>> selectedOptionData;
//   int? selectedOptionIndex = 0;
//   int? selectedGroupIndex = 0;
//   final ScrollController scrollController = ScrollController();
//   final ScrollController horizontalController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     selectedOptionData = groupedOptionData[0];
//   }

//   void onRowTap(index) {
//     setState(() {
//       if (selectedOptionIndex == index) {
//         return;
//       } else {
//         selectedOptionIndex = index;
//       }
//     });
//   }

//   final List<List<Map<String, dynamic>>> groupedOptionData = [
//     [
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'New Item Cola',
//         'price': 1.0,
//         'lPrice': 1.0,
//         'hPrice': 1.0,
//         'dPrice': 1.0,
//         'tPrice': 1.0,
//         'tax': 1.0,
//         'barTax': 1.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//       {
//         'itemName': 'Md Juice',
//         'price': 0.0,
//         'lPrice': 0.0,
//         'hPrice': 0.0,
//         'dPrice': 0.0,
//         'tPrice': 0.0,
//         'tax': 0.0,
//         'barTax': 0.0,
//         'percentTax': false,
//       },
//     ]
//   ];
// }
