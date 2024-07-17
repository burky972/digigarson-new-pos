// import 'package:flutter/material.dart';
// import 'model/table_layout_model.dart';

// class TableLayoutView extends StatefulWidget {
//   const TableLayoutView({super.key});

//   @override
//   State<TableLayoutView> createState() => _TableLayoutViewState();
// }

// class _TableLayoutViewState extends State<TableLayoutView> {
//   final TableLayoutModel _tableLayoutModel = TableLayoutModel();
//   TableItem? selectedTable;
//   GlobalKey rightPanelKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     _loadPlacedTables();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Table Layout'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.save),
//             onPressed: _savePlacedTables,
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: _cleanPlacedTables,
//           ),
//         ],
//       ),
//       body: GestureDetector(
//         onTap: () => setState(() {
//           selectedTable = null;
//         }),
//         child: Row(
//           children: [
//             // left tables list
//             Expanded(
//               flex: 2,
//               child: SingleChildScrollView(
//                 child: Wrap(
//                   children: tableList.asMap().entries.map((entry) {
//                     int index = entry.key;
//                     Widget image = entry.value;
//                     return _buildDraggableTable(index, '', image);
//                   }).toList(),
//                 ),
//               ),
//             ),
//             // Sağ taraf - Düzenleme alanı
//             Expanded(
//               flex: 8,
//               child: DragTarget<TableItem>(
//                 key: rightPanelKey,
//                 builder: (context, candidateData, rejectedData) {
//                   return GestureDetector(
//                     onDoubleTap: () {
//                       _setTableName(selectedTable);
//                     },
//                     onPanUpdate: (details) {
//                       if (selectedTable != null) {
//                         setState(() {
//                           selectedTable!.position += details.delta;
//                         });
//                       }
//                     },
//                     onTapDown: (details) {
//                       _selectTableAtPosition(details.globalPosition);
//                     },
//                     child: Container(
//                       color: Colors.grey[200],
//                       child: Stack(
//                         children: _tableLayoutModel.placedTables.map((table) {
//                           return Positioned(
//                             left: table.position.dx,
//                             top: table.position.dy,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: selectedTable == table ? Colors.blue : Colors.transparent,
//                                   width: 2,
//                                 ),
//                               ),
//                               child: table.buildTable(),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   );
//                 },
//                 onAcceptWithDetails: (DragTargetDetails<TableItem> details) {
//                   if (!_tableLayoutModel.placedTables.contains(details.data)) {
//                     final RenderBox renderBox =
//                         rightPanelKey.currentContext!.findRenderObject() as RenderBox;
//                     final localOffset = renderBox.globalToLocal(details.offset);
//                     TableItem newTable = TableItem(
//                       id: details.data.id,
//                       name: details.data.name,
//                       position: localOffset,
//                       assetWidget: details.data.assetWidget,
//                     );
//                     setState(() {
//                       _tableLayoutModel.placedTables.add(newTable);
//                       selectedTable = newTable;
//                     });
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _setTableName(TableItem? table) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Enter Table Name'),
//         content: TextField(
//           onChanged: (value) {
//             table!.name = value;
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               setState(() {});
//               Navigator.pop(context);
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _selectTableAtPosition(Offset globalPosition) {
//     final RenderBox renderBox = rightPanelKey.currentContext!.findRenderObject() as RenderBox;
//     final localPosition = renderBox.globalToLocal(globalPosition);

//     setState(() {
//       selectedTable = null;
//       for (var table in _tableLayoutModel.placedTables.reversed) {
//         if (_isPositionInsideTable(localPosition, table)) {
//           selectedTable = table;
//           break;
//         }
//       }
//     });
//   }

//   bool _isPositionInsideTable(Offset position, TableItem table) {
//     return position.dx >= table.position.dx &&
//         position.dx <= table.position.dx + 100 && // Masa genişliği
//         position.dy >= table.position.dy &&
//         position.dy <= table.position.dy + 100; // Masa yüksekliği
//   }

//   Widget _buildDraggableTable(int id, String name, Widget assetWidget) {
//     return Draggable<TableItem>(
//       data: TableItem(id: id, name: name, position: Offset.zero, assetWidget: assetWidget),
//       feedback: TableItem(id: id, name: name, position: Offset.zero, assetWidget: assetWidget)
//           .buildTable(),
//       childWhenDragging: Container(),
//       child: TableItem(
//         id: id,
//         name: name,
//         position: Offset.zero,
//         assetWidget: assetWidget,
//       ).buildTable(),
//     );
//   }

//   Future<void> _savePlacedTables() async {
//     for (var table in _tableLayoutModel.placedTables) {
//       if (table.id <= 44) {
//         if (table.name == null || table.name!.isEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Be sure that all the placed tables have names')));
//           return;
//         }
//       }
//     }
//     await _tableLayoutModel.savePlacedTables();
//     debugPrint("PLACED TABLES SAVED");
//   }

//   Future<void> _cleanPlacedTables() async {
//     await _tableLayoutModel.cleanPlacedTables();
//     debugPrint("PLACED TABLES CLEANED");
//   }

//   Future<void> _loadPlacedTables() async {
//     await _tableLayoutModel.loadPlacedTables();
//     setState(() {});
//     debugPrint("PLACED TABLES LOADED");
//   }
// }
