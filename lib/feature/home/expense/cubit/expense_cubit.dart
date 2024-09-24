import 'package:a_pos_flutter/feature/home/expense/cubit/expense_state.dart';
import 'package:a_pos_flutter/feature/home/expense/cubit/i_expense_cubit.dart';
import 'package:a_pos_flutter/feature/home/expense/model/expense_request_model.dart';
import 'package:a_pos_flutter/feature/home/expense/model/expense_response_model.dart';
import 'package:a_pos_flutter/feature/home/expense/service/expense_service.dart';
import 'package:a_pos_flutter/feature/home/expense/service/i_expense_service.dart';

class ExpenseCubit extends IExpenseCubit {
  ExpenseCubit() : super(ExpenseState.initial());

  final IExpenseService _service = ExpenseService();

  @override
  void init() {
    getExpenses();
  }

  @override
  Future<bool> getExpenses() async {
    emit(state.copyWith(states: ExpenseStates.loading));
    final response = await _service.getExpenses();
    response.fold(
      (l) => emit(state.copyWith(states: ExpenseStates.error)),
      (r) {
        ExpenseResponseModel model = ExpenseResponseModel.fromJson(r.data);
        emit(state.copyWith(
            expense: model, expenseList: model.expenses, states: ExpenseStates.success));
      },
    );
    return response.isRight();
  }

  @override
  Future<bool> postExpense({required ExpenseRequestModel expenseModel}) async {
    emit(state.copyWith(states: ExpenseStates.loading));
    final response = await _service.postExpense(expenseRequestModel: expenseModel);
    response.fold(
      (l) => emit(state.copyWith(states: ExpenseStates.error)),
      (r) => emit(state.copyWith(states: ExpenseStates.success)),
    );
    return response.isRight();
  }

  @override
  Future<bool> deleteExpense({required String expenseId}) async {
    emit(state.copyWith(states: ExpenseStates.loading));
    final response = await _service.deleteExpense(expenseId: expenseId);
    response.fold(
      (l) => emit(state.copyWith(states: ExpenseStates.error)),
      (r) => emit(state.copyWith(states: ExpenseStates.success)),
    );
    return response.isRight();
  }
}
