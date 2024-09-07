import 'package:a_pos_flutter/feature/back_office/table_layout/model/table_layout_model.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/enums/button_action/button_action_enum.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/global/service/response_action_service.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:core/cache/shared_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Quick cash dialog (checkout dialog)
class CleanAllTablesDialog {
  void show(BuildContext context, Map<String, List<TableItem>> tableStates) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _buildDialog(context, tableStates);
      },
    );
  }

  Widget _buildDialog(BuildContext context, Map<String, List<TableItem>> tableStates) {
    return BlocConsumer<TableCubit, TableState>(
      listener: (context, state) async {
        if (state.exception != null && state.exception!.message.isNotEmpty) {
          showErrorDialog(context, state.exception!.message);
          await Future.delayed(const Duration(milliseconds: 1505));
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text(
            LocaleKeys.delete.tr(),
            style: CustomFontStyle.popupNotificationTextStyle
                .copyWith(color: context.colorScheme.tertiary, fontSize: 16),
          ),
          content: Container(
              width: MediaQuery.of(context).size.width * .6 + 5,
              height: 250,
              constraints: const BoxConstraints(
                minWidth: 420,
                maxWidth: 520,
                maxHeight: 350,
              ),
              child: Text(
                '${LocaleKeys.isCleaningAllTable.tr()}!',
                style: CustomFontStyle.titlesTextStyle
                    .copyWith(color: context.colorScheme.error, fontSize: 24),
              )),
          actions: [
            LightBlueButton(
              buttonText: LocaleKeys.YES.tr(),
              onTap: () async =>
                  await _handleCleanAllTables(context, state: state, tableStates: tableStates)
                      .then((_) => Navigator.pop(context)),
            ),
            LightBlueButton(
              buttonText: LocaleKeys.NO.tr(),
              onTap: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleCleanAllTables(BuildContext context,
      {required TableState state, required Map<String, List<TableItem>> tableStates}) async {
    TableCubit tableCubit = context.read<TableCubit>();

    bool isDeleted = await context.read<TableCubit>().deleteAllTables();
    if (isDeleted) {
      tableStates.forEach((key, tables) async {
        await SharedManager.instance.removeValue(key);
      });
      showOrderSuccessDialog(context, 'All tables states cleaned!');
    } else {}
    await ResponseActionService.getTableAndNavigate(
        context: context,
        response: isDeleted,
        tableCubit: tableCubit,
        isShowingError: false,
        action: ButtonAction.closeTable);
  }
}
