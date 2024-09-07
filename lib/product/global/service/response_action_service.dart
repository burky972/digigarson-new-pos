import 'package:a_pos_flutter/feature/home/main/view/main_view.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/product/enums/button_action/button_action_enum.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:flutter/material.dart';

/// ResponseActionService is a utility class for handling responses from the server
/// after a user makes a request. The class contains methods for navigating to the
/// correct page based on the response from the server.
class ResponseActionService {
  const ResponseActionService._();

  static Future<void> getTableAndNavigate({
    required BuildContext context,
    required bool response,
    required TableCubit tableCubit,
    required ButtonAction action,
    bool isShowingError = true,
  }) async {
    if (response) {
      await tableCubit
          .getTable()
          .then((_) => showOrderSuccessDialog(context, action.getSuccessMessage()));

      await Future.delayed(const Duration(milliseconds: 1600)).then(
        (_) => Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => const MainView()), (route) => false),
      );
    } else {
      isShowingError ? showErrorDialog(context, action.getErrorMessage()) : null;
    }
  }
}
