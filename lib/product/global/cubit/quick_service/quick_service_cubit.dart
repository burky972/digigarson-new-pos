import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/global/cubit/quick_service/quick_service_state.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:core/core.dart';

class QuickServiceCubit extends BaseCubit<QuickServiceState> {
  QuickServiceCubit() : super(QuickServiceState.initial());

  @override
  void init() {}
  String checkoutInput = '';

  void setInitialTotalPrices(double value) {
    emit(state.copyWith(
      totalRemaining: value,
      totalPriceWithTax: value,
      totalDue: 0,
      checkOutRemainingPrice: value,
    ));
  }

  void setAllProducts(List<OrderProductModel> list) => emit(state.copyWith(allProducts: list));

  void addPayment(Payment payment) {
    List<Payment> newList = List.from(state.paymentsList)..add(payment);
    if (state.paidProducts!.isNotEmpty) {
      emit(state.copyWith(paymentsList: newList, paidProducts: [], totalDue: 0.0));
    } else {
      emit(state.copyWith(paymentsList: newList));
    }
    double paidTotal = 0;
    for (var payment in newList) {
      paidTotal += payment.amount!;
      double newRemainingPrice = state.totalPriceWithTax - paidTotal - state.totalDue;
      emit(state.copyWith(
          totalRemaining: newRemainingPrice,
          totalDue: 0.0,
          checkOutRemainingPrice: newRemainingPrice,
          paidTotal: paidTotal));
    }
  }

  void clearPaymentList() => emit(state.copyWith(paymentsList: []));

  void setWillPaidProduct(List<Product> allProduct) {
    emit(state.copyWith(willPaidProducts: allProduct));
  }

  calculatePriceAfterTax(Product product) {
    return product.price! + (product.price! * (product.tax! / 100)) + calculateItemsPrice(product);
  }

  /// calculate product's selected Items price
  double calculateItemsPrice(Product product) {
    double totalPrice = 0.0;
    if (product.options.isNotEmpty) {
      for (var option in product.options) {
        if (option.selectedItems.isNotEmpty) {
          for (var item in option.selectedItems) {
            totalPrice += item.price ?? 0.0;
          }
        }
      }
    }
    return totalPrice;
  }

  void clearProductList() => emit(state.copyWith(willPaidProducts: [], paidProducts: []));

  void clearAll() {
    emit(state.copyWith(
      willPaidProducts: [],
      paidProducts: [],
      totalDue: 0,
      checkOutRemainingPrice: 0.0,
      totalRemaining: 0.0,
      paymentsList: [],
      checkoutInput: '',
      paidTotal: 0,
      allProducts: [],
      totalPriceWithTax: 0.0,
    ));
  }

  void addProductToPaidProducts(Product product) {
    if (state.checkoutInput.isNotEmpty) {
      clearCheckoutInput();
    }
    List<Product> newPaidProducts = List.from(state.paidProducts ?? []);
    List<Product> newWillPaidProducts = List.from(state.willPaidProducts ?? []);
    newPaidProducts.add(product);
    newWillPaidProducts.remove(product);
    double productPriceWithTax = calculatePriceAfterTax(product);
    double newTotalDue = state.totalDue + productPriceWithTax;
    double newRemainingPrice = state.totalPriceWithTax - newTotalDue;
    if (state.paymentsList.isNotEmpty) {
      newRemainingPrice -= state.paymentsList.fold(0.0, (acc, payment) => acc + payment.amount!);
    }
    double lastTotalDue = state.totalPriceWithTax - state.paidTotal;
    emit(state.copyWith(
      paidProducts: newPaidProducts,
      willPaidProducts: newWillPaidProducts,
      totalDue: newTotalDue > lastTotalDue ? lastTotalDue : newTotalDue,
      checkOutRemainingPrice: newRemainingPrice < 0.0 ? 0.0 : newRemainingPrice,
      totalRemaining: newRemainingPrice < 0.0 ? 0.0 : newRemainingPrice,
      checkoutInput: '',
    ));
  }

