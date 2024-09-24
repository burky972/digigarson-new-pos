/// This enum is used for handling server button actions after user clicks on it
library;

enum ButtonAction {
  cancelProduct(0),
  moveProduct(1),
  qrApprove(2),
  qrCancel(3),
  cover(4),
  editCustomerCount(5),
  cashOpen(6),
  changePrice(7),
  closeTable(8),
  checkout(9),
  sales(10),
  newSale(11),
  split(12),
  specialItem(13),
  duplicate(14),
  combine(15),
  printReceipt(16),
  settle(17),
  reSend(18),
  service(19),
  discount(20),
  catering(21),
  cancelCatering(22),
  moveTable(23),
  quickCash(24);

  final int value;
  const ButtonAction(this.value);

  static Map<ButtonAction, String> buttonLabels = {
    ButtonAction.cancelProduct: "Cancel Product",
    ButtonAction.moveProduct: "Move Product",
    ButtonAction.qrApprove: "QR Approve",
    ButtonAction.qrCancel: "QR Cancel",
    ButtonAction.cover: "Cover",
    ButtonAction.editCustomerCount: "Edit Customer Count",
    ButtonAction.changePrice: "Change price",
    ButtonAction.closeTable: "Close Table",
    ButtonAction.checkout: "Checkout",
    ButtonAction.sales: "Sales",
    ButtonAction.newSale: "New Sale",
    ButtonAction.split: "Split",
    ButtonAction.specialItem: "Special Item",
    ButtonAction.duplicate: "Duplicate",
    ButtonAction.combine: "Combine",
    ButtonAction.printReceipt: "Print Receipt",
    ButtonAction.settle: "Settle",
    ButtonAction.reSend: "Re-Send",
    ButtonAction.service: "Service",
    ButtonAction.discount: "Discount",
    ButtonAction.catering: "Catering",
    ButtonAction.cancelCatering: "Cancel Catering",
    ButtonAction.moveTable: "Move Table",
    ButtonAction.quickCash: "Quick Cash",
  };

  /// Returns a success message based on the current ResponseAction.
  String getSuccessMessage() {
    switch (this) {
      case ButtonAction.newSale:
        return 'Order created successfully';
      case ButtonAction.moveTable:
        return 'Table transferred successfully';
      case ButtonAction.cancelProduct:
        return 'Product cancelled successfully';
      case ButtonAction.moveProduct:
        return 'Product moved successfully';

      /// using this for reopen put check request!
      case ButtonAction.changePrice:
        return 'Check has been updated successfully.';
      case ButtonAction.closeTable:
        return 'Table closed successfully';
      case ButtonAction.checkout:
        return 'Product Paid successfully';
      default:
        return 'Action completed successfully';
    }
  }

  /// Returns a error message based on the current ResponseAction.
  String getErrorMessage() {
    switch (this) {
      case ButtonAction.newSale:
        return 'Order could not created successfully';
      case ButtonAction.moveTable:
        return 'Table could not transferred successfully';
      case ButtonAction.cancelProduct:
        return 'Product could not cancelled successfully';
      case ButtonAction.moveProduct:
        return 'Product could not moved successfully';
      case ButtonAction.changePrice:
        return 'Check could not updated successfully!';
      case ButtonAction.closeTable:
        return 'Table could not closed successfully';
      case ButtonAction.checkout:
        return 'Pay Error!';
      default:
        return 'Action completed successfully';
    }
  }
}
