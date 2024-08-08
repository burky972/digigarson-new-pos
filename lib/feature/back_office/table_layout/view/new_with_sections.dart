// import 'dart:convert';

// import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_cubit.dart';
// import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_state.dart';
// import 'package:a_pos_flutter/feature/back_office/sections/model/section_model.dart';
// import 'package:a_pos_flutter/feature/back_office/table_layout/model/table_layout_model.dart';
// import 'package:a_pos_flutter/product/extension/context/context.dart';
// import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
// import 'package:a_pos_flutter/product/responsive/paddings.dart';
// import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
// import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
// import 'package:a_pos_flutter/product/widget/textfield/custom_border_all_textfield.dart';
// import 'package:core/cache/shared_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'right_table_layout_view.dart';

// class TableLayoutView extends StatefulWidget {
//   const TableLayoutView({super.key});

//   @override
//   State<TableLayoutView> createState() => _TableLayoutViewState();
// }

// class _TableLayoutViewState extends State<TableLayoutView>
//     with SingleTickerProviderStateMixin, TableLayoutMixin {
//   @override
//   void initState() {
//     super.initState();
//     _loadAllTableStates();

//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _tabController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SectionCubit()..init(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Table Layout'),
//         ),
//         body: GestureDetector(
//           onTap: () => setState(() {
//             selectedTable = null;
//           }),
//           child: BlocBuilder<SectionCubit, SectionState>(
//             builder: (context, state) {
//               return Column(
//                 children: [
//                   Expanded(
//                     flex: 8,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         /// left tables list(Section-Object)
//                         Expanded(
//                           flex: 2,
//                           child: Column(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: TabBar(
//                                   labelColor: context.colorScheme.tertiary,
//                                   labelStyle: CustomFontStyle.menuTextStyle
//                                       .copyWith(fontWeight: FontWeight.bold),
//                                   unselectedLabelColor: Colors.black,
//                                   controller: _tabController,
//                                   tabs: const [
//                                     Tab(
//                                       text: 'Section',
//                                     ),
//                                     Tab(text: 'Object'),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 8,
//                                 child: TabBarView(
//                                   controller: _tabController,
//                                   children: [
//                                     Padding(
//                                       padding: const AppPadding.minAll(),
//                                       child: Column(children: [
//                                         Container(
//                                           height: context.dynamicHeight(0.4),
//                                           decoration: BoxDecoration(border: Border.all()),
//                                           width: context.width,
//                                           child: Column(
//                                             children: [
//                                               Padding(
//                                                 padding: const AppPadding.extraMinAll(),
//                                                 child: Text('Section Name',
//                                                     style: CustomFontStyle.titlesTextStyle.copyWith(
//                                                         color: context.colorScheme.tertiary)),
//                                               ),
//                                               SizedBox(height: context.dynamicHeight(0.01)),
//                                               SingleChildScrollView(
//                                                 child: Column(
//                                                   children: state.allSections == null ||
//                                                           state.allSections!.isEmpty
//                                                       ? []
//                                                       : state.allSections!
//                                                           .map(
//                                                             (e) => InkWell(
//                                                               onTap: () => context
//                                                                   .read<SectionCubit>()
//                                                                   .setSelectedSection(
//                                                                       sectionTitle:
//                                                                           e.title.toString()),
//                                                               child: Container(
//                                                                   decoration: BoxDecoration(
//                                                                       color:
//                                                                           state.selectedSection ==
//                                                                                   e.title
//                                                                               ? context.colorScheme
//                                                                                   .tertiary
//                                                                               : null),
//                                                                   child: Container(
//                                                                     width: context.width,
//                                                                     padding: const AppPadding
//                                                                         .extraMinAll(),
//                                                                     decoration: BoxDecoration(
//                                                                         border: Border(
//                                                                       top: _selectedSectionBorder(
//                                                                           e.title.toString()),
//                                                                       bottom:
//                                                                           _selectedSectionBorder(
//                                                                               e.title.toString()),
//                                                                     )),
//                                                                     child: Text(
//                                                                       e.title.toString(),
//                                                                       style: CustomFontStyle
//                                                                           .titlesTextStyle
//                                                                           .copyWith(
//                                                                               color:
//                                                                                   state.selectedSection ==
//                                                                                           e.title
//                                                                                       ? Colors.black
//                                                                                       : Colors
//                                                                                           .grey),
//                                                                     ),
//                                                                   )),
//                                                             ),
//                                                           )
//                                                           .toList(),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(height: context.dynamicHeight(0.01)),
//                                         SizedBox(
//                                           height: context.dynamicHeight(0.07),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               const Text(
//                                                 'Section Name',
//                                                 style: CustomFontStyle.titlesTextStyle,
//                                               ),
//                                               Expanded(
//                                                   child: Padding(
//                                                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                                                 child: CustomBorderAllTextfield(
//                                                   controller: context
//                                                       .read<SectionCubit>()
//                                                       .sectionController,
//                                                   onChanged: (e) {
//                                                     setState(() {
//                                                       _controller.text = e;
//                                                     });
//                                                   },
//                                                 ),
//                                               ))
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: const AppPadding.extraMinAll(),
//                                           height: context.dynamicHeight(0.15),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               const Text(
//                                                 'Floor Color',
//                                                 style: CustomFontStyle.titlesTextStyle,
//                                               ),
//                                               Container(
//                                                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                                                 height: context.dynamicHeight(0.09),
//                                                 decoration: BoxDecoration(
//                                                     border: Border.all(color: Colors.grey)),
//                                                 // child: selectedColor != null
//                                                 //     ? ColoredBox(color: selectedColor!)
//                                                 //     : null,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Row(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Checkbox(
//                                                 value: false,
//                                                 onChanged: (value) {
//                                                   if (value != null) {
//                                                     setState(() {});
//                                                   }
//                                                 },
//                                               ),
//                                               const Text(
//                                                 'Is Bar',
//                                                 style: CustomFontStyle.titlesTextStyle,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ]),
//                                     ),
//                                     SingleChildScrollView(
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: const AppPadding.extraMinAll(),
//                                             child: Text(
//                                               'Select Sections',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .titleSmall
//                                                   ?.copyWith(
//                                                       color: Colors.blue,
//                                                       fontWeight: FontWeight.bold),
//                                             ),
//                                           ),
//                                           DropdownButtonFormField<String>(
//                                             value: state.selectedSection,
//                                             onChanged: (newValue) {
//                                               context
//                                                   .read<SectionCubit>()
//                                                   .setSelectedSection(sectionTitle: newValue!);
//                                             },
//                                             items: state.allSections?.map<DropdownMenuItem<String>>(
//                                                 (SectionModel value) {
//                                               return DropdownMenuItem<String>(
//                                                 value: value.title,
//                                                 child: Text(value.title),
//                                               );
//                                             }).toList(),
//                                           ),
//                                           Padding(
//                                             padding: const AppPadding.extraMinAll(),
//                                             child: Text(
//                                               'Objects',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .titleSmall
//                                                   ?.copyWith(
//                                                       color: Colors.blue,
//                                                       fontWeight: FontWeight.bold),
//                                             ),
//                                           ),
//                                           Wrap(
//                                             children: tableList.asMap().entries.map((entry) {
//                                               int index = entry.key;
//                                               Widget image = entry.value;
//                                               return _buildDraggableTable(index, '', image);
//                                             }).toList(),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Right side - Editing area
//                         Expanded(
//                             flex: 8,
//                             child: _isLoading
//                                 ? const Center(child: CircularProgressIndicator())
//                                 : RightTableLayoutView(
//                                     keyName: state.selectedSection.toString(),
//                                     initialTables: tableStates[state.selectedSection] ?? [],
//                                     onStateChanged: (tables) {
//                                       setState(() {
//                                         tableStates[state.selectedSection!] = tables;
//                                       });
//                                     },
//                                     onSelectedTableChanged: _onSelectedTableChanged,
//                                   )),
//                       ],
//                     ),
//                   ),

