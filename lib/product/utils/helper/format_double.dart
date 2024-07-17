class DoubleConvert {
  String formatDouble(double number) {
    if (number % 1 == 0) {
      return number.toInt().toString();
    } else {
      return number.toStringAsFixed(2);
    }
  }

  String formatPriceDouble(double number) {
    if (number % 1 == 0) {
      return number.toStringAsFixed(1);
    } else {
      return number.toStringAsFixed(2);
    }
  }
}
