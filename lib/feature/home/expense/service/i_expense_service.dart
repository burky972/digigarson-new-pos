import 'package:a_pos_flutter/feature/home/expense/model/expense_request_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class IExpenseService {
  BaseResponseData<BaseResponseModel> getExpenses();
  BaseResponseData<BaseResponseModel> postExpense(
      {required ExpenseRequestModel expenseRequestModel});
  BaseResponseData<BaseResponseModel> deleteExpense({required String expenseId});
}
