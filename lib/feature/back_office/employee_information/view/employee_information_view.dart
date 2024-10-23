import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/delivery_guy/view/delivery_guy_view.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/view/employee_view.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/view/category_view.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class EmployeeInformationView extends StatefulWidget {
  const EmployeeInformationView({super.key});

  @override
  State<EmployeeInformationView> createState() => _EmployeeInformationViewState();
}

class _EmployeeInformationViewState extends State<EmployeeInformationView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///  Menu title
            const Text(
              'Employee Information',
              style: CustomFontStyle.titlesTextStyle,
            ),

            /// Menu tabs
            _TabsMenuTitles(tabController: tabController),

            /// EACH TAB'S VIEW
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  EmployeeView(),
                  CategoryView(),
                  DeliveryGuyView(),
                ],
              ),
            ),
          ],
        ),
      ),
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
      width: context.dynamicWidth(0.4),
      child: TabBar(
        controller: _tabController,
        labelColor: context.colorScheme.tertiary,
        labelStyle: CustomFontStyle.menuTextStyle.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelColor: Colors.black,
        tabs: const [
          Tab(text: 'Employee'),
          Tab(text: 'Position'),
          Tab(text: 'Delivery Guy'),
        ],
      ),
    );
  }
}
