import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/view/category_view.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/view/main_category_view.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/view/product_view.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/view/option_view.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option_group/view/option_group_view.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
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
              'Menu Settings',
              style: CustomFontStyle.titlesTextStyle,
            ),

            /// Menu tabs
            _TabsMenuTitles(tabController: tabController),

            /// EACH TAB'S VIEW
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  MainCategoryView(),
                  CategoryView(),
                  ProductView(),
                  OptionGroupsView(),
                  OptionsView(),
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
          Tab(text: 'Main Categories'),
          Tab(text: 'Menu Groups'),
          Tab(text: 'Menu Items'),
          Tab(text: 'Option Groups'),
          Tab(text: 'Options'),
        ],
      ),
    );
  }
}
