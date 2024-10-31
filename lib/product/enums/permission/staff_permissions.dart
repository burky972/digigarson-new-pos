// ignore_for_file: constant_identifier_names

enum StaffPermissions {
  TABLE_ACTIONS(1),
  PRODUCT_ACTIONS(2),
  CATEGORY_ACTIONS(3),
  SECTION_ACTIONS(4),
  OPTION_ACTIONS(5),
  CREATE_ORDER(6),
  CLOSE_ORDER(7),
  CANCEL_ORDER(8),
  DISCOUNT_ACTIONS(9),
  GET_PAYMENT(10),
  TAX_CHARGE(11),
  GRATUITY(12),
  DELIVERY_CHARGE(13),
  EXIT_PROGRAM(14),
  BACK_OFFICE(15),
  MOVE_TABLE(16),
  TAKEOUT(17),
  WAITER_TRANSFER(18),
  ACCESS_RESTAURANT(19),
  ACCESS_EMPLOYEE(20),
  ACCESS_MENUS(21),
  ACCESS_MEMBER_CARDS(22),
  ACCESS_MAINTENANCE(23),
  ACCESS_SETTINGS(24),
  ACCESS_POSITION(25),
  ACCESS_SPLIT_SHIFT(26),
  VOUCHER(27),
  COVER_ACTIONS(28),
  SERVE_ACTIONS(29),
  CASE_ACTIONS(30),
  EXPENSE_ACTIONS(31),
  QUICK_SERVICE(32),
  CHECK_ACTIONS(33),
  REASON_ACTIONS(34),
  REPORTS(35);

  final int value;
  const StaffPermissions(this.value);

  /// Get the name of the permission
  String get description {
    switch (this) {
      case StaffPermissions.TABLE_ACTIONS:
        return 'Table Actions';
      case StaffPermissions.PRODUCT_ACTIONS:
        return 'Product Actions';
      case StaffPermissions.CATEGORY_ACTIONS:
        return 'Category Actions';
      case StaffPermissions.SECTION_ACTIONS:
        return 'Section Actions';
      case StaffPermissions.OPTION_ACTIONS:
        return 'Option Actions';
      case StaffPermissions.CREATE_ORDER:
        return 'Create Order';
      case StaffPermissions.CLOSE_ORDER:
        return 'Close Order';
      case StaffPermissions.CANCEL_ORDER:
        return 'Cancel Order';
      case StaffPermissions.DISCOUNT_ACTIONS:
        return 'Discount actions';
      case StaffPermissions.GET_PAYMENT:
        return 'Get Payment';
      case StaffPermissions.TAX_CHARGE:
        return 'Tax Charge - Service fee';
      case StaffPermissions.GRATUITY:
        return 'Gratuity - Tips';
      case StaffPermissions.DELIVERY_CHARGE:
        return 'Delivery Charge';
      case StaffPermissions.EXIT_PROGRAM:
        return 'Exit Program';
      case StaffPermissions.BACK_OFFICE:
        return 'Back Office';
      case StaffPermissions.MOVE_TABLE:
        return 'Move Table';
      case StaffPermissions.TAKEOUT:
        return 'Takeout Orders';
      case StaffPermissions.WAITER_TRANSFER:
        return 'Waiter Transfer';
      case StaffPermissions.ACCESS_RESTAURANT:
        return 'Access Restaurant';
      case StaffPermissions.ACCESS_EMPLOYEE:
        return 'Access Employee';
      case StaffPermissions.ACCESS_MENUS:
        return 'Access Menus';
      case StaffPermissions.ACCESS_MEMBER_CARDS:
        return 'Access Member Cards';
      case StaffPermissions.ACCESS_MAINTENANCE:
        return 'Access Maintenance';
      case StaffPermissions.ACCESS_SETTINGS:
        return 'Access Settings';
      case StaffPermissions.ACCESS_POSITION:
        return 'Access Position';
      case StaffPermissions.ACCESS_SPLIT_SHIFT:
        return 'Access Split Shift';
      case StaffPermissions.VOUCHER:
        return 'Voucher - Courier';
      case StaffPermissions.COVER_ACTIONS:
        return 'Cover Actions';
      case StaffPermissions.SERVE_ACTIONS:
        return 'Serve Actions';
      case StaffPermissions.CASE_ACTIONS:
        return 'Case Actions';
      case StaffPermissions.EXPENSE_ACTIONS:
        return 'Expense Actions';
      case StaffPermissions.QUICK_SERVICE:
        return 'Quick Service';
      case StaffPermissions.CHECK_ACTIONS:
        return 'Check Actions';
      case StaffPermissions.REASON_ACTIONS:
        return 'Reason Actions';
      case StaffPermissions.REPORTS:
        return 'Reports';
      default:
        return 'Unknown permission';
    }
  }
}
