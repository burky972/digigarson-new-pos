import 'package:a_pos_flutter/gen/assets.gen.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class TableItem {
  final int id;
  final String uniqueId;
  String? name;
  Offset position;
  final Widget assetWidget;

  TableItem({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.position,
    required this.assetWidget,
  });

  // JSON'a dönüştürme
  Map<String, dynamic> toJson() => {
        'id': id,
        'uniqueId': uniqueId,
        'name': name,
        'position': {'dx': position.dx, 'dy': position.dy},
        'assetWidget': assetWidget.toString(),
      };

  // JSON'dan yeniden oluşturma
  factory TableItem.fromJson(Map<String, dynamic> json, Widget assetWidget) {
    return TableItem(
      id: json['id'],
      uniqueId: json['uniqueId'],
      name: json['name'],
      position: Offset(json['position']['dx'], json['position']['dy']),
      assetWidget: assetWidget,
    );
  }

  Widget buildTable() {
    return SizedBox(
      width: 65,
      height: 65,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ColoredBox(color: Colors.red, child: assetWidget),
          Positioned(
              child: Text(name ?? '',
                  style: CustomFontStyle.generalTextStyle
                      .copyWith(color: Colors.white, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}

List<Widget> tableList = [
  Assets.images.tables.a1.image(color: Colors.blue),
  Assets.images.tables.a2.image(color: Colors.blue),
  Assets.images.tables.a3.image(color: Colors.blue),
  Assets.images.tables.a4.image(color: Colors.blue),
  Assets.images.tables.a5.image(color: Colors.blue),
  Assets.images.tables.a6.image(color: Colors.blue),
  Assets.images.tables.a7.image(color: Colors.blue),
  Assets.images.tables.a8.image(color: Colors.blue),
  Assets.images.tables.a9.image(color: Colors.blue),
  Assets.images.tables.a10.image(color: Colors.blue),
  Assets.images.tables.a11.image(color: Colors.blue),
  Assets.images.tables.a12.image(color: Colors.blue),
  Assets.images.tables.a13.image(color: Colors.blue),
  Assets.images.tables.a14.image(color: Colors.blue),
  Assets.images.tables.a15.image(color: Colors.blue),
  Assets.images.tables.a16.image(color: Colors.blue),
  Assets.images.tables.a17.image(color: Colors.blue),
  Assets.images.tables.a18.image(color: Colors.blue),
  Assets.images.tables.a19.image(color: Colors.blue),
  Assets.images.tables.a20.image(color: Colors.blue),
  Assets.images.tables.a21.image(color: Colors.blue),
  Assets.images.tables.a22.image(color: Colors.blue),
  Assets.images.tables.a23.image(color: Colors.blue),
  Assets.images.tables.a24.image(color: Colors.blue),
  Assets.images.tables.a25.image(color: Colors.blue),
  Assets.images.tables.a26.image(color: Colors.blue),
  Assets.images.tables.a27.image(color: Colors.blue),
  Assets.images.utilityItems.a1.image(),
  Assets.images.utilityItems.a2.image(),
  Assets.images.utilityItems.a3.image(),
  Assets.images.utilityItems.a4.image(),
  Assets.images.utilityItems.a5.image(),
  Assets.images.utilityItems.a6.image(),
  Assets.images.utilityItems.a7.image(),
  Assets.images.utilityItems.a8.image(),
  Assets.images.utilityItems.a9.image(),
  Assets.images.utilityItems.a10.image(),
  Assets.images.utilityItems.a11.image(),
  Assets.images.utilityItems.a12.image(),
  Assets.images.utilityItems.a13.image(),
  Assets.images.utilityItems.a14.image(),
  Assets.images.utilityItems.a15.image(),
  Assets.images.utilityItems.a16.image(),
  Assets.images.utilityItems.a17.image(),
  Assets.images.utilityItems.a18.image(),
  Assets.images.utilityItems.a19.image(),
  Assets.images.utilityItems.a20.image(),
  Assets.images.utilityItems.a21.image(),
  Assets.images.utilityItems.a22.image(),
  Assets.images.utilityItems.a23.image(),
  Assets.images.utilityItems.a24.image(),
  Assets.images.utilityItems.a25.image(),
  Assets.images.utilityItems.a26.image(),
  Assets.images.utilityItems.a27.image(),
  Assets.images.utilityItems.a28.image(),
  Assets.images.utilityItems.a29.image(),
  Assets.images.utilityItems.a30.image(),
  Assets.images.utilityItems.a31.image(),
  Assets.images.utilityItems.a32.image(),
  Assets.images.utilityItems.a33.image(),
  Assets.images.utilityItems.a34.image(),
  Assets.images.utilityItems.a35.image(),
];
