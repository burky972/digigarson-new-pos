import 'dart:convert';
import 'package:a_pos_flutter/feature/home/main/view/widget/main_right_widget.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/view/table_view.dart';
import 'package:a_pos_flutter/feature/home/table/widget/timer_widget.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/cubit/global_cubit.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:flutter/material.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/model/table_layout_model.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:core/cache/shared_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: context.dynamicHeight(1),
            child: Row(
              children: [
                SizedBox(
                  height: context.dynamicHeight(1),
                  width: context.dynamicWidth(.82),
                  child: const MainSavedTableView(),
                ),
                Container(
                    width: context.dynamicWidth(.18),
                    height: context.dynamicHeight(1),
                    color: context.colorScheme.primary,
                    child: const MainRightWidget())
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainSavedTableView extends StatefulWidget {
  const MainSavedTableView({super.key});

  @override
  State<MainSavedTableView> createState() => _MainSavedTableViewState();
}

class _MainSavedTableViewState extends State<MainSavedTableView>
    with TickerProviderStateMixin, MainSavedTableMixin {
  @override
  void initState() {
    super.initState();
    _loadAllTableStates();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: sections.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Menu tabs
          Expanded(
            flex: 1,
            child: _TabsMenuTitles(
              sections: sections,
            ),
          ),
          Expanded(
            flex: 8,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: sections.map((section) {
                      return _buildSectionView(section);
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionView(String section) {
    List<TableItem> tables = tableStates[section] ?? [];

    return Stack(
      children: tables.map((table) {
        return Positioned(
          left: table.position.dx,
          top: table.position.dy,
          child: InkWell(
              // TODO:THINK ABOUT HERE FOR FIRST CLICK SHOW AMOUNT AND DURATION, onDoubleClick OPEN THE SELECTED TABLE!
              //! selected table onTap
              onTap: table.id > 44
                  ? null
                  : () async {
                      context.read<GlobalCubit>().setSelectedTableName(table.name.toString());
                      await context
                          .read<TableCubit>()
                          .setSelectedTable(context.read<TableCubit>().tableModel[table.id])
                          .then(
                        (value) {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => const TableView()));
                          debugPrint(table.name.toString() + table.id.toString());
                        },
                      );
                    },
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: context.colorScheme.primary, borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    table.buildTable(),
                    //TODO: CHECK HERE FOR TOTAL AMOUNT AND LAST OPENED ORDER DATE !!
                    table.id < 44
                        ? Text('24€',
                            style: CustomFontStyle.generalTextStyle
                                .copyWith(color: context.colorScheme.surface))
                        : const SizedBox(),
                    table.id < 44
                        ? BlocSelector<TableCubit, TableState, DateTime?>(
                            selector: (state) {
                              return
                                  //  state.tableModel.isNotEmpty
                                  //TODO: add this later!
                                  // ? state.tableModel.first.lastOrderDate
                                  // :
                                  DateTime(1);
                            },
                            builder: (context, lastOrderDate) {
                              return lastOrderDate != null
                                  ? TimerWidget(
                                      lastOrderTime: lastOrderDate,
                                      color: context.colorScheme.surface,
                                    )
                                  : const SizedBox();
                            },
                          )
                        : const SizedBox()
                  ],
                ),
              )),
        );
      }).toList(),
    );
  }
}

/// Sections tabs title!
class _TabsMenuTitles extends StatelessWidget {
  const _TabsMenuTitles({
    required List<String> sections,
  }) : _sections = sections;

  final List<String> _sections;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: context.dynamicWidth(0.4),
      child: TabBar(
          labelColor: context.colorScheme.tertiary,
          labelStyle: CustomFontStyle.menuTextStyle.copyWith(fontWeight: FontWeight.bold),
          unselectedLabelColor: Colors.black,
          tabs: _sections.map((e) => Tab(text: e.toString())).toList()),
    );
  }
}

mixin MainSavedTableMixin on State<MainSavedTableView> {
  Map<String, List<TableItem>> tableStates = {};
  final List<String> sections = ['COUNTER', 'SECTION1', 'SECTION2', 'BAR'];
  bool _isLoading = false;

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
}
