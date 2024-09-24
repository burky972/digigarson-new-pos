import 'package:a_pos_flutter/feature/back_office/launch/view/back_office_launch_view.dart';
import 'package:a_pos_flutter/feature/home/checks/cubit/check_cubit.dart';
import 'package:a_pos_flutter/feature/home/main/widget/main_right_widget/main_right_button.dart';
import 'package:a_pos_flutter/feature/home/checks/view/check_view.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/feature/home/table/view/table_view.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/widget/dialog/expense_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CenterButtonsWidget extends StatelessWidget {
  const CenterButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainRightButton(text: LocaleKeys.takeOut.tr()),
              InkWell(
                onTap: () {
                  context.read<CheckCubit>().setSelectedCheck(null);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckView()));
                },
                child: MainRightButton(text: LocaleKeys.reOpen.tr()),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const MainRightButton(text: 'Pick Up'),
              InkWell(
                  onTap: () => ExpenseDialog().show(context),
                  child: const MainRightButton(text: 'Expense')),
            ],
          ),
          //!TODO: create custom widget and delete all same decoration codes!
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {},
                child: const MainRightButton(text: 'Delivery'),
              ),
              const MainRightButton(text: 'Open Drawer')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    context.read<TableCubit>().setIsQuickService(true);
                    context.read<TableCubit>().setSelectedTable(TableModel.empty());
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TableView()));
                  },
                  child: MainRightButton(text: LocaleKeys.quickService.tr())),
              MainRightButton(text: LocaleKeys.reservation.tr()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: const MainRightButton(text: 'Bar'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const BackOfficeLaunchView()));
                },
                child: const MainRightButton(text: 'Back Office'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const MainRightButton(text: 'Waiter Report'),
              Container(
                width: context.dynamicWidth(.08),
                constraints: const BoxConstraints(
                  minHeight: 70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
