import 'package:a_pos_flutter/feature/home/expense/model/expense_request_model.dart';
import 'package:a_pos_flutter/feature/home/expense/service/i_expense_service.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';

class ExpenseService implements IExpenseService {
  final String TAG = 'ExpenseService';
  @override
  BaseResponseData<BaseResponseModel> getExpenses() async {
    BaseResponseModel response =
        await DioClient.instance.get(NetworkConstants.expense, queryParameters: {
      'per': 50,
      'page': 0,
    });
    appLogger.info(TAG, response.data.toString());

    return ApiResponseHandler.handleResponse(response);
  }

  @override
  BaseResponseData<BaseResponseModel> postExpense(
      {required ExpenseRequestModel expenseRequestModel}) async {
    BaseResponseModel response =
        await DioClient.instance.post(NetworkConstants.expense, data: expenseRequestModel.toJson());
    appLogger.info(TAG, response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  @override
  BaseResponseData<BaseResponseModel> deleteExpense({required String expenseId}) async {
    BaseResponseModel response =
        await DioClient.instance.delete('${NetworkConstants.expense}/$expenseId');
    appLogger.info(TAG, response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }
}
