import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_state.dart';
import 'package:a_pos_flutter/feature/back_office/sections/model/section_model.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/cubit/utility_item_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/cubit/utility_item_state.dart';
import 'package:a_pos_flutter/feature/home/main/view/widget/main_right_widget.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/widget/timer_widget.dart';
import 'package:a_pos_flutter/product/enums/utility_item/enum.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/cubit/global_cubit.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/model/table_layout_model.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
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
      ),
    );
  }
}

class MainSavedTableView extends StatefulWidget {
  const MainSavedTableView({super.key});

  @override
  State<MainSavedTableView> createState() => _MainSavedTableViewState();
}

class _MainSavedTableViewState extends State<MainSavedTableView> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  Future<void> _asyncMethod() async {
    try {
      await Future.wait([context.read<SectionCubit>().getSections()]);
    } catch (e) {
      appLogger.error('MainView _asyncMethod:,', ' $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionCubit, SectionState>(
      builder: (context, state) {
        List<SectionModel> allSection = state.allSections ?? [];
        return DefaultTabController(
          length: allSection.length,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Menu tabs
              const Expanded(
                flex: 1,
                child: _TabsMenuTitles(),
              ),
              Expanded(
                flex: 8,
                child: TabBarView(
                  children: allSection.map((section) {
                    return _buildSectionView(section.id.toString());
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionView(String sectionId) {
    return Builder(builder: (context) {
      UtilityItemState utilityItemState = context.select((UtilityItemCubit c) => c.state);
      return BlocBuilder<TableCubit, TableState>(
        builder: (context, state) {
          final tables = state.tablesBySectionList?[sectionId] ?? [];
          final utilityItems = utilityItemState.utilityBySectionList?[sectionId] ?? [];
          return Stack(children: [
            if (tables.isNotEmpty)
              ...tables.map((table) {
                var tableType = table.tableType ?? 0;
                var x = table.location?.xCoordinate.toDouble();
                var y = table.location?.yCoordinate.toDouble();
                var listTableType = tableType - 1;
                return Positioned(
                  left: x,
                  top: y,
                  child: InkWell(
                      // TODO:THINK ABOUT HERE FOR FIRST CLICK SHOW AMOUNT AND DURATION, onDoubleClick OPEN THE SELECTED TABLE!
                      //! selected table onTap
                      onTap: () async {
                        context.read<GlobalCubit>().setSelectedTableName(table.title.toString());
                        await context.read<TableCubit>().setSelectedTable(table).then(
                          (value) {
                            routeManager.push(RouteConstants.table);
                          },
                        );
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            table.buildTable(tableList[listTableType]),
                            //TODO: CHECK HERE FOR TOTAL AMOUNT AND LAST OPENED ORDER DATE !!
                            tableType < 46
                                ? Text('\$ ${table.totalPriceAfterTax?.toStringAsFixed(2)}',
                                    style: CustomFontStyle.generalTextStyle
                                        .copyWith(color: context.colorScheme.surface))
                                : const SizedBox(),
                            tableType < 46
                                ? BlocSelector<TableCubit, TableState, DateTime?>(
                                    selector: (state) {
                                      return state.tableModel.isNotEmpty
                                          ? table.lastOrderDate
                                          : DateTime(0);
                                    },
                                    builder: (context, lastOrderDate) {
                                      return TimerWidget(
                                        lastOrderTime: lastOrderDate,
                                        color: context.colorScheme.surface,
                                      );
                                    },
                                  )
                                : const SizedBox()
                          ],
                        ),
                      )),
                );
              }),
            if (utilityItems.isNotEmpty)
              ...utilityItems.map((utilityItem) {
                int utilityType = EUtilityItems.getServerValue(utilityItem.type ?? 0);
                double? x = utilityItem.location?.xCoordinate.toDouble();
                double? y = utilityItem.location?.yCoordinate.toDouble();
                return Positioned(
                  left: x,
                  top: y,
                  child: InkWell(
                      child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        utilityItem.buildUtilityItem(tableList[utilityType]),
                      ],
                    ),
                  )),
                );
              }),
          ]);
        },
      );
    });
  }
}

/// Sections tabs title!
class _TabsMenuTitles extends StatelessWidget {
  const _TabsMenuTitles();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionCubit, SectionState>(
      builder: (context, state) {
        return state.states == SectionStates.loading
            ? const SizedBox()
            : Container(
                alignment: Alignment.centerLeft,
                width: context.dynamicWidth(0.4),
                child: TabBar(
                    labelColor: context.colorScheme.tertiary,
                    labelStyle: CustomFontStyle.menuTextStyle.copyWith(fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.black,
                    tabs: state.allSections?.map((e) => Tab(text: e.title.toString())).toList() ??
                        []),
              );
      },
    );
  }
}
