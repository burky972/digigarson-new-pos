import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/product/enums/button_action/button_action_enum.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/routes/route_constants.dart';
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

    /// If callback is not null, it will be called after the table is updated
    VoidCallback? callback,
  }) async {
    if (response) {
      await tableCubit
          .getTable()
          .then((_) => showOrderSuccessDialog(action.getSuccessMessage()))
          .then((value) => callback != null ? callback() : null);

      await Future.delayed(const Duration(milliseconds: 1600)).then(
        (_) => routeManager.go(RouteConstants.main),
      );
    } else {
      isShowingError ? showErrorDialog(action.getErrorMessage()) : null;
    }
  }
}
