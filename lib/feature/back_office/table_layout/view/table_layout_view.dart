import 'dart:convert';
import 'dart:math';

import 'package:a_pos_flutter/feature/back_office/sections/cubit/i_section_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_state.dart';
import 'package:a_pos_flutter/feature/back_office/sections/model/section_model.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/model/table_layout_model.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/cubit/utility_item_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/model/utility_item_model.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/model/utility_item_request_model.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_request_model.dart';
import 'package:a_pos_flutter/product/app/app_container_items.dart';
import 'package:a_pos_flutter/product/enums/utility_item/enum.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/dialog/clean_all_tables_dialog.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_border_all_textfield.dart';
import 'package:core/cache/shared_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'right_table_layout_view.dart';
part '../widget/dropdown_widget.dart';

//!TODO:check table delete and utility item delete!!!!!
class TableLayoutView extends StatefulWidget {
  const TableLayoutView({super.key});

  @override
  State<TableLayoutView> createState() => _TableLayoutViewState();
}

class _TableLayoutViewState extends State<TableLayoutView>
    with SingleTickerProviderStateMixin, TableLayoutMixin {
  @override
  void initState() {
    super.initState();
    context.read<SectionCubit>().getSections();
    _loadAllTableStates();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        // Disable button if "Object" tab is selected (index 1)
        isButtonEnabled = _tabController.index != 1;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ISectionCubit>(
      // create: (context) => SectionCubit()..init(),
      create: (context) => AppContainerItems.sectionCubit..init(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Table Layout'),
        ),
        body: GestureDetector(
          onTap: () => setState(() {
            selectedTable = null;
          }),
          child: BlocBuilder<SectionCubit, SectionState>(
            builder: (context, state) {
              TableCubit tableCubit = context.read<TableCubit>();
              UtilityItemCubit utilityItemCubit = context.read<UtilityItemCubit>();
              return Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// left tables list(Section-Object)
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TabBar(
                                  labelColor: context.colorScheme.tertiary,
                                  labelStyle: CustomFontStyle.menuTextStyle
                                      .copyWith(fontWeight: FontWeight.bold),
                                  unselectedLabelColor: Colors.black,
                                  controller: _tabController,
                                  tabs: const [
                                    Tab(
                                      text: 'Section',
                                    ),
                                    Tab(text: 'Object'),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    Padding(
                                      padding: const AppPadding.minAll(),
                                      child: Column(children: [
                                        Container(
                                          height: context.dynamicHeight(0.4),
                                          decoration: BoxDecoration(border: Border.all()),
                                          width: context.width,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const AppPadding.extraMinAll(),
                                                child: Text('Section Name',
                                                    style: CustomFontStyle.titlesTextStyle.copyWith(
                                                        color: context.colorScheme.tertiary)),
                                              ),
                                              SizedBox(height: context.dynamicHeight(0.01)),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: state.allSections == null ||
                                                            state.allSections!.isEmpty
                                                        ? []
                                                        : state.allSections!
                                                            .map(
                                                              (e) => InkWell(
                                                                onTap: () => context
                                                                    .read<SectionCubit>()
                                                                    .setSelectedSection(
                                                                        sectionModel: e),
                                                                child: Container(
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            state.selectedSection ==
                                                                                    e
                                                                                ? context
                                                                                    .colorScheme
                                                                                    .tertiary
                                                                                : null),
                                                                    child: Container(
                                                                      width: context.width,
                                                                      padding: const AppPadding
                                                                          .extraMinAll(),
                                                                      decoration: BoxDecoration(
                                                                          border: Border(
                                                                        top: _selectedSectionBorder(
                                                                            e.title.toString()),
                                                                        bottom:
                                                                            _selectedSectionBorder(
                                                                                e.title.toString()),
                                                                      )),
                                                                      child: Text(
                                                                        e.title.toString(),
                                                                        style: CustomFontStyle
                                                                            .titlesTextStyle
                                                                            .copyWith(
                                                                                color:
                                                                                    state.selectedSection == e
                                                                                        ? Colors
                                                                                            .black
                                                                                        : Colors
                                                                                            .grey),
                                                                      ),
                                                                    )),
                                                              ),
                                                            )
                                                            .toList(),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: context.dynamicHeight(0.01)),
                                        SizedBox(
                                          height: context.dynamicHeight(0.07),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Section Name',
                                                style: CustomFontStyle.titlesTextStyle,
                                              ),
                                              Expanded(
                                                  child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                child: CustomBorderAllTextfield(
                                                  controller: context
                                                      .read<SectionCubit>()
                                                      .sectionController,
                                                  onChanged: (e) {
                                                    context
                                                        .read<SectionCubit>()
                                                        .updateSectionTitle(sectionTitle: e);
                                                  },
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const AppPadding.extraMinAll(),
                                          height: context.dynamicHeight(0.15),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Floor Color',
                                                style: CustomFontStyle.titlesTextStyle,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                height: context.dynamicHeight(0.09),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey)),
                                                // child: selectedColor != null
                                                //     ? ColoredBox(color: selectedColor!)
                                                //     : null,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Checkbox(
                                                value: false,
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                              const Text(
                                                'Is Bar',
                                                style: CustomFontStyle.titlesTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),

                                    /// OBJECT TAB VIEW
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const AppPadding.extraMinAll(),
                                            child: Text(
                                              'Select Sections',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                      color: Colors.blue,
                                                      fontWeight: FontWeight.bold),
                                            ),
                                          ),

                                          /// original sections dropdown button
                                          const _SectionDropDownWidget(),

                                          /// tables - utility item list
                                          Padding(
                                            padding: const AppPadding.extraMinAll(),
                                            child: Text(
                                              'Objects',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                      color: Colors.blue,
                                                      fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Wrap(
                                            children: tableList.asMap().entries.map((entry) {
                                              int index = entry.key;
                                              Widget image = entry.value;
                                              return _buildDraggableTable(index, '', image);
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Right side - Editing area
                        Expanded(
                            flex: 8,
                            child: _isLoading
                                ? const Center(child: CircularProgressIndicator())
                                : RightTableLayoutView(
                                    keyName: state.selectedSection?.title.toString() ?? '',
                                    initialTables: tableStates[state.selectedSection?.id] ?? [],

                                    /// WHEN MOVING SELECTED TABLE
                                    onStateChanged: (tables) {
                                      setState(() {
                                        tableStates[state.selectedSection?.id ?? ''] = tables;
                                        _onSelectedTableChanged(
                                            tableStates[state.selectedSection?.id ?? '']?.last);
                                      });
                                    },
                                    onSelectedTableChanged: _onSelectedTableChanged,
                                  )),
                      ],
                    ),
                  ),

                  ///Section Bottom Buttons Field
                  BlocBuilder<SectionCubit, SectionState>(
                    builder: (context, state) {
                      String? selectedSectionId = state.selectedSection?.id;
                      return Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              LightBlueButton(
                                buttonText: 'Add',
                                onTap: () => isButtonEnabled
                                    ? context.read<SectionCubit>().addNewSection()
                                    : null,
                              ),
                              BlocBuilder<TableCubit, TableState>(
                                builder: (context, state) {
                                  return LightBlueButton(
                                    buttonText: 'Del',
                                    onTap: isButtonEnabled
                                        ? () {
                                            (state.tablesBySectionList?[selectedSectionId]
                                                            ?.length ??
                                                        0) >
                                                    0
                                                ? showOrderErrorDialog('Section has Tables!')
                                                : context.read<SectionCubit>().deleteSection();
                                          }
                                        : null,
                                  );
                                },
                              ),
                              LightBlueButton(
                                  buttonText: 'Save',
                                  onTap: () async => await context
                                          .read<SectionCubit>()
                                          .saveChanges(state.allSections)
                                          .whenComplete(() {
                                        tableCubit.getTable();
                                      })),

                              /// Table Bottom Buttons
                              const Spacer(),
                              InkWell(
                                  onTap: () async {
                                    if (selectedTable != null) {
                                      if (tableCubit.newAddedTableIds
                                          .contains(selectedTable?.uniqueId)) {
                                        _deleteSelectedNewTable(selectedSection, state);
                                      }
                                    }
                                    for (UtilityItemModel element
                                        in utilityItemCubit.sectionMap[state.selectedSection?.id] ??
                                            []) {
                                      if (selectedTable?.position.dx.toInt() ==
                                              element.location?.xCoordinate &&
                                          selectedTable?.position.dy.toInt() ==
                                              element.location?.yCoordinate) {
                                        utilityItemCubit
                                            .addIdToDeletedUtilityItemIds(element.id ?? "");
                                        _deleteSelectedTable(state.selectedSection!.id.toString());
                                      }
                                    }

                                    for (TableModel element
                                        in tableCubit.tablesBySection[state.selectedSection?.id] ??
                                            []) {
                                      if (selectedTable?.name == element.title) {
                                        if (state.selectedSection == null ||
                                            state.selectedSection?.id == null) return;
                                        tableCubit.addIdToDeletedTableIds(
                                          element.id!,
                                        );
                                        _deleteSelectedTable(state.selectedSection!.id.toString());
                                      } else {
                                        // _deleteSelectedNewTable(selectedSection, state);
                                      }
                                    }
                                  },
                                  child: const LightBlueButton(buttonText: 'Delete')),
                              LightBlueButton(
                                buttonText: 'Clean',
                                onTap: () => _cleanAllTableStates(),
                              ),
                              BlocSelector<TableCubit, TableState, bool>(
                                selector: (state) {
                                  return state.isTableSaving ?? false;
                                },
                                builder: (context, isSaving) {
                                  return isSaving
                                      ? const CircularProgressIndicator()
                                      : LightBlueButton(
                                          buttonText: 'Save',
                                          onTap: () async => await _saveAllTableStates(
                                              state.selectedSection!.id.toString(),
                                              state.originalSections),
                                        );
                                },
                              ),
                              LightBlueButton(
                                buttonText: 'Exit',
                                onTap: () {
                                  tableCubit.deletedTableIds.clear();
                                  tableCubit.newAddedTableIds.clear();
                                  utilityItemCubit.deletedUtilityItemIds.clear();
                                  routeManager.pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  BorderSide _selectedSectionBorder(String e) {
    return BorderSide(color: selectedSection == e ? Colors.black : Colors.grey.shade100);
  }

  Widget _buildDraggableTable(int id, String name, Widget assetWidget) {
    String uniqueId = idGenerator();
    return Draggable<TableItem>(
      data: TableItem(
        id: id,
        uniqueId: uniqueId,
        name: name,
        position: Offset.zero,
        assetWidget: assetWidget,
      ),
      feedback: TableItem(
              id: id,
              uniqueId: uniqueId,
              name: name,
              position: Offset.zero,
              assetWidget: assetWidget)
          .buildTable(),
      childWhenDragging: Container(),
      child: TableItem(
        id: id,
        uniqueId: uniqueId,
        name: name,
        position: Offset.zero,
        assetWidget: assetWidget,
      ).buildTable(),
    );
  }
}

mixin TableLayoutMixin on State<TableLayoutView> {
  TableItem? selectedTable;
  GlobalKey rightPanelKey = GlobalKey();

  late TabController _tabController;
  bool isButtonEnabled = true;

  Map<String, List<TableItem>> tableStates = {};
  String? selectedSection;
  bool _isLoading = false;
  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  /// clean all sections tables
  //TODO: when clean func callad ask like are you sure that all tables will be gone!
  Future<void> _cleanAllTableStates() async {
    if (tableStates.isNotEmpty) {
      CleanAllTablesDialog().show(context, tableStates);
    }
  }

  /// load all sections table
  Future<void> _loadAllTableStates() async {
    var sections = context.read<SectionCubit>().state.allSections;
    setState(() {
      _isLoading = true;
    });
    //! Get table from shared manager
    try {
      for (SectionModel key in sections!) {
        List<String>? jsonTables = SharedManager.instance.getStringListValue(key.id ?? '');
        if (jsonTables != null) {
          List<TableItem> tables = jsonTables.map((jsonTable) {
            var tableData = json.decode(jsonTable);
            return TableItem.fromJson(tableData, _getWidgetById(tableData['id']));
          }).toList();
          tableStates[key.id ?? ''] = tables;
        } else {
          tableStates[key.id ?? ''] = [];
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      _isLoading = false;
    }); // Ensure UI is updated with loaded tables
  }

  //! check this delete function
  Future<void> _deleteSelectedTable(String selectedSection) async {
    if (selectedTable == null) return;

    TableItem newSelectedTable = selectedTable!;
    setState(() {
      List<TableItem> tables = tableStates[selectedSection] ?? [];
      tables.removeWhere((table) {
        return table.uniqueId == newSelectedTable.uniqueId;
      });

      tableStates[selectedSection] = tables;
      appLogger.info('Table CUBIT DELETE TABLE', '${tables.length}');
      selectedTable = null;
    });
  }

  //! check this delete function
  void _deleteSelectedNewTable(String? selectedSection, SectionState state) {
    if (selectedTable == null) return;
    TableItem newSelectedTable = selectedTable!;
    List<TableItem>? table = tableStates[state.selectedSection?.id ?? ''];
    setState(() {
      table?.removeWhere((table) => table.uniqueId == newSelectedTable.uniqueId);
      selectedTable = null;
    });
  }

  /// get selected table from draggable view
  Widget _getWidgetById(int id) {
    return tableList[id];
  }

  /// set selected table
  void _onSelectedTableChanged(TableItem? table) {
    setState(() {
      selectedTable = table;
      context.read<TableCubit>().setSelectedTable(TableModel(
          orders: const [],
          paidOrders: const [],
          discount: const [],
          cover: const [],
          payments: const [],
          serviceFee: const [],
          section: selectedSection ?? '',
          title: table?.name ?? '',
          tableType: table?.id ?? -1));
    });
  }

  Future<void> _saveAllTableStates(
      String selectedStateSection, List<SectionModel>? originalSections) async {
    appLogger.info("TAG", "save initialized!");
    TableCubit tableCubit = context.read<TableCubit>();
    UtilityItemCubit utilityItemCubit = context.read<UtilityItemCubit>();
    final existingUtilityItems = utilityItemCubit.state.allUtilityItem;

    tableCubit.changeIsTableSaving(true);

    // Silme işlemlerini yapın
    for (var id in tableCubit.deletedTableIds) {
      bool deleteSuccess = await tableCubit.deleteTable(id.toString());
      if (!deleteSuccess) {
        tableCubit.changeIsTableSaving(false);
        showErrorDialog('Failed to delete table with ID $id.');
        return; // Silme başarısız olursa çıkış yap
      }
    }

    for (var id in utilityItemCubit.deletedUtilityItemIds) {
      bool deleteSuccess = await utilityItemCubit.deleteUtilityItem(itemId: id.toString());
      if (!deleteSuccess) {
        tableCubit.changeIsTableSaving(false);
        if (!mounted) return;
        showErrorDialog('Failed to delete utility item with ID $id.');
        return; // Silme başarısız olursa çıkış yap
      }
    }

    // Durum güncellemesi ve ekleme işlemleri
    tableCubit.updateDeletedSuccess(true);
    // Ensure that deletion was successful across all tables
    // if (tableCubit.state.isDeleteSuccess == false) {
    tableCubit.changeIsTableSaving(false);
    tableCubit.updateDeletedSuccess(true);
    // return;
    // }

    bool hasInvalidTables = false;

    // Iterate through all sections to check and save table states
    for (SectionModel key in originalSections ?? []) {
      appLogger.info('sectionzz originalLength', '${originalSections?.length}!!');

      List<TableItem> tables = tableStates[key.id] ?? [];
      List<String> jsonTables = tables.map((table) => json.encode(table.toJson())).toList();

      // Check for invalid tables within the section
      for (var table in tables) {
        if (table.id < 27 && (table.name == null || table.name!.isEmpty)) {
          hasInvalidTables = true;
          break; // Exit loop early since we found an invalid table
        }
      }

      // Handle invalid tables: Show error message and exit the function
      if (hasInvalidTables) {
        appLogger.warning('error : ', hasInvalidTables.toString());
        tableCubit.changeIsTableSaving(false); // Ensure saving state is false
        if (!mounted) return;
        showErrorDialog('Be sure that all the placed tables have names!');
        return;
      }

      appLogger.warning('SAVED: ', jsonTables.length.toString());
      await SharedManager.instance.setStringListValue(key.id ?? '', jsonTables);
    }

    // Iterate through tables again for further operations (e.g., posting to server)
    for (SectionModel key in originalSections ?? []) {
      List<TableItem> tables = tableStates[key.id] ?? [];

      for (var table in tables) {
        var newId = table.id + 1;
        var xCoordinate = table.position.dx.toInt();
        var yCoordinate = table.position.dy.toInt();

        if (table.id > 26) {
          // handle Post - Put  utility items
          processUtilityItem(key, table, xCoordinate, yCoordinate, existingUtilityItems ?? []);
        } else {
          // Post tables
          try {
            await tableCubit.postTable(
              TableRequestModel(
                title: table.name,
                section: key.id,
                tableType: newId,
                location: LocationModel(xCoordinate: xCoordinate, yCoordinate: yCoordinate),
              ),
            );
          } catch (e) {
            debugPrint('posting table error  : $e');
          }
        }
      }
    }

    // Show a success message once all operations are completed
    showOrderSuccessDialog('All table states saved!');

    // Reset table states and fetch updated data

    tableCubit.reset();
    utilityItemCubit.reset();
    await tableCubit.getTable();
    await utilityItemCubit.getUtilityItem();
    utilityItemCubit.deletedUtilityItemIds.clear();
    tableCubit.changeIsTableSaving(false);
    tableCubit.changeIsTableSaving(false);
  }

  Future<void> processUtilityItem(SectionModel key, TableItem table, int xCoordinate,
      int yCoordinate, List<UtilityItemModel> existingItems) async {
    UtilityItemCubit utilityItemCubit = context.read<UtilityItemCubit>();
    var utilityType = EUtilityItems.getUtilityItemType(table.id);

    var existingItem = existingItems.firstWhere(
      (item) => item.section == key.id && item.type == utilityType,
      orElse: () => UtilityItemModel.empty(),
    );

    if (existingItem != UtilityItemModel.empty()) {
      if (existingItem.location?.xCoordinate != xCoordinate ||
          existingItem.location?.yCoordinate != yCoordinate) {
        await utilityItemCubit.updateUtilityItem(
          itemId: existingItem.id.toString(),
          utilityModel: UtilityItemUpdateRequestModel(
            type: utilityType,
            location: LocationModel(xCoordinate: xCoordinate, yCoordinate: yCoordinate),
          ),
        );
      }
    } else {
      await utilityItemCubit.postUtilityItem(
        utilityModel: UtilityItemRequestModel(
          section: key.id,
          type: utilityType,
          location: LocationModel(xCoordinate: xCoordinate, yCoordinate: yCoordinate),
        ),
      );
    }
  }
}
