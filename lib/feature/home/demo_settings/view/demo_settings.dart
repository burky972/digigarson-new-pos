// import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/model/category_model.dart';
// import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
// import 'package:a_pos_flutter/product/global/model/print/customer_printer_model.dart';
// import 'package:a_pos_flutter/product/widget/keyboard/custom_search_keyboard.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Setting extends StatefulWidget {
//   const Setting({super.key});

//   @override
//   _SettingState createState() => _SettingState();
// }

// class _SettingState extends State<Setting> {
//   String dropdownValue1 = 'Option 1';
//   CustomPrinterModel? dropdownValue2;
//   CategoryModel? dropdownValue3;
//   TextEditingController textController1 = TextEditingController();
//   TextEditingController textController2 = TextEditingController();
//   final FocusNode _1Node = FocusNode();
//   final FocusNode _2Node = FocusNode();
//   List<String> createdItems = [];
//   TextEditingController ipController = TextEditingController();
//   TextEditingController portController = TextEditingController();
//   OverlayEntry? _overlayEntry;

//   @override
//   void initState() {
//     super.initState();
//   }

//   void toggleFullScreen() {
//     if (_overlayEntry != null) {
//       _overlayEntry?.remove();
//       _overlayEntry = null;
//     }
//   }

//   void _showCustomKeyKeyboard(
//       BuildContext context, TextEditingController controller, FocusNode focusNode) {
//     if (_overlayEntry != null) {
//       _overlayEntry?.remove();
//       _overlayEntry = null;
//     }
//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         bottom: 5,
//         left: (MediaQuery.of(context).size.width - 840) / 2,
//         right: (MediaQuery.of(context).size.width - 840) / 2,
//         child: CustomSearchKeyboard(
//           onKeyPressed: (value) {
//             FocusScope.of(context).unfocus();
//             FocusScope.of(context).requestFocus(focusNode);
//             final oldSelection = controller.selection;
//             if (value.toString() == "clear") {
//               final currentOffset = oldSelection.baseOffset;
//               if (currentOffset > 0) {
//                 controller.text = controller.text.substring(0, currentOffset - 1) +
//                     controller.text.substring(currentOffset);
//                 controller.selection = TextSelection.collapsed(offset: currentOffset - 1);
//               }
//             } else if (value.toString() == "close") {
//               toggleFullScreen();
//             } else {
//               controller.text = controller.text.replaceRange(
//                 oldSelection.start,
//                 oldSelection.end,
//                 value,
//               );
//               controller.selection = TextSelection.collapsed(
//                 offset: oldSelection.baseOffset + value.length,
//               );
//             }
//             context.read<BranchCubit>().setFilter(controller.text);
//           },
//         ),
//       ),
//     );
//     Overlay.of(context).insert(_overlayEntry!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('POS Yazıcı Bağlantısı'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Consumer<PrinterProvider>(builder: ((context, printerProvider, child) {
//           if (Provider.of<PrinterProvider>(context, listen: false).CasePrinter != null) {
//             textController1.text = Provider.of<PrinterProvider>(context, listen: false)
//                 .CasePrinter!
//                 .comment
//                 .toString();
//           }
//           return printerProvider.AllPrinterList.length > 0
//               ? Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: 230.0,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             color: Colors.grey[200],
//                           ),
//                           child: DropdownButton(
//                             underline: null,
//                             value: printerProvider.CasePrinter,
//                             icon: const Icon(Icons.arrow_drop_down),
//                             iconSize: 24,
//                             elevation: 16,
//                             style: const TextStyle(color: Colors.black),
//                             onChanged: (CustomPrinterModel? newValue) {
//                               newValue!.comment = textController1.text;
//                               //  print(newValue.comment);
//                             },
//                             items: printerProvider.AllPrinterList.map(
//                               (CustomPrinterModel printer) {
//                                 return DropdownMenuItem(
//                                   value: printer,
//                                   child: Text(printer.name),
//                                 );
//                               },
//                             ).toList(),
//                           ),
//                         ),
//                         const SizedBox(height: 16.0),
//                         SizedBox(
//                           width: 230.0,
//                           child: TextField(
//                             controller: textController1,
//                             focusNode: _1Node,
//                             keyboardType: TextInputType.none,
//                             decoration: const InputDecoration(
//                               hintText: 'Enter text',
//                             ),
//                             onChanged: (text) {
//                               textController1.text = text;
//                               if (printerProvider.casePrinter != null) {
//                                 printerProvider.casePrinter!.comment = text;
//                                 printerProvider.casePrinterSet(printerProvider.casePrinter!);
//                               }
//                             },
//                             onTap: () {
//                               _showCustomKeyKeyboard(context, textController1, _1Node);
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 16.0),
//                         SizedBox(
//                           width: 230,
//                           height: 50,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               printerProvider.setSelectedEditPrinter(printerProvider.CasePrinter);