  void deleteOrderToPaidProducts(Product product) {
    List<Product> newPaidProducts = List.from(state.paidProducts ?? []);
    List<Product> newWillPaidProducts = List.from(state.willPaidProducts ?? []);

    newPaidProducts.remove(product);
    newWillPaidProducts.add(product);

    double productPriceWithTax = calculatePriceAfterTax(product);

    double newTotalDue = state.totalDue - productPriceWithTax;

    double newRemainingPrice = state.totalPriceWithTax - newTotalDue;

    if (state.paymentsList.isNotEmpty) {
      newRemainingPrice -= state.paymentsList.fold(0.0, (acc, payment) => acc + payment.amount!);
    }
    double lastTotalDue = state.totalPriceWithTax - state.paidTotal;
    double paidListTotal = 0;
    if (newPaidProducts.isNotEmpty) {
      for (var element in newPaidProducts) {
        paidListTotal += calculatePriceAfterTax(element);
      }
    }
    double lastx = newTotalDue < 0.0 ? 0.0 : newTotalDue;
    double lastxy = paidListTotal > 0 && paidListTotal > lastx ? paidListTotal : lastx;
    emit(state.copyWith(
      paidProducts: newPaidProducts,
      willPaidProducts: newWillPaidProducts,
      totalDue: lastxy > lastTotalDue ? lastTotalDue : lastxy,
      checkOutRemainingPrice: newRemainingPrice > lastTotalDue
          ? lastTotalDue - lastxy
          : paidListTotal > lastTotalDue
              ? 0.0
              : newRemainingPrice,
      totalRemaining: newRemainingPrice > lastTotalDue
          ? lastTotalDue - lastxy
          : paidListTotal > lastTotalDue
              ? 0.0
              : newRemainingPrice,
    ));
  }

  setPaidProduct(List<Product> allProduct) => emit(state.copyWith(willPaidProducts: allProduct));

  void setTotalPriceWithTax(double value) => emit(state.copyWith(totalPriceWithTax: value));

  /// set total due
  void setTotalDue(double totalDue) {
    emit(state.copyWith(
      totalDue: totalDue,
      checkOutRemainingPrice: state.checkOutRemainingPrice,
      totalRemaining: state.checkOutRemainingPrice,
    ));
  }

  void setCheckoutInput(String value) {
    final newInput = checkoutInput + value;
    final remainingPrice = state.totalPriceWithTax;

    // Ödenen miktarı hesapla
    double alreadyPaidAmount = 0.0;
    for (var payment in state.paymentsList) {
      alreadyPaidAmount += payment.amount!;
    }

    double actualRemainingPrice = remainingPrice - alreadyPaidAmount;

    if (double.tryParse(newInput) != null) {
      final inputAmount = double.parse(newInput);

      if (inputAmount <= actualRemainingPrice) {
        checkoutInput = newInput;
        double newRemainingPrice = actualRemainingPrice - inputAmount;

        emit(state.copyWith(
          checkoutInput: checkoutInput,
          totalDue: inputAmount,
          checkOutRemainingPrice: newRemainingPrice,
          totalRemaining: newRemainingPrice,
          paidProducts: [],
          willPaidProducts: [...(state.paidProducts ?? []), ...(state.willPaidProducts ?? [])],
        ));
      } else {
        checkoutInput = actualRemainingPrice.toStringAsFixed(2);
        emit(state.copyWith(
          checkoutInput: checkoutInput,
          totalDue: actualRemainingPrice,
          checkOutRemainingPrice: 0,
          totalRemaining: 0,
          paidProducts: [],
          willPaidProducts: [...(state.paidProducts ?? []), ...(state.willPaidProducts ?? [])],
        ));
      }
    }
  }

  /// clear checkout input
  void clearCheckoutInput() {
    double alreadyPaidAmount = 0.0;
    final remainingPrice = state.totalPriceWithTax;
    for (var payment in state.paymentsList) {
      alreadyPaidAmount += payment.amount!;
    }

    double actualRemainingPrice = remainingPrice - alreadyPaidAmount;
    checkoutInput = '';

    emit(state.copyWith(
      checkoutInput: '',
      totalDue: 0,
      checkOutRemainingPrice: actualRemainingPrice,
      totalRemaining: actualRemainingPrice,
      paidProducts: [],
      willPaidProducts: [...(state.paidProducts ?? []), ...(state.willPaidProducts ?? [])],
    ));
  }
}
