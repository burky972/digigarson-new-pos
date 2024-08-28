// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_cubit.dart';

class OrderState extends BaseState {
  const OrderState({
    required this.states,
  });

  final OrderStates states;

  factory OrderState.initial() {
    return const OrderState(
      states: OrderStates.initial,
    );
  }

  @override
  List<Object> get props => [states];

  OrderState copyWith({
    OrderStates? states,
  }) {
    return OrderState(
      states: states ?? this.states,
    );
  }
}

enum OrderStates { initial, loading, success, error }
