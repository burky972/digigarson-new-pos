// ignore_for_file: constant_identifier_names

import 'package:a_pos_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum ETableTypes {
  TABLE_FOR_ONE_UP(1),
  TABLE_FOR_ONE_DOWN(2),
  TABLE_FOR_ONE_RIGHT(3),
  TABLE_FOR_ONE_LEFT(4),
  SQUARE_TABLE_FOR_ONE_UP(5),
  SQUARE_TABLE_FOR_ONE_DOWN(6),
  SQUARE_TABLE_FOR_ONE_RIGHT(7),
  SQUARE_TABLE_FOR_ONE_LEFT(8),
  RECTANGULAR_TABLE_FOR_ONE_UP(9),
  RECTANGULAR_TABLE_FOR_ONE_DOWN(10),
  ROUND_TABLE_FOR_ONE_UP(11),
  ROUND_FOR_ONE_DOWN(12),
  ROUND_FOR_ONE_RIGHT(13),
  ROUND_FOR_ONE_LEFT(14),
  HORIZONTAL_RECTANGULAR_TABLE_FOR_TWO(15),
  VERTICAL_RECTANGULAR_TABLE_FOR_TWO(16),
  HORIZONTAL_SQUARE_TABLE_FOR_TWO(17),
  VERTICAL_SQUARE_TABLE_FOR_TWO(18),
  HORIZONTAL_ROUND_TABLE_FOR_TWO(19),
  VERTICAL_ROUND_TABLE_FOR_TWO(20),
  ROUND_TABLE_FOR_THREE_UP(21),
  ROUND_TABLE_FOR_THREE_DOWN(22),
  ROUND_TABLE_FOR_THREE_RIGHT(23),
  ROUND_TABLE_FOR_THREE_LEFT(24),
  SQUARE_TABLE_FOR_THREE_UP(25),
  SQUARE_TABLE_FOR_THREE_DOWN(26),
  SQUARE_TABLE_FOR_THREE_RIGHT(27),
  SQUARE_TABLE_FOR_THREE_LEFT(28),
  RECTANGULAR_TABLE_FOR_THREE_UP(29),
  RECTANGULAR_TABLE_FOR_THREE_DOWN(30),
  RECTANGULAR_TABLE_FOR_THREE_RIGHT(31),
  RECTANGULAR_TABLE_FOR_THREE_LEFT(32),
  RECTANGULAR_TABLE_FOR_FOUR(33),
  SQUARE_TABLE_FOR_FOUR(34),
  SQUARE_TABLE_FOR_FOUR_HORIZONTAL(35),
  DIAGONAL_SQUARE_TABLE_FOR_FOUR(36),
  DIAGONAL_SQUARE_TABLE_FOR_FOUR_DIAGONAL(37),
  ROUND_TABLE_FOR_SIX(38),
  ROUND_TABLE_FOR_SIX_HORIZONTAL(39),
  GEOIT_TABLE_FOR_SIX(40),
  GEOIT_TABLE_FOR_SIX_HORIZONTAL(41),
  RECTANGULAR_TABLE_FOR_SIX_HORIZONTAL(42),
  RECTANGULAR_TABLE_FOR_SIX(43),
  ROUND_TABLE_FOR_EIGHT(44),
  RECTANGULAR_TABLE_FOR_EIGHT(45);

  const ETableTypes(this.value);
  final int value;
  static ETableTypes fromValue(int value) {
    return ETableTypes.values.firstWhere(
      (e) => e.value == value,
    );
  }
}

Widget getTableType(int type) {
  switch (type) {
    case 1:
      return Assets.images.tables.a1.image();
    case 2:
      return Assets.images.tables.a2.image();
    case 3:
      return Assets.images.tables.a3.image();
    case 4:
      return Assets.images.tables.a4.image();
    case 5:
      return Assets.images.tables.a5.image();
    case 6:
      return Assets.images.tables.a6.image();
    case 7:
      return Assets.images.tables.a7.image();
    case 8:
      return Assets.images.tables.a8.image();
    case 9:
      return Assets.images.tables.a9.image();
    case 10:
      return Assets.images.tables.a10.image();
    case 11:
      return Assets.images.tables.a11.image();
    case 12:
      return Assets.images.tables.a12.image();
    case 13:
      return Assets.images.tables.a13.image();
    case 14:
      return Assets.images.tables.a14.image();
    case 15:
      return Assets.images.tables.a15.image();
    case 16:
      return Assets.images.tables.a16.image();
    case 17:
      return Assets.images.tables.a17.image();
    case 18:
      return Assets.images.tables.a18.image();
    case 19:
      return Assets.images.tables.a19.image();
    case 20:
      return Assets.images.tables.a20.image();
    case 21:
      return Assets.images.tables.a21.image();
    case 22:
      return Assets.images.tables.a22.image();
    case 23:
      return Assets.images.tables.a23.image();
    case 24:
      return Assets.images.tables.a24.image();
    case 25:
      return Assets.images.tables.a25.image();
    case 26:
      return Assets.images.tables.a26.image();
    case 27:
      return Assets.images.tables.a27.image();
    case 28:
      return Assets.images.tables.a28.image();
    case 29:
      return Assets.images.tables.a29.image();
    case 30:
      return Assets.images.tables.a30.image();
    case 31:
      return Assets.images.tables.a31.image();
    case 32:
      return Assets.images.tables.a32.image();
    case 33:
      return Assets.images.tables.a33.image();
    case 34:
      return Assets.images.tables.a34.image();
    case 35:
      return Assets.images.tables.a35.image();
    case 36:
      return Assets.images.tables.a36.image();
    case 37:
      return Assets.images.tables.a37.image();
    case 38:
      return Assets.images.tables.a38.image();
    case 39:
      return Assets.images.tables.a39.image();
    case 40:
      return Assets.images.tables.a40.image();
    case 41:
      return Assets.images.tables.a41.image();
    case 42:
      return Assets.images.tables.a42.image();
    case 43:
      return Assets.images.tables.a43.image();
    case 44:
      return Assets.images.tables.a44.image();
    case 45:
      return Assets.images.tables.a45.image();

    default:
      return const Icon(Icons.help); // default icon.
  }
}
