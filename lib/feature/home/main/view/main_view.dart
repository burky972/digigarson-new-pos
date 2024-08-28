import 'package:a_pos_flutter/feature/auth/login/view/login_view.dart';
import 'package:a_pos_flutter/feature/auth/token/cubit/token_cubit.dart';
import 'package:a_pos_flutter/feature/auth/token/cubit/token_state.dart';
import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_state.dart';
import 'package:a_pos_flutter/feature/back_office/sections/model/section_model.dart';
import 'package:a_pos_flutter/feature/home/main/view/widget/main_right_widget.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/view/table_view.dart';
import 'package:a_pos_flutter/feature/home/table/widget/timer_widget.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/cubit/global_cubit.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
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
    return BlocProvider(
      create: (context) => TokenCubit()..startTokenRefresh(),
      child: BlocListener<TokenCubit, TokenState>(
        listener: (context, state) async {
          /// refresh token every 15 minutes
          TokenCubit tokenCubit = context.read<TokenCubit>();
          showErrorDialog(context, 'Something went wrong! Please Log in again.');
          await Future.delayed(const Duration(seconds: 2)).then((_) {
            tokenCubit.close();
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => const LoginView()), (route) => false);
          });
        },
        listenWhen: (_, current) => current.states == TokenStates.error,
        child: Material(
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
    return BlocBuilder<TableCubit, TableState>(
      builder: (context, state) {
        return (state.tablesBySectionList?[sectionId]?.length ?? 0) == 0
            ? const SizedBox()
            : Stack(
                children: state.tablesBySectionList![sectionId]!.map((table) {
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
                        onTap: tableType > 45
                            ? null
                            : () async {
                                context
                                    .read<GlobalCubit>()
                                    .setSelectedTableName(table.title.toString());
                                await context.read<TableCubit>().setSelectedTable(table).then(
                                  (value) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) => const TableView()));
                                    debugPrint(table.title.toString() + table.id.toString());
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
                                  ? Text('24€',
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
                }).toList(),
              );
      },
    );
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
