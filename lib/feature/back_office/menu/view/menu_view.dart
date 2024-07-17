import 'package:a_pos_flutter/feature/back_office/menu/mixin/menu_mixin.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/menu_group/view/menu_group_view.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/menu_items/view/menu_items_view.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/view/menu_option_view.dart';
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

class _MenuViewState extends State<MenuView> with SingleTickerProviderStateMixin, MenuViewMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
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
                children: [
                  MenuGroupView(
                    data: data,
                    selectedRowIndex: selectedRowIndex,
                    onRowTap: (index) {
                      setState(() {
                        if (selectedRowIndex == index) {
                          return;
                        } else {
                          selectedRowIndex = index;
                        }
                      });
                    },
                    onCheckboxChanged: onCheckboxChanged,
                  ),
                  const MenuItemsView(),
                  const OptionGroupsView(),
                  const MenuOptionsView(),
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
          Tab(text: 'Menu Groups'),
          Tab(text: 'Menu Items'),
          Tab(text: 'Option Groups'),
          Tab(text: 'Options'),
        ],
      ),
    );
  }
}
