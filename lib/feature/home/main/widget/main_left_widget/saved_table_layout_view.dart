import 'dart:convert';
import 'package:a_pos_flutter/feature/back_office/table_layout/model/table_layout_model.dart';
import 'package:core/cache/shared_manager.dart';
import 'package:flutter/material.dart';

class SavedTableLayoutView extends StatefulWidget {
  const SavedTableLayoutView({super.key});

  @override
  State<SavedTableLayoutView> createState() => _SavedTableLayoutViewState();
}

class _SavedTableLayoutViewState extends State<SavedTableLayoutView>
    with SingleTickerProviderStateMixin {
  Map<String, List<TableItem>> tableStates = {};
  final List<String> sections = ['counter', 'section1', 'section2', 'bar'];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAllTableStates();
  }

  Future<void> _loadAllTableStates() async {
    setState(() {
      _isLoading = true;
    });

    for (String key in sections) {
      List<String>? jsonTables = SharedManager.instance.getStringListValue(key);
      if (jsonTables != null) {
        List<TableItem> tables = jsonTables.map((jsonTable) {
          var tableData = json.decode(jsonTable);
          return TableItem.fromJson(tableData, _getWidgetById(tableData['id']));
        }).toList();
        tableStates[key] = tables;
      } else {
        tableStates[key] = [];
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget _getWidgetById(int id) {
    return tableList[id];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Table Layouts'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              children: sections.map((section) {
                return _buildSectionView(section);
              }).toList(),
            ),
    );
  }

  Widget _buildSectionView(String section) {
    List<TableItem> tables = tableStates[section] ?? [];

    return SingleChildScrollView(
      child: Column(
        children: tables.map((table) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: table.buildTable(),
          );
        }).toList(),
      ),
    );
  }
}
