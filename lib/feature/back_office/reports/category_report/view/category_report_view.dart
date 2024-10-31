import 'package:a_pos_flutter/feature/back_office/reports/sales_report/cubit/reports_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/cubit/reports_state.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_category_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_request_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/widget/select_date_widget.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/utils/helper/date_helper.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/text/from_to_title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part '../widget/category_table_widget.dart';

class CategoryReportView extends StatelessWidget {
  const CategoryReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController endDateController = TextEditingController();
    return Scaffold(
        body: SizedBox(
      width: context.dynamicWidth(0.9),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Category Report'),
          SizedBox(
            height: context.dynamicHeight(0.15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const FromToTitle(title: 'From'),
                            Expanded(
                              child: SelectDateWidget(
                                startDateController: startDateController,
                                endDateController: endDateController,
                                isStartDay: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Row(
                          children: [
                            const FromToTitle(title: 'To'),
                            Expanded(
                              child: SelectDateWidget(
                                startDateController: startDateController,
                                endDateController: endDateController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const _CategoryTableWidget(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LightBlueButton(
                buttonText: LocaleKeys.search.tr(),
                onTap: () async {
                  if (startDateController.text.isEmpty || endDateController.text.isEmpty) {
                    return;
                  }
                  final startDate = DateHelper.stringToTimestamp(startDateController.text);
                  final endDate = DateHelper.stringToTimestamp(endDateController.text);
                  await context.read<ReportsCubit>().getCategoryReports(ReportsRequestModel(
                      startDate: startDate.toString(), endDate: endDate.toString()));
                },
              ),
              LightBlueButton(
                buttonText: 'Print by Quantity',
                onTap: () => routeManager.pop(),
              ),
              LightBlueButton(
                buttonText: 'Print by Amount',
                onTap: () => routeManager.pop(),
              ),
              LightBlueButton(
                buttonText: LocaleKeys.export.tr(),
                onTap: () {
                  context.read<ReportsCubit>().printSelectedProducts();
                },
              ),
              LightBlueButton(
                buttonText: LocaleKeys.exit.tr(),
                onTap: () => routeManager.pop(),
              ),
            ],
          )
        ]),
      ),
    ));
  }
}
