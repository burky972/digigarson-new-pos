// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:core/core.dart';

import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';

class QuickServiceState extends BaseState {
  const QuickServiceState({
    required this.paidProducts,
    required this.willPaidProducts,
    required this.totalDue,
    required this.checkOutRemainingPrice,
    required this.checkoutInput,
    required this.states,
    required this.totalRemaining,
    required this.totalPriceWithTax,
    required this.allProducts,
    required this.paymentsList,
    required this.paidTotal,
  });

  factory QuickServiceState.initial() {
    return const QuickServiceState(
      states: QuickServiceStates.initial,
      paidProducts: [],
      willPaidProducts: [],
      totalDue: 0.0,
      checkOutRemainingPrice: 0.0,
      checkoutInput: '',
      totalRemaining: 0.0,
      totalPriceWithTax: 0.0,
      allProducts: [],
      paymentsList: [],
      paidTotal: 0.0,
    );
  }

  final QuickServiceStates states;
  final List<Product>? paidProducts;
  final List<Product>? willPaidProducts;
  final double totalDue;
  final double checkOutRemainingPrice;
  final String checkoutInput;
  final double totalRemaining;
  final double totalPriceWithTax;
  final List<OrderProductModel> allProducts;
  final List<Payment> paymentsList;
  final double paidTotal;

  @override
  List<Object?> get props => [
        states,
        paidProducts,
        willPaidProducts,
        totalDue,
        checkOutRemainingPrice,
        checkoutInput,
        totalRemaining,
        totalPriceWithTax,
        allProducts,
        paymentsList,
        paidTotal,
      ];

  QuickServiceState copyWith({
    QuickServiceStates? states,
    List<Product>? paidProducts,
    List<Product>? willPaidProducts,
    double? totalDue,
    double? checkOutRemainingPrice,
    String? checkoutInput,
    double? totalRemaining,
    double? totalPriceWithTax,
    List<OrderProductModel>? allProducts,
    List<Payment>? paymentsList,
    double? paidTotal,
  }) {
    return QuickServiceState(
      states: states ?? this.states,
      paidProducts: paidProducts ?? this.paidProducts,
      willPaidProducts: willPaidProducts ?? this.willPaidProducts,
      totalDue: totalDue ?? this.totalDue,
      checkOutRemainingPrice: checkOutRemainingPrice ?? this.checkOutRemainingPrice,
      checkoutInput: checkoutInput ?? this.checkoutInput,
      totalRemaining: totalRemaining ?? this.totalRemaining,
      totalPriceWithTax: totalPriceWithTax ?? this.totalPriceWithTax,
      allProducts: allProducts ?? this.allProducts,
      paymentsList: paymentsList ?? this.paymentsList,
      paidTotal: paidTotal ?? this.paidTotal,
    );
  }
}

enum QuickServiceStates { initial, loading, error, success }
