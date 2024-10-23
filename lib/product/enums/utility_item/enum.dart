// ignore_for_file: constant_identifier_names

enum EUtilityItems {
  SHARED_RESTROOM(1),
  SHARED_RESTROOM_ROUND(2),
  MEN_RESTROOM(3),
  WOMEN_RESTROOM(4),
  MAN_RESTROOM_SQUARE(5),
  WOMEN_RESTROOM_SQUARE(6),
  BATHROOM(7),
  KITCHEN_SIGN(8),
  STAFF_ONLY_SIGN(9),
  PARKING_SIGN(10),
  GREEN_SIGN(11),
  EXIT_SIGN(12),
  FIRE_ALARM_SIGN(13),
  BIG_FIRE_ALARM_SIGN(14),
  FIRE_EXTINGUISHER_SIGN(15),
  WHEEL_CHAIR_SIGN(16),
  ELEVATOR_SIGN(17),
  STAIR_SIGN(18),
  BROWN_POT(19),
  WHITE_POT(20),
  SMALL_BLACK_POT(21),
  SMALL_WHITE_POT(22),
  SMALL_BROWN_POT(23),
  GRAY_CASHIER(24),
  BROWN_CASHIER(25),
  RED_CASHIER(26),
  SMALL_RED_FRIDGE(27),
  SMALL_WHITE_FRIDGE(28),
  RED_FRIDGE(29),
  WHITE_FRIDGE(30),
  BROWN_CUPBOARD(31),
  GRAY_CUPBOARD(32),
  WHITE_CUPBOARD(33),
  OUTDOOR_EXIT_1(34),
  OUTDOOR_EXIT_2(35);

  const EUtilityItems(this.value);
  final int value;

  /// post server utility item type
  static int getUtilityItemType(int value) {
    switch (value) {
      case 27:
        return 1;
      case 28:
        return 2;
      case 29:
        return 3;
      case 30:
        return 4;
      case 31:
        return 5;
      case 32:
        return 6;
      case 33:
        return 7;
      case 34:
        return 8;
      case 35:
        return 9;
      case 36:
        return 10;
      case 37:
        return 11;
      case 38:
        return 12;
      case 39:
        return 13;
      case 40:
        return 14;
      case 41:
        return 15;
      case 42:
        return 16;
      case 43:
        return 17;
      case 44:
        return 18;
      case 45:
        return 19;
      case 46:
        return 20;
      case 47:
        return 21;
      case 48:
        return 22;
      case 49:
        return 23;
      case 50:
        return 24;
      case 51:
        return 25;
      case 52:
        return 26;
      case 53:
        return 27;
      case 54:
        return 28;
      case 55:
        return 29;
      case 56:
        return 30;
      case 57:
        return 31;
      case 58:
        return 32;
      case 59:
        return 33;
      case 60:
        return 34;
      case 61:
        return 35;
      default:
        return -1;
    }
  }

  /// Get Server utility item type
  static int getServerValue(int value) {
    switch (value) {
      case 1:
        return 27;
      case 2:
        return 28;
      case 3:
        return 29;
      case 4:
        return 30;
      case 5:
        return 31;
      case 6:
        return 32;
      case 7:
        return 33;
      case 8:
        return 34;
      case 9:
        return 35;
      case 10:
        return 36;
      case 11:
        return 37;
      case 12:
        return 38;
      case 13:
        return 39;
      case 14:
        return 40;
      case 15:
        return 41;
      case 16:
        return 42;
      case 17:
        return 43;
      case 18:
        return 44;

      case 19:
        return 45;
      case 20:
        return 46;
      case 21:
        return 47;
      case 22:
        return 48;
      case 23:
        return 49;
      case 24:
        return 50;
      case 25:
        return 51;
      case 26:
        return 52;
      case 27:
        return 53;
      case 28:
        return 54;
      case 29:
        return 55;
      case 30:
        return 56;
      case 31:
        return 57;
      case 32:
        return 58;
      case 33:
        return 59;
      case 34:
        return 60;
      case 35:
        return 61;
      default:
        return -1;
    }
  }
}
