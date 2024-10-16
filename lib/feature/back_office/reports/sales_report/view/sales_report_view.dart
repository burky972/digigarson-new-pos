import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/product_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/model/product_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/widget/select_date_widget.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../widget/left/bottom_table_widget.dart';
part '../widget/left/top_table_widget.dart';
part '../widget/right/bottom_tables/order_detail_table_widget.dart';
part '../widget/right/bottom_tables/order_payment_table_widget.dart';
part '../widget/right/top_tables/waiter_table_widget.dart';
part '../widget/right/top_tables/cashier_table_widget.dart';
part '../widget/right/top_tables/expense_table_widget.dart';
part '../widget/right/top_tables/payment_list_table_widget.dart';
part '../widget/right/top_tables/card_summary_table_widget.dart';

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
    tabController = TabController(length: 5, vsync: this);
    secondTabController = TabController(length: 2, vsync: this);
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
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: context.dynamicWidth(0.75),
                child: const Column(
                  children: [
                    _TopTableWidget(),
                    _BottomTableWidget(),
                  ],
                ),
              ),
              SizedBox(
                width: context.dynamicWidth(0.25),
                height: context.dynamicHeight(0.85),
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
                          Tab(text: 'Waiter'),
                          Tab(text: 'Cashier'),
                          Tab(text: 'Expense'),
                          Tab(text: 'Payment List'),
                          Tab(text: 'Card Summary'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: TabBarView(
                        controller: tabController,
                        children: const [
                          _WaiterTableWidget(),
                          _CashierTableWidget(),
                          _ExpenseTableWidget(),
                          _PaymentListTableWidget(),
                          _CardSummaryTableWidget(),
                        ],
                      ),
                    ),

                    /// Right Side Second Bottom Table
                    Expanded(
                      flex: 1,
                      child: TabBar(
                        controller: secondTabController,
                        labelColor: context.colorScheme.tertiary,
                        labelStyle:
                            CustomFontStyle.menuTextStyle.copyWith(fontWeight: FontWeight.bold),
                        unselectedLabelColor: Colors.black,
                        tabs: const [
                          Tab(text: 'Order Detail'),
                          Tab(text: 'Order Payment'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: TabBarView(
                        controller: secondTabController,
                        children: const [
                          _OrderDetailTableWidget(),
                          _OrderPaymentTableWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
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
                            const _DateFromToTitle(title: 'From'),
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
                            const _DateFromToTitle(title: 'To'),
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
                  onTap: () {
                    debugPrint('${startDateController.text} ${endDateController.text}');
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
    );
  }
}

class _MiddleTableCellTextWidget extends StatelessWidget {
  final ProductModel product;
  final String text;

  const _MiddleTableCellTextWidget({
    required this.product,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TableRowInkWell(
      onTap: () => context
          .read<ProductCubit>()
          .setSelectedProduct(product, product.prices?.first ?? const PriceModel()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14),
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}

class _TableCellTitleWidget extends StatelessWidget {
  const _TableCellTitleWidget({
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              overflow: TextOverflow.visible,
            )),
      )),
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

class _DateFromToTitle extends StatelessWidget {
  const _DateFromToTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: context.dynamicWidth(0.05),
        child: Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: Text(
            title,
            style: CustomFontStyle.titlesTextStyle.copyWith(
              color: context.colorScheme.tertiary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
