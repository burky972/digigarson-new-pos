// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';

import 'package:a_pos_flutter/feature/home/expense/model/expense_response_model.dart';

class ExpenseState extends BaseState {
  const ExpenseState({
    required this.states,
    required this.expense,
    required this.expenseList,
  });

  factory ExpenseState.initial() {
    return const ExpenseState(
      states: ExpenseStates.initial,
      expense: null,
      expenseList: [],
    );
  }

  final ExpenseStates states;
  final ExpenseResponseModel? expense;
  final List<ExpenseModel>? expenseList;

  @override
  List<Object?> get props => [states, expense, expenseList];

  ExpenseState copyWith({
    ExpenseStates? states,
    ExpenseResponseModel? expense,
    List<ExpenseModel>? expenseList,
  }) {
    return ExpenseState(
      states: states ?? this.states,
      expense: expense ?? this.expense,
      expenseList: expenseList ?? this.expenseList,
    );
  }
}

enum ExpenseStates { initial, loading, error, success }