//                   ///Bottom Buttons Field
//                   Expanded(
//                     flex: 2,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         children: [
//                           const LightBlueButton(buttonText: 'Add'),
//                           const LightBlueButton(buttonText: 'Del'),
//                           const LightBlueButton(buttonText: 'Edit'),
//                           const Spacer(),
//                           InkWell(
//                               onTap: () {
//                                 _deleteSelectedTable();
//                               },
//                               child: const LightBlueButton(buttonText: 'Delete')),
//                           InkWell(
//                               onTap: () {
//                                 _cleanAllTableStates();
//                               },
//                               child: const LightBlueButton(buttonText: 'Clean')),
//                           InkWell(
//                             onTap: () async => _saveAllTableStates(),
//                             child: const LightBlueButton(buttonText: 'Save'),
//                           ),
//                           InkWell(
//                               onTap: () => Navigator.pop(context),
//                               child: const LightBlueButton(buttonText: 'Exit')),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   BorderSide _selectedSectionBorder(String e) {
//     return BorderSide(color: selectedSection == e ? Colors.black : Colors.grey.shade100);
//   }

//   Widget _buildDraggableTable(int id, String name, Widget assetWidget) {
//     String uniqueId = idGenerator();
//     return Draggable<TableItem>(
//       data: TableItem(
//         id: id,
//         uniqueId: uniqueId,
//         name: name,
//         position: Offset.zero,
//         assetWidget: assetWidget,
//       ),
//       feedback: TableItem(
//               id: id,
//               uniqueId: uniqueId,
//               name: name,
//               position: Offset.zero,
//               assetWidget: assetWidget)
//           .buildTable(),
//       childWhenDragging: Container(),
//       child: TableItem(
//         id: id,
//         uniqueId: uniqueId,
//         name: name,
//         position: Offset.zero,
//         assetWidget: assetWidget,
//       ).buildTable(),
//     );
//   }
// }