//                               PrintDetailDialog()
//                                   .showEditDialog(context, printerProvider.CasePrinter!, index: 1);
//                             },
//                             child: const Text('Gelişmiş Ayarlar'),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 250,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Container(
//                                 width: 200.0,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   color: Colors.grey[200],
//                                 ),
//                                 child: DropdownButton(
//                                   value: dropdownValue2 ?? printerProvider.AllPrinterList.first,
//                                   onChanged: (CustomPrinterModel? newValue) {
//                                     setState(() {
//                                       dropdownValue2 = newValue!;
//                                     });
//                                   },
//                                   items: printerProvider.AllPrinterList.map(
//                                       (CustomPrinterModel printer) {
//                                     return DropdownMenuItem(
//                                       value: printer,
//                                       child: Text(printer.name),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                               const SizedBox(height: 16.0),
//                               SizedBox(
//                                 width: 200.0,
//                                 height: 50,
//                                 child: TextField(
//                                   controller: textController2,
//                                   focusNode: _2Node,
//                                   decoration: const InputDecoration(
//                                     hintText: 'Enter text',
//                                   ),
//                                   onChanged: (text) {
//                                     textController2.text = text;
//                                   },
//                                   onTap: () {
//                                     _showCustomKeyKeyboard(context, textController2, _2Node);
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(height: 16.0),
//                               SizedBox(
//                                 width: 100,
//                                 height: 50,
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     printerProvider.customPrinterListAdd(CustomPrinterModel(
//                                         url: dropdownValue2!.url,
//                                         name: dropdownValue2!.name,
//                                         showName: textController2.text.toString(),
//                                         fontSize: dropdownValue2!.fontSize,
//                                         totalFontSize: dropdownValue2!.totalFontSize,
//                                         titleFontSize: dropdownValue2!.titleFontSize,
//                                         subFontSize: dropdownValue2!.subFontSize,
//                                         productFontSize: dropdownValue2!.productFontSize,
//                                         priceFontSize: dropdownValue2!.priceFontSize,
//                                         optionFontSize: dropdownValue2!.optionFontSize,
//                                         noteFontSize: dropdownValue2!.noteFontSize,
//                                         pdfPageSize: dropdownValue2!.pdfPageSize,
//                                         isGeneralPrinter: false,
//                                         customField: dropdownValue2!.customField,
//                                         categoryIdList: [],
//                                         productIdList: [],
//                                         tableIdList: []));
//                                     setState(() {
//                                       textController2.clear();
//                                     });
//                                   },
//                                   child: const Text('Oluştur'),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: ListView.builder(
//                                     itemCount: printerProvider.CustomPrinterList.length,
//                                     padding: const EdgeInsets.only(top: 10, bottom: 20),
//                                     itemBuilder: (context, index) => Padding(
//                                           padding: const EdgeInsets.only(bottom: 5.0),
//                                           child: InkWell(
//                                             onTap: () {
//                                               printerProvider.setSelectedPrinter(
//                                                   printerProvider.SelectedCustomPrinter ==
//                                                           printerProvider.CustomPrinterList[index]
//                                                       ? null
//                                                       : printerProvider.CustomPrinterList[index]);
//                                             },
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(color: Colors.black, width: 2),
//                                                   borderRadius: BorderRadius.circular(4),
//                                                   color: printerProvider.SelectedCustomPrinter !=
//                                                           null
//                                                       ? (printerProvider.SelectedCustomPrinter ==
//                                                               printerProvider
//                                                                   .CustomPrinterList[index]
//                                                           ? Colors.greenAccent
//                                                           : Colors.white)
//                                                       : Colors.white),
//                                               padding: const EdgeInsets.all(5),
//                                               child: Row(
//                                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                                 children: [
//                                                   SizedBox(
//                                                     width: 180,
//                                                     child: Text(
//                                                       '${printerProvider.CustomPrinterList[index].showName} | ${printerProvider.CustomPrinterList[index].name}',
//                                                       style: const TextStyle(
//                                                         fontSize: 17,
//                                                         fontWeight: FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(width: 10),
//                                                   IconButton(
//                                                     icon:
//                                                         const Icon(Icons.delete, color: Colors.red),
//                                                     onPressed: () {
//                                                       printerProvider.CustomPrinterList[index] ==
//                                                               printerProvider.SelectedCustomPrinter
//                                                           ? printerProvider.setSelectedPrinter(null)
//                                                           : null;
//                                                       printerProvider.customPrinterListDel(
//                                                           printerProvider.CustomPrinterList[index]);
//                                                     },
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         )),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 16.0),
//                         printerProvider.SelectedCustomPrinter != null
//                             ? SizedBox(
//                                 width: 310,
//                                 child: DefaultTabController(
//                                   length: 4,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                                     children: [
//                                       const TabBar(
//                                         tabs: [
//                                           Tab(text: 'Table'),
//                                           Tab(text: 'Category'),
//                                           Tab(text: 'Product'),
//                                           Tab(text: 'Edit'),
//                                         ],
//                                       ),
//                                       Expanded(
//                                         child: TabBarView(
//                                           children: [
//                                             ListView.builder(
//                                                 itemCount: Provider.of<MyBranchProvider>(context,
//                                                         listen: false)
//                                                     .myBranch!
//                                                     .tables
//                                                     .length,
//                                                 padding: const EdgeInsets.only(top: 10, bottom: 20),
//                                                 itemBuilder: (context, index) => Padding(
//                                                       padding: const EdgeInsets.only(bottom: 5.0),
//                                                       child: InkWell(
//                                                         onTap: () {
//                                                           printerProvider.setSelectedPrinterEdit(
//                                                               Provider.of<MyBranchProvider>(context,
//                                                                       listen: false)
//                                                                   .myBranch!
//                                                                   .tables[index]
//                                                                   .sId,
//                                                               2);
//                                                         },
//                                                         child: Container(
//                                                           decoration: BoxDecoration(
//                                                               border: Border.all(
//                                                                   color: Colors.black, width: 2),
//                                                               borderRadius:
//                                                                   BorderRadius.circular(4),
//                                                               color: printerProvider
//                                                                           .SelectedCustomPrinter !=
//                                                                       null
//                                                                   ? (printerProvider
//                                                                           .SelectedCustomPrinter!
//                                                                           .tableIdList
//                                                                           .any((tbl) =>
//                                                                               tbl ==
//                                                                               Provider.of<MyBranchProvider>(
//                                                                                       context,
//                                                                                       listen: false)
//                                                                                   .myBranch!
//                                                                                   .tables[index]
//                                                                                   .sId)
//                                                                       ? Colors.greenAccent
//                                                                       : Colors.white)
//                                                                   : Colors.white),
//                                                           padding: const EdgeInsets.all(5),
//                                                           child: Container(
//                                                             child: Center(
//                                                               child: Text(
//                                                                 '${Provider.of<MyBranchProvider>(context, listen: false).myBranch!.sections.where((element) => element.sId == Provider.of<MyBranchProvider>(context, listen: false).myBranch!.tables[index].section.toString()).first.title}  ${Provider.of<MyBranchProvider>(context, listen: false).myBranch!.tables[index].title}',
//                                                                 style: const TextStyle(
//                                                                   fontSize: 17,
//                                                                   fontWeight: FontWeight.bold,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     )),
//                                             ListView.builder(
//                                                 itemCount: Provider.of<MyBranchProvider>(context,
//                                                         listen: false)
//                                                     .OrgiCategoryList
//                                                     .length,
//                                                 padding: const EdgeInsets.only(top: 10, bottom: 20),
//                                                 itemBuilder: (context, index) => Padding(
//                                                       padding: const EdgeInsets.only(bottom: 5.0),
//                                                       child: InkWell(
//                                                         onTap: () {
//                                                           printerProvider.setSelectedPrinterEdit(
//                                                               Provider.of<MyBranchProvider>(context,
//                                                                       listen: false)
//                                                                   .OrgiCategoryList[index]
//                                                                   .sId,
//                                                               0);
//                                                           setState(() {
//                                                             dropdownValue3 = null;
//                                                           });
//                                                         },
//                                                         child: Container(
//                                                           decoration: BoxDecoration(
//                                                               border: Border.all(
//                                                                   color: Colors.black, width: 2),
//                                                               borderRadius:
//                                                                   BorderRadius.circular(4),
//                                                               color: printerProvider
//                                                                           .SelectedCustomPrinter !=
//                                                                       null
//                                                                   ? (printerProvider
//                                                                           .SelectedCustomPrinter!
//                                                                           .categoryIdList
//                                                                           .any((tbl) =>
//                                                                               tbl ==
//                                                                               Provider.of<MyBranchProvider>(
//                                                                                       context,
//                                                                                       listen: false)
//                                                                                   .OrgiCategoryList[
//                                                                                       index]
//                                                                                   .sId)
//                                                                       ? Colors.greenAccent
//                                                                       : Colors.white)
//                                                                   : Colors.white),
//                                                           padding: const EdgeInsets.all(5),
//                                                           child: Container(
//                                                             child: Center(
//                                                               child: Text(
//                                                                 '${Provider.of<MyBranchProvider>(context, listen: false).OrgiCategoryList[index].title}',
//                                                                 style: const TextStyle(
//                                                                   fontSize: 17,
//                                                                   fontWeight: FontWeight.bold,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     )),
//                                             (printerProvider.SelectedCustomPrinter != null
//                                                     ? Provider.of<MyBranchProvider>(context,
//                                                                 listen: false)
//                                                             .OrgiCategoryList
//                                                             .where((category) => !printerProvider
//                                                                 .SelectedCustomPrinter!
//                                                                 .categoryIdList
//                                                                 .contains(category.sId))
//                                                             .length >
//                                                         0
//                                                     : false)
//                                                 ? Column(
//                                                     children: [
//                                                       Container(
//                                                         width: 230.0,
//                                                         height: 50,
//                                                         decoration: BoxDecoration(
//                                                           borderRadius: BorderRadius.circular(8.0),
//                                                           color: Colors.grey[200],
//                                                         ),
//                                                         child: DropdownButton(
//                                                           value: (dropdownValue3 ??
//                                                               Provider.of<MyBranchProvider>(context,
//                                                                       listen: false)
//                                                                   .OrgiCategoryList
//                                                                   .where((category) =>
//                                                                       !printerProvider
//                                                                           .SelectedCustomPrinter!
//                                                                           .categoryIdList
//                                                                           .contains(category.sId))
//                                                                   .first),
//                                                           onChanged: (newValue) {
//                                                             setState(() {
//                                                               dropdownValue3 = newValue;
//                                                             });
//                                                           },
//                                                           items: (printerProvider
//                                                                           .SelectedCustomPrinter!
//                                                                           .categoryIdList
//                                                                           .length >
//                                                                       0
//                                                                   ? Provider.of<MyBranchProvider>(
//                                                                           context,
//                                                                           listen: false)
//                                                                       .OrgiCategoryList
//                                                                       .where((category) => !printerProvider
//                                                                           .SelectedCustomPrinter!
//                                                                           .categoryIdList
//                                                                           .contains(category.sId))
//                                                                   : Provider.of<MyBranchProvider>(
//                                                                           context,
//                                                                           listen: false)
//                                                                       .OrgiCategoryList)
//                                                               .map((CategoryModel categories) {
//                                                             return DropdownMenuItem(
//                                                               value: categories,
//                                                               child: Text(categories.title),
//                                                             );
//                                                           }).toList(),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         child: ListView.builder(
//                                                             itemCount: dropdownValue3 != null
//                                                                 ? Provider.of<MyBranchProvider>(context,
//                                                                         listen: false)
//                                                                     .myBranch!
//                                                                     .products
//                                                                     .where((product) =>
//                                                                         product.category ==
//                                                                         dropdownValue3!.sId)
//                                                                     .length
//                                                                 : Provider.of<MyBranchProvider>(context,
//                                                                         listen: false)
//                                                                     .myBranch!
//                                                                     .products
//                                                                     .where((product) =>
//                                                                         product.category ==
//                                                                         Provider.of<MyBranchProvider>(
//                                                                                 context,
//                                                                                 listen: false)
//                                                                             .OrgiCategoryList
//                                                                             .where((category) => !printerProvider
//                                                                                 .SelectedCustomPrinter!
//                                                                                 .categoryIdList
//                                                                                 .contains(category.sId))
//                                                                             .first
//                                                                             .sId)
//                                                                     .length,
//                                                             padding: const EdgeInsets.only(top: 10, bottom: 20),
//                                                             itemBuilder: (context, index) => Padding(
//                                                                   padding: const EdgeInsets.only(
//                                                                       bottom: 5.0),
//                                                                   child: InkWell(
//                                                                     onTap: () {
//                                                                       printerProvider.setSelectedPrinterEdit(
//                                                                           dropdownValue3 != null
//                                                                               ? Provider.of<MyBranchProvider>(
//                                                                                       context,
//                                                                                       listen: false)
//                                                                                   .myBranch!
//                                                                                   .products
//                                                                                   .where((product) =>
//                                                                                       product.category ==
//                                                                                       dropdownValue3!
//                                                                                           .sId)
//                                                                                   .toList()[index]
//                                                                                   .sId
//                                                                               : Provider.of<MyBranchProvider>(
//                                                                                       context,
//                                                                                       listen: false)
//                                                                                   .myBranch!
//                                                                                   .products
//                                                                                   .where((product) =>
//                                                                                       product
//                                                                                           .category ==
//                                                                                       Provider.of<MyBranchProvider>(
//                                                                                               context,
//                                                                                               listen:
//                                                                                                   false)
//                                                                                           .OrgiCategoryList
//                                                                                           .where((category) => !printerProvider.SelectedCustomPrinter!.categoryIdList.contains(category.sId))
//                                                                                           .first
//                                                                                           .sId)
//                                                                                   .toList()[index]
//                                                                                   .sId,
//                                                                           1);
//                                                                     },
//                                                                     child: Container(
//                                                                       decoration: BoxDecoration(
//                                                                           border: Border.all(
//                                                                               color: Colors.black,
//                                                                               width: 2),
//                                                                           borderRadius:
//                                                                               BorderRadius.circular(
//                                                                                   4),
//                                                                           color: printerProvider
//                                                                                       .SelectedCustomPrinter !=
//                                                                                   null
//                                                                               ? (printerProvider
//                                                                                       .SelectedCustomPrinter!
//                                                                                       .productIdList
//                                                                                       .any((tbl) =>
//                                                                                           tbl ==
//                                                                                           (dropdownValue3 !=
//                                                                                                   null
//                                                                                               ? Provider.of<MyBranchProvider>(context, listen: false)
//                                                                                                   .myBranch!
//                                                                                                   .products
//                                                                                                   .where((product) => product.category == dropdownValue3!.sId)
//                                                                                                   .toList()[index]
//                                                                                                   .sId
//                                                                                               : Provider.of<MyBranchProvider>(context, listen: false).myBranch!.products.where((product) => product.category == Provider.of<MyBranchProvider>(context, listen: false).OrgiCategoryList.where((category) => !printerProvider.SelectedCustomPrinter!.categoryIdList.contains(category.sId)).first.sId).toList()[index].sId))
//                                                                                   ? Colors.greenAccent
//                                                                                   : Colors.white)
//                                                                               : Colors.white),
//                                                                       padding:
//                                                                           const EdgeInsets.all(5),
//                                                                       child: Container(
//                                                                         child: Center(
//                                                                           child: Text(
//                                                                             '${dropdownValue3 != null ? Provider.of<MyBranchProvider>(context, listen: false).myBranch!.products.where((product) => product.category == dropdownValue3!.sId).toList()[index].title : Provider.of<MyBranchProvider>(context, listen: false).myBranch!.products.where((product) => product.category == Provider.of<MyBranchProvider>(context, listen: false).OrgiCategoryList.where((category) => !printerProvider.SelectedCustomPrinter!.categoryIdList.contains(category.sId)).first.sId).toList()[index].title}',
//                                                                             style: const TextStyle(
//                                                                               fontSize: 17,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 )),
//                                                       ),
//                                                     ],
//                                                   )
//                                                 : const SizedBox(),
//                                             ListView(
//                                               children: [
//                                                 _buildCounterWithSettings(
//                                                     "Font Size",
//                                                     printerProvider.SelectedCustomPrinter!.fontSize,
//                                                     printerProvider,
//                                                     context),
//                                                 _buildCounterWithSettings(
//                                                     "Note Font Size",
//                                                     printerProvider
//                                                         .SelectedCustomPrinter!.noteFontSize,
//                                                     printerProvider,
//                                                     context),
//                                                 _buildCounterWithSettings(
//                                                     "Option Font Size",
//                                                     printerProvider
//                                                         .SelectedCustomPrinter!.optionFontSize,
//                                                     printerProvider,
//                                                     context),
//                                                 _buildCounterWithSettings(
//                                                     "Price Font Size",
//                                                     printerProvider
//                                                         .SelectedCustomPrinter!.priceFontSize,
//                                                     printerProvider,
//                                                     context),
//                                                 _buildCounterWithSettings(
//                                                     "Product Font Size",
//                                                     printerProvider
//                                                         .SelectedCustomPrinter!.productFontSize,
//                                                     printerProvider,
//                                                     context),
//                                                 _buildCounterWithSettings(
//                                                     "Sub Font Size",
//                                                     printerProvider
//                                                         .SelectedCustomPrinter!.subFontSize,
//                                                     printerProvider,
//                                                     context),
//                                                 _buildCounterWithSettings(
//                                                     "Title Font Size",
//                                                     printerProvider
//                                                         .SelectedCustomPrinter!.titleFontSize,
//                                                     printerProvider,
//                                                     context),
//                                                 _buildCounterWithSettings(
//                                                     "Total Font Size",
//                                                     printerProvider
//                                                         .SelectedCustomPrinter!.totalFontSize,
//                                                     printerProvider,
//                                                     context),
//                                                 _buildCounterDoubleWithSettings(
//                                                     "PDF Page Size",
//                                                     printerProvider
//                                                         .SelectedCustomPrinter!.pdfPageSize,
//                                                     context),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             : const SizedBox(),
//                       ],
//                     ),
//                   ],
//                 )
//               : const SizedBox();
//         })),
//       ),
//     );
//   }

