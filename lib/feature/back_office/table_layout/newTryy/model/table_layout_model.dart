// import 'dart:convert';

// import 'package:a_pos_flutter/gen/assets.gen.dart';
// import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
// import 'package:core/cache/shared_manager.dart';
// import 'package:flutter/material.dart';

// class TableLayoutModel {
//   List<TableItem> placedTables = [];

//   Future<void> savePlacedTables() async {
//     List<String> jsonTables = placedTables.map((table) => json.encode(table.toJson())).toList();
//     await SharedManager.instance.setStringListValue(CacheKeys.tableLayout, jsonTables);
//   }

//   Future<void> cleanPlacedTables() async {
//     await SharedManager.instance.removeValue(
//       CacheKeys.tableLayout,
//     );
//   }

//   Future<void> loadPlacedTables() async {
//     List<String> jsonTables =
//         SharedManager.instance.getStringListValue(CacheKeys.tableLayout.name) ?? [];
//     placedTables = jsonTables
//         .map((jsonTable) => TableItem.fromJson(
//             json.decode(jsonTable), _getWidgetById(json.decode(jsonTable)['id'])))
//         .toList();
//   }

//   Widget _getWidgetById(int id) {
//     return tableList[id];
//   }
// }

// class TableItem {
//   final int id;
//   String? name;
//   Offset position;
//   final Widget assetWidget;

//   TableItem({
//     required this.id,
//     required this.name,
//     required this.position,
//     required this.assetWidget,
//   });

//   // JSON'a dönüştürme
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': name,
//         'position': {'dx': position.dx, 'dy': position.dy},
//       };

//   // JSON'dan yeniden oluşturma
//   factory TableItem.fromJson(Map<String, dynamic> json, Widget assetWidget) {
//     return TableItem(
//       id: json['id'],
//       name: json['name'],
//       position: Offset(json['position']['dx'], json['position']['dy']),
//       assetWidget: assetWidget,
//     );
//   }

//   Widget buildTable() {
//     return SizedBox(
//       width: 65,
//       height: 65,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           assetWidget,
//           Positioned(
//               child: Text(name ?? '',
//                   style: CustomFontStyle.generalTextStyle
//                       .copyWith(color: Colors.white, fontWeight: FontWeight.bold))),
//         ],
//       ),
//     );
//   }
// }

// List<Widget> tableList = [
//   Assets.images.tables.a1.image(),
//   Assets.images.tables.a2.image(),
//   Assets.images.tables.a3.image(),
//   Assets.images.tables.a4.image(),
//   Assets.images.tables.a5.image(),
//   Assets.images.tables.a6.image(),
//   Assets.images.tables.a7.image(),
//   Assets.images.tables.a8.image(),
//   Assets.images.tables.a9.image(),
//   Assets.images.tables.a10.image(),
//   Assets.images.tables.a11.image(),
//   Assets.images.tables.a12.image(),
//   Assets.images.tables.a13.image(),
//   Assets.images.tables.a14.image(),
//   Assets.images.tables.a15.image(),
//   Assets.images.tables.a16.image(),
//   Assets.images.tables.a17.image(),
//   Assets.images.tables.a18.image(),
//   Assets.images.tables.a19.image(),
//   Assets.images.tables.a20.image(),
//   Assets.images.tables.a21.image(),
//   Assets.images.tables.a22.image(),
//   Assets.images.tables.a23.image(),
//   Assets.images.tables.a24.image(),
//   Assets.images.tables.a25.image(),
//   Assets.images.tables.a26.image(),
//   Assets.images.tables.a27.image(),
//   Assets.images.tables.a28.image(),
//   Assets.images.tables.a29.image(),
//   Assets.images.tables.a30.image(),
//   Assets.images.tables.a31.image(),
//   Assets.images.tables.a32.image(),
//   Assets.images.tables.a33.image(),
//   Assets.images.tables.a34.image(),
//   Assets.images.tables.a35.image(),
//   Assets.images.tables.a36.image(),
//   Assets.images.tables.a37.image(),
//   Assets.images.tables.a38.image(),
//   Assets.images.tables.a39.image(),
//   Assets.images.tables.a40.image(),
//   Assets.images.tables.a41.image(),
//   Assets.images.tables.a42.image(),
//   Assets.images.tables.a43.image(),
//   Assets.images.tables.a44.image(),
//   Assets.images.tables.a45.image(),
//   Assets.images.tables.a46.image(),
//   Assets.images.tables.a47.image(),
//   Assets.images.tables.a48.image(),
//   Assets.images.tables.a49.image(),
//   Assets.images.tables.a50.image(),
//   Assets.images.tables.a51.image(),
//   Assets.images.tables.a52.image(),
//   Assets.images.tables.a53.image(),
//   Assets.images.tables.a54.image(),
//   Assets.images.tables.a55.image(),
//   Assets.images.tables.a56.image(),
//   Assets.images.tables.a57.image(),
//   Assets.images.tables.a58.image(),
//   Assets.images.tables.a59.image(),
//   Assets.images.tables.a60.image(),
//   Assets.images.tables.a61.image(),
//   Assets.images.tables.a62.image(),
//   Assets.images.tables.a63.image(),
//   Assets.images.tables.a64.image(),
//   Assets.images.tables.a65.image(),
//   Assets.images.tables.a66.image(),
//   Assets.images.tables.a67.image(),
//   Assets.images.tables.a68.image(),
//   Assets.images.tables.a69.image(),
//   Assets.images.tables.a70.image(),
//   Assets.images.tables.a71.image(),
//   Assets.images.tables.a72.image(),
//   Assets.images.tables.a73.image(),
//   Assets.images.tables.a74.image(),
//   Assets.images.tables.a75.image(),
//   Assets.images.tables.a76.image(),
//   Assets.images.tables.a77.image(),
//   Assets.images.tables.a78.image(),
//   Assets.images.tables.a79.image(),
//   Assets.images.tables.a80.image(),
// ];