// mixin TableLayoutMixin on State<TableLayoutView> {
//   TableItem? selectedTable;
//   GlobalKey rightPanelKey = GlobalKey();
//   final TextEditingController _controller = TextEditingController();

//   String? _selectedOption;
//   late TabController _tabController;
//   Map<String, List<TableItem>> tableStates = {};
//   final List<String> sections = ['COUNTER', 'SECTION1', 'SECTION2', 'BAR'];
//   String? selectedSection;
//   bool _isLoading = false;
//   String idGenerator() {
//     final now = DateTime.now();
//     return now.microsecondsSinceEpoch.toString();
//   }

//   // void setSelectedSection() {
//   //   setState(() {
//   //     selectedSection = sections.first;
//   //     _selectedOption = sections.first;
//   //     _controller.text = sections.first;
//   //   });
//   // }

//   /// clean all sections tables
//   //TODO: when clean func callad ask like are you sure that all tables will be gone!
//   Future<void> _cleanAllTableStates() async {
//     tableStates.forEach((key, tables) async {
//       await SharedManager.instance.removeValue(key);
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         backgroundColor: Colors.red,
//         content: Text('All table states cleaned!'),
//       ),
//     );
//   }

//   /// load all sections table
//   Future<void> _loadAllTableStates() async {
//     setState(() {
//       _isLoading = true;
//     });

//     for (String key in sections) {
//       List<String>? jsonTables = SharedManager.instance.getStringListValue(key);
//       if (jsonTables != null) {
//         List<TableItem> tables = jsonTables.map((jsonTable) {
//           var tableData = json.decode(jsonTable);
//           return TableItem.fromJson(tableData, _getWidgetById(tableData['id']));
//         }).toList();
//         tableStates[key] = tables;
//       } else {
//         tableStates[key] = [];
//       }
//     }

//     setState(() {
//       _isLoading = false;
//     }); // Ensure UI is updated with loaded tables
//   }

//   //! check this delete function
//   Future<void> _deleteSelectedTable() async {
//     if (selectedTable == null) return;
//     TableItem newSelectedTable = selectedTable!;

//     setState(() {
//       List<TableItem> tables = tableStates[_selectedOption] ?? [];
//       tables.removeWhere((table) => table.uniqueId == newSelectedTable.uniqueId);
//       tableStates[_selectedOption!] = tables;
//       selectedTable = null;
//     });
//   }

//   /// get selected table from draggable view
//   Widget _getWidgetById(int id) {
//     return tableList[id];
//   }

//   /// set selected table
//   void _onSelectedTableChanged(TableItem? table) {
//     setState(() {
//       selectedTable = table;
//     });
//   }

//   /// save all section's  draggable tables to cache
//   Future<void> _saveAllTableStates() async {
//     bool hasInvalidTables = false;
//     for (String key in tableStates.keys) {
//       List<TableItem> tables = tableStates[key] ?? [];
//       List<String> jsonTables = tables.map((table) => json.encode(table.toJson())).toList();

//       for (var table in tables) {
//         if (table.id <= 44 && (table.name == null || table.name!.isEmpty)) {
//           hasInvalidTables = true;
//           break;
//         }
//       }
//       if (hasInvalidTables) {
//         break;
//       } else {
//         await SharedManager.instance.setStringListValue(key, jsonTables);
//       }
//     }

//     if (hasInvalidTables) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Be sure that all the placed tables have names')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.red,
//           content: Text('All table states saved!'),
//         ),
//       );
//     }
//   }
// }
