class NetworkConstants {
  static const String login = 'pos/login';
  static const String refreshToken = 'pos/refresh-token';
  static const String caseAll = 'pos/cases/all';
  static const String cases = 'pos/cases';
  static const String openCases = 'pos/cases/status/open';
  static const String payCheck = 'pos/checks/';
  static const String myBranch = 'pos/mybranch';

  /// branchs
  static const String product = 'pos/products/';
  static const String category = 'pos/categories/';
  static const String section = 'pos/sections/';
  static const String option = 'pos/options/';
  static const String notes = 'pos/notes';
  static const String serves = 'pos/serves';
  static const String cancelReasons = 'pos/cancel-reasons';
  static const String paymentMethod = 'pos/payment-methods';
  static const String tables = 'pos/tables';
  static const String deleteAllTables = 'pos/tables/delete/all';
  static const String check = 'pos/checks/';
  static const String oldUpdate = 'pos/checks/old/';
  static const String newOrderPos = 'pos/orders/';
  static const String newServicePost = 'pos/table/service/';
  static const String newDiscountPost = 'pos/discount/';
  static const String cateringProductPut = 'pos/catering/';
  static const String moveOrderPut = 'pos/order/move/';
  static const String orders = 'pos/orders/';
  static const String qrOrderPut = 'pos/qr/';
  static const String caseZReport = 'pos/report/z-report';
  static const String utilityItem = 'pos/utility-items';
  static const String quickService = 'pos/quick-services';
  static String editCustomerCount({required String tableId, required String type}) =>
      '/pos/tables/$tableId/customer-count/$type';
  static String postCatering(
          {required String tableId, required String orderNum, required String productId}) =>
      '/pos/orders/$tableId/serve/$orderNum/$productId';
  static String cancelCatering({required String tableId}) => '/pos/orders/$tableId/cancel-serve';
  static String postServiceFee({required String tableId, required String type}) =>
      '/pos/tables/$tableId/service-fee/$type';
  static String delServiceFee({required String tableId, required String serviceId}) =>
      '/pos/tables/$tableId/service-fee/$serviceId';
  static const String cover = '/pos/cover';
  static const String expense = 'pos/expenses';
}
