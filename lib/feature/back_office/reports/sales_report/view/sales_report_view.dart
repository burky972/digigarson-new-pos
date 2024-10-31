import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/product_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/cubit/reports_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/cubit/reports_state.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_order_type_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/model/reports_request_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/widget/select_date_widget.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/utils/helper/date_helper.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/table_cell/table_cell_widget.dart';
import 'package:a_pos_flutter/product/widget/text/from_to_title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// part '../widget/left/bottom_table_widget.dart';
part '../widget/left/top_table_widget.dart';
// part '../widget/right/bottom_tables/order_detail_table_widget.dart';
// part '../widget/right/bottom_tables/order_payment_table_widget.dart';
part '../widget/right/top_tables/waiter_table_widget.dart';
part '../widget/right/top_tables/cashier_table_widget.dart';
part '../widget/right/top_tables/expense_table_widget.dart';
part '../widget/right/top_tables/payment_list_table_widget.dart';
part '../widget/right/top_tables/card_summary_table_widget.dart';
part '../widget/right/top_tables/cancel_reports_table_widget.dart';

class SalesReportView extends StatefulWidget {
  const SalesReportView({super.key});

  @override
  State<SalesReportView> createState() => _SalesReportViewState();
}

class _SalesReportViewState extends State<SalesReportView> with TickerProviderStateMixin {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  late TabController tabController;
  late TabController secondTabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    secondTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    secondTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('General Summary', style: CustomFontStyle.titleBoldTertiaryStyle),
            SizedBox(
              height: context.dynamicHeight(0.75),
              child: Row(
                children: [
                  const _TopTableWidget(),

                  // ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TabBar(
                            controller: tabController,
                            labelColor: context.colorScheme.tertiary,
                            labelStyle:
                                CustomFontStyle.menuTextStyle.copyWith(fontWeight: FontWeight.bold),
                            unselectedLabelColor: Colors.black,
                            tabs: const [
                              // Tab(text: 'Waiter'),
                              // Tab(text: 'Cashier'),
                              Tab(text: 'Waiter'),
                              Tab(text: 'Expense'),
                              Tab(text: 'Cancelled Report'),
                              // Tab(text: 'Payment List'),
                              // Tab(text: 'Card Summary'),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: TabBarView(
                            controller: tabController,
                            children: const [
                              // _CashierTableWidget(),
                              _WaiterTableWidget(),
                              _ExpenseTableWidget(),
                              _CancelReportsTableWidget(),
                              // _CancelReportsTableWidget(),
                              // _PaymentListTableWidget(),
                              // _CardSummaryTableWidget(),
                            ],
                          ),
                        ),

                        /// Right Side Second Bottom Table
                        // Expanded(
                        //   flex: 1,
                        //   child: TabBar(
                        //     controller: secondTabController,
                        //     labelColor: context.colorScheme.tertiary,
                        //     labelStyle:
                        //         CustomFontStyle.menuTextStyle.copyWith(fontWeight: FontWeight.bold),
                        //     unselectedLabelColor: Colors.black,
                        //     tabs: const [
                        //       Tab(text: 'Order Detail'),
                        //       Tab(text: 'Order Payment'),
                        //     ],
                        //   ),
                        // ),
                        // Expanded(
                        //   flex: 15,
                        //   child: TabBarView(
                        //     controller: secondTabController,
                        //     children: const [
                        //       // _OrderDetailTableWidget(),
                        //       // _OrderPaymentTableWidget(),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            ///! Bottom Date and Buttons
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
                  ),
                  const Spacer(),

                  /// Bottom Buttons
                  LightBlueButton(
                    buttonText: LocaleKeys.search.tr(),
                    onTap: () async {
                      if (startDateController.text.isEmpty || endDateController.text.isEmpty) {
                        return;
                      }
                      var startDate = DateHelper.stringToTimestamp(startDateController.text);
                      final endDate = DateHelper.nextDay(endDateController.text);

                      await context.read<ReportsCubit>().getSalesReports(
                            ReportsRequestModel(
                              startDate: startDate.toString(),
                              endDate: endDate.toString(),
                            ),
                          );
                    },
                  ),
                  LightBlueButton(
                    buttonText: LocaleKeys.print.tr(),
                    onTap: () => routeManager.pop(),
                  ),
                  LightBlueButton(
                    buttonText: LocaleKeys.export.tr(),
                    onTap: () => routeManager.pop(),
                  ),
                  LightBlueButton(
                    buttonText: LocaleKeys.send_email.tr(),
                    onTap: () => routeManager.pop(),
                  ),
                  LightBlueButton(
                    buttonText: LocaleKeys.refund.tr(),
                    onTap: () => routeManager.pop(),
                  ),
                  LightBlueButton(
                    buttonText: LocaleKeys.exit.tr(),
                    onTap: () => routeManager.pop(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TableCellTextWidget extends StatelessWidget {
  const _TableCellTextWidget({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const AppPadding.minAll(),
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}

class _MiddleTableCellOrderTextWidget extends StatelessWidget {
  final OrderTypeModel orderTypeModel;
  final String text;

  const _MiddleTableCellOrderTextWidget({
    required this.orderTypeModel,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return MiddleTableCellTextWidget(
      onTap: () {},
      // =>
      // context
      //     .read<ReportsCubit>()
      // .setSelectedProduct(orderTypeModel, product.prices?.first ?? const PriceModel()),
      text: text,
    );
  }
}
