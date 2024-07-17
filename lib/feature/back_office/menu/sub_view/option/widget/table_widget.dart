// part of '../view/menu_option_view.dart';

// class _TableWidget extends StatelessWidget {
//   const _TableWidget(
//       {required this.selectedOptionIndex,
//       required this.selectedOptionData,
//       required this.onRowTap});
//   final int selectedOptionIndex;
//   final List<Map<String, dynamic>> selectedOptionData;
//   final Function(int) onRowTap;

//   @override
//   Widget build(BuildContext context) {
//     return Table(
//       border: TableBorder.all(),
//       columnWidths: const <int, TableColumnWidth>{
//         0: FlexColumnWidth(),
//         1: FlexColumnWidth(),
//         2: FixedColumnWidth(80.0),
//         3: FixedColumnWidth(80.0),
//         4: FixedColumnWidth(80.0),
//         5: FixedColumnWidth(80.0),
//         6: FixedColumnWidth(80.0),
//         7: FixedColumnWidth(80.0),
//         8: FixedColumnWidth(80.0),
//         9: FixedColumnWidth(80.0),
//       },
//       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//       children: [
//         const TableRow(
//           decoration: BoxDecoration(color: Colors.grey),
//           children: [
//             TableCell(
//               child:
//                   Center(child: Text('Option Name', style: TextStyle(fontWeight: FontWeight.bold))),
//             ),
//             TableCell(
//               child:
//                   Center(child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold))),
//             ),
//             TableCell(
//               child: Center(child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold))),
//             ),
//             TableCell(
//               child: Center(child: Text('L Price', style: TextStyle(fontWeight: FontWeight.bold))),
//             ),
//             TableCell(
//               child: Center(child: Text('H Price', style: TextStyle(fontWeight: FontWeight.bold))),
//             ),
//             TableCell(
//               child: Center(child: Text('D Price', style: TextStyle(fontWeight: FontWeight.bold))),
//             ),
//             TableCell(
//               child: Center(child: Text('T Price', style: TextStyle(fontWeight: FontWeight.bold))),
//             ),
//             TableCell(
//               child: Center(child: Text('Tax', style: TextStyle(fontWeight: FontWeight.bold))),
//             ),
//             TableCell(
//               child: Center(child: Text('BarTax', style: TextStyle(fontWeight: FontWeight.bold))),
//             ),
//           ],
//         ),
//         ...selectedOptionData.asMap().entries.map((entry) {
//           int index = entry.key;
//           Map<String, dynamic> row = entry.value;
//           return TableRow(
//             decoration: BoxDecoration(
//               color: index == selectedOptionIndex ? context.colorScheme.tertiary : null,
//             ),
//             children: [
//               _TableCellTextWidget(
//                 onTap: () => onRowTap(index),
//                 text: row['optionName']!.toString(),
//               ),
//               _TableCellTextWidget(
//                 onTap: () => onRowTap(index),
//                 text: row['optionDescription']!.toString(),
//               ),
//               _TableCellTextWidget(
//                 onTap: () => onRowTap(index),
//                 text: row['price']!.toString(),
//               ),
//               _TableCellTextWidget(
//                 onTap: () => onRowTap(index),
//                 text: row['lPrice']!.toString(),
//               ),
//               _TableCellTextWidget(
//                 onTap: () => onRowTap(index),
//                 text: row['hPrice']!.toString(),
//               ),
//               _TableCellTextWidget(
//                 onTap: () => onRowTap(index),
//                 text: row['dPrice']!.toString(),
//               ),
//               _TableCellTextWidget(
//                 onTap: () => onRowTap(index),
//                 text: row['tPrice']!.toString(),
//               ),
//               _TableCellTextWidget(
//                 onTap: () => onRowTap(index),
//                 text: row['tax']!.toString(),
//               ),
//               _TableCellTextWidget(
//                 onTap: () => onRowTap(index),
//                 text: row['barTax']!.toString(),
//               ),
//             ],
//           );
//         }),
//       ],
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
//           padding: const EdgeInsets.all(8.0),
//           child: Center(
//             child: Text(
//               text,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
