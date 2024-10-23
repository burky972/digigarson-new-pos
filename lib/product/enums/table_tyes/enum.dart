// ignore_for_file: constant_identifier_names

import 'package:a_pos_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum ETableTypes {
  // Tables 1 person(Bar)
  TABLE_ONE_NORTH(1),
  TABLE_ONE_SOUTH(2),
  TABLE_ONE_EAST(3),
  TABLE_ONE_WEST(4),

  // Tables 2 Person
  TABLE_SQUARE_TWO_VERTICAL(5),
  TABLE_SQUARE_TWO_HORIZONTAL(6),
  TABLE_ROUND_TWO_HORIZONTAL(7),
  TABLE_ROUND_TWO_VERTICAL(8),
  TABLE_RECTANGULAR_TWO_VERTICAL(9),
  TABLE_RECTANGULAR_SLIM_TWO_VERTICAL(10),

  // Tables 4 Person
  TABLE_SQUARE_FOUR(11),
  TABLE_RECTANGULAR_FOUR(12),
  TABLE_GEOID_FOUR(13),
  TABLE_GEOID_NORTHEAST_FOUR(14),
  TABLE_RECTANGULAR_NORTHEAST_FOUR(15),
  TABLE_DIAGONAL_SQUARE_FOUR(16),
  TABLE_RECTANGULAR_SLIM_FOUR(17),
  TABLE_ROUND_FOUR(18),

  // Tables 6 Person
  TABLE_RECTANGULAR_SIX_HORIZONTAL(19),
  TABLE_RECTANGULAR_SIX_VERTICAL(20),
  TABLE_ROUND_SIX(21),
  TABLE_GEOID_SIX(22),
  TABLE_GEOID_HORIZONTAL_SIX(23),

  // Tables 8 Person
  TABLE_RECTANGULAR_EIGHT(24),
  TABLE_GEOID_EIGHT(25),
  TABLE_PENTAGON_EIGHT(26),
  TABLE_ROUND_EIGHT(27);

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

    default:
      return const Icon(Icons.help); // default icon.
  }
}
