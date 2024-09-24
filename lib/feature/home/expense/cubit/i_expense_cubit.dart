import 'package:a_pos_flutter/feature/home/expense/cubit/expense_state.dart';
import 'package:a_pos_flutter/feature/home/expense/model/expense_request_model.dart';
import 'package:core/core.dart';

abstract class IExpenseCubit extends BaseCubit<ExpenseState> {
  IExpenseCubit(super.initialState);
  Future<bool> postExpense({required ExpenseRequestModel expenseModel});
  Future<bool> getExpenses();
  Future<bool> deleteExpense({required String expenseId});
}
