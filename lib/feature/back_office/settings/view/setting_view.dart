import 'package:a_pos_flutter/feature/back_office/settings/sub_view/area_code_local_streets/view/area_code_local_streets_view.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/charges/view/charges_view.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/language/view/language_view.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/order/view/order_view.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/other_devices/view/other_devices_view.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/others/view/others_view.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/payment_devices/view/payment_devices_view.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/printers/view/printers_view.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/receipt/view/receipt_view.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/second_screen/view/second_screen_view.dart';
import 'package:a_pos_flutter/feature/back_office/settings/sub_view/shifts/view/shifts_view.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 11, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: CustomFontStyle.titlesTextStyle,
              ),

              /// Menu tabs
              _TabsMenuTitles(tabController: tabController),

              /// EACH TAB'S VIEW
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    PrintersView(),
                    ShiftsView(),
                    ChargesView(),
                    OrderView(),
                    ReceiptView(),
                    PaymentDeviceView(),
                    OtherDevicesView(),
                    AreaCodeLocalStreetsView(),
                    SecondScreenView(),
                    LanguageView(),
                    OthersView(),
                  ],
                ),
              ),

            ],
          )),
    );
  }
}

class _TabsMenuTitles extends StatelessWidget {
  const _TabsMenuTitles({
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: context.dynamicWidth(1),
      child: TabBar(
        controller: _tabController,
        labelColor: context.colorScheme.tertiary,
        labelStyle: CustomFontStyle.menuTextStyle.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelColor: Colors.black,
        tabs: const [
          Tab(text: 'Printers'),
          Tab(text: 'Shifts'),
          Tab(text: 'Charges'),
          Tab(text: 'Order'),
          Tab(text: 'Receipt'),
          Tab(text: 'Payment Device'),
          Tab(text: 'Other Device'),
          Tab(text: 'Area Code&Local Streets'),
          Tab(text: 'Second Screen'),
          Tab(text: 'Language'),
          Tab(text: 'Others'),
        ],
      ),
    );
  }
}

