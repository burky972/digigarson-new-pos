import 'package:a_pos_flutter/feature/back_office/menu/view/menu_view.dart';
import 'package:flutter/material.dart';

mixin MenuViewMixin on State<MenuView> {
  late TabController tabController;
  int? selectedRowIndex = 0;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void onCheckboxChanged(String key, bool value) {
    setState(() {
      if (selectedRowIndex != null) {
        data[selectedRowIndex!][key] = value;
      }
    });
  }

  final List<Map<String, dynamic>> data = [
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
  ];

  final List<Map<String, dynamic>> optionData = [
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
    {
      'groupName': 'Group 1',
      'groupDescription': 'Description 1',
      'dinIn': true,
      'takeOut': false,
      'delivery': false,
      'quickService': true,
      'bar': true,
      'kitchenScreen': false,
    },
  ];
}