//   Widget _buildCounterWithSettings(
//       String title, double initialValue, PrinterProvider printerProvider, BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//             width: MediaQuery.of(context).size.width * .3,
//             constraints: const BoxConstraints(minWidth: 80, maxWidth: 150),
//             child: Text(
//               title,
//               style: const TextStyle(fontSize: 15),
//             )),
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//           width: MediaQuery.of(context).size.width * .3,
//           height: MediaQuery.of(context).size.height * .2,
//           constraints:
//               const BoxConstraints(minWidth: 160, maxWidth: 160, minHeight: 40, maxHeight: 45),
//           child: AnimatedCounter(
//             key: ValueKey(initialValue),
//             Counter: initialValue.toInt() > 0 ? initialValue.toInt() : 1,
//             onKeyPressed: (qty) {
//               switch (title) {
//                 case "Font Size":
//                   if (printerProvider.customPrinterList.indexWhere((print) =>
//                               print.name ==
//                               printerProvider.selectedCustomPrinter!.name.toString()) >=
//                           0 &&
//                       printerProvider.selectedCustomPrinter != null) {
//                     printerProvider.selectedCustomPrinter!.fontSize = double.parse(qty);
//                     printerProvider.customPrinterList[printerProvider.customPrinterList.indexWhere(
//                             (print) =>
//                                 print.name ==
//                                 printerProvider.selectedCustomPrinter!.name.toString())] =
//                         printerProvider.SelectedCustomPrinter!;
//                     printerProvider.savePrinters(printerProvider.customPrinterList);
//                   }
//                   break;
//                 case "Note Font Size":
//                   if (printerProvider.customPrinterList.indexWhere((print) =>
//                               print.name ==
//                               printerProvider.selectedCustomPrinter!.name.toString()) >=
//                           0 &&
//                       printerProvider.selectedCustomPrinter != null) {
//                     printerProvider.selectedCustomPrinter!.noteFontSize = double.parse(qty);
//                     printerProvider.customPrinterList[printerProvider.customPrinterList.indexWhere(
//                             (print) =>
//                                 print.name ==
//                                 printerProvider.selectedCustomPrinter!.name.toString())] =
//                         printerProvider.SelectedCustomPrinter!;
//                     printerProvider.savePrinters(printerProvider.customPrinterList);
//                   }
//                   break;
//                 case "Option Font Size":
//                   if (printerProvider.customPrinterList.indexWhere((print) =>
//                               print.name ==
//                               printerProvider.selectedCustomPrinter!.name.toString()) >=
//                           0 &&
//                       printerProvider.selectedCustomPrinter != null) {
//                     printerProvider.selectedCustomPrinter!.optionFontSize = double.parse(qty);
//                     printerProvider.customPrinterList[printerProvider.customPrinterList.indexWhere(
//                             (print) =>
//                                 print.name ==
//                                 printerProvider.selectedCustomPrinter!.name.toString())] =
//                         printerProvider.SelectedCustomPrinter!;
//                     printerProvider.savePrinters(printerProvider.customPrinterList);
//                   }
//                   break;
//                 case "Price Font Size":
//                   if (printerProvider.customPrinterList.indexWhere((print) =>
//                               print.name ==
//                               printerProvider.selectedCustomPrinter!.name.toString()) >=
//                           0 &&
//                       printerProvider.selectedCustomPrinter != null) {
//                     printerProvider.selectedCustomPrinter!.priceFontSize = double.parse(qty);
//                     printerProvider.customPrinterList[printerProvider.customPrinterList.indexWhere(
//                             (print) =>
//                                 print.name ==
//                                 printerProvider.selectedCustomPrinter!.name.toString())] =
//                         printerProvider.SelectedCustomPrinter!;
//                     printerProvider.savePrinters(printerProvider.customPrinterList);
//                   }
//                   break;
//                 case "Product Font Size":
//                   if (printerProvider.customPrinterList.indexWhere((print) =>
//                               print.name ==
//                               printerProvider.selectedCustomPrinter!.name.toString()) >=
//                           0 &&
//                       printerProvider.selectedCustomPrinter != null) {
//                     printerProvider.selectedCustomPrinter!.productFontSize = double.parse(qty);
//                     printerProvider.customPrinterList[printerProvider.customPrinterList.indexWhere(
//                             (print) =>
//                                 print.name ==
//                                 printerProvider.selectedCustomPrinter!.name.toString())] =
//                         printerProvider.SelectedCustomPrinter!;
//                     printerProvider.savePrinters(printerProvider.customPrinterList);
//                   }
//                   break;
//                 case "Sub Font Size":
//                   if (printerProvider.customPrinterList.indexWhere((print) =>
//                               print.name ==
//                               printerProvider.selectedCustomPrinter!.name.toString()) >=
//                           0 &&
//                       printerProvider.selectedCustomPrinter != null) {
//                     printerProvider.selectedCustomPrinter!.subFontSize = double.parse(qty);
//                     printerProvider.customPrinterList[printerProvider.customPrinterList.indexWhere(
//                             (print) =>
//                                 print.name ==
//                                 printerProvider.selectedCustomPrinter!.name.toString())] =
//                         printerProvider.SelectedCustomPrinter!;
//                     printerProvider.savePrinters(printerProvider.customPrinterList);
//                   }
//                   break;
//                 case "Title Font Size":
//                   if (printerProvider.customPrinterList.indexWhere((print) =>
//                               print.name ==
//                               printerProvider.selectedCustomPrinter!.name.toString()) >=
//                           0 &&
//                       printerProvider.selectedCustomPrinter != null) {
//                     printerProvider.selectedCustomPrinter!.titleFontSize = double.parse(qty);
//                     printerProvider.customPrinterList[printerProvider.customPrinterList.indexWhere(
//                             (print) =>
//                                 print.name ==
//                                 printerProvider.selectedCustomPrinter!.name.toString())] =
//                         printerProvider.SelectedCustomPrinter!;
//                     printerProvider.savePrinters(printerProvider.customPrinterList);
//                   }
//                   break;
//                 case "Total Font Size":
//                   if (printerProvider.customPrinterList.indexWhere((print) =>
//                               print.name ==
//                               printerProvider.selectedCustomPrinter!.name.toString()) >=
//                           0 &&
//                       printerProvider.selectedCustomPrinter != null) {
//                     printerProvider.selectedCustomPrinter!.totalFontSize = double.parse(qty);
//                     printerProvider.customPrinterList[printerProvider.customPrinterList.indexWhere(
//                             (print) =>
//                                 print.name ==
//                                 printerProvider.selectedCustomPrinter!.name.toString())] =
//                         printerProvider.SelectedCustomPrinter!;
//                     printerProvider.savePrinters(printerProvider.customPrinterList);
//                   }
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCounterDoubleWithSettings(String title, double initialValue, BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//             width: MediaQuery.of(context).size.width * .3,
//             constraints: const BoxConstraints(minWidth: 80, maxWidth: 150),
//             child: Text(
//               title,
//               style: const TextStyle(fontSize: 15),
//             )),
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//           width: MediaQuery.of(context).size.width * .3,
//           height: MediaQuery.of(context).size.height * .2,
//           constraints:
//               const BoxConstraints(minWidth: 200, maxWidth: 290, minHeight: 50, maxHeight: 60),
//           child: Consumer<PrinterProvider>(builder: ((context, printerProvider, child) {
//             return AnimatedCounterDouble(
//               Counter: initialValue > 0 ? initialValue : 1,
//               onKeyPressed: (qty) {
//                 switch (title) {
//                   case "PDF Page Size":
//                     if (printerProvider.customPrinterList.indexWhere((print) =>
//                                 print.name ==
//                                 printerProvider.selectedCustomPrinter!.name.toString()) >=
//                             0 &&
//                         printerProvider.selectedCustomPrinter != null) {
//                       printerProvider.selectedCustomPrinter!.pdfPageSize = double.parse(qty);
//                       printerProvider.customPrinterList[printerProvider.customPrinterList
//                               .indexWhere((print) =>
//                                   print.name ==
//                                   printerProvider.selectedCustomPrinter!.name.toString())] =
//                           printerProvider.SelectedCustomPrinter!;
//                       printerProvider.savePrinters(printerProvider.customPrinterList);
//                     }
//                     break;
//                 }
//               },
//             );
//           })),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//       ],
//     );
//   }
// }
