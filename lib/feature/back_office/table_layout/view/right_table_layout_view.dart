import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/model/table_layout_model.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RightTableLayoutView extends StatefulWidget {
  final String keyName;
  final List<TableItem>? initialTables; // Initial state
  final Function(List<TableItem>) onStateChanged; // Callback to save state
  final Function(TableItem?) onSelectedTableChanged;

  const RightTableLayoutView({
    required this.keyName,
    this.initialTables,
    required this.onStateChanged,
    required this.onSelectedTableChanged,
    super.key,
  });

  @override
  State<RightTableLayoutView> createState() => _RightTableLayoutViewState();
}

class _RightTableLayoutViewState extends State<RightTableLayoutView>
    with AutomaticKeepAliveClientMixin {
  List<TableItem> placedTables = [];
  GlobalKey rightPanelKey = GlobalKey();
  TableItem? selectedTable;
  final TextEditingController _tableNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadPlacedTables();
  }

  @override
  void didUpdateWidget(covariant RightTableLayoutView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.keyName != widget.keyName) {
      loadPlacedTables();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tableNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DragTarget<TableItem>(
      key: rightPanelKey,
      builder: (context, candidateData, rejectedData) {
        return GestureDetector(
          onTap: () => setState(() {
            widget.onSelectedTableChanged(selectedTable);
          }),
          onDoubleTap: () {
            (selectedTable?.id ?? -1) > 44 ? null : _setTableName(selectedTable);
          },
          onPanUpdate: (details) {
            if (selectedTable != null) {
              setState(() {
                selectedTable!.position += details.delta;
                widget.onStateChanged(placedTables); // Update state
              });
            }
          },
          onTapDown: (details) {
            _selectTableAtPosition(details.globalPosition);
          },
          child: Container(
            color: Colors.grey[200],
            child: Stack(
              children: [
                ...placedTables.map((table) => Positioned(
                      left: table.position.dx,
                      top: table.position.dy,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedTable == table ? Colors.blue : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: table.buildTable(),
                      ),
                    )),
              ],
            ),
          ),
        );
      },
      onAcceptWithDetails: (DragTargetDetails<TableItem> details) {
        if (!placedTables.contains(details.data)) {
          _addNewTable(details.data, details.offset);
        }
      },
    );
  }

  void _selectTableAtPosition(Offset globalPosition) {
    final RenderBox renderBox = rightPanelKey.currentContext!.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(globalPosition);

    setState(() {
      selectedTable = null;
      for (var table in placedTables.reversed) {
        if (_isPositionInsideTable(localPosition, table)) {
          selectedTable = table;
          debugPrint('selectedTable is ${selectedTable?.id ?? ''}');
          break;
        }
      }
    });
  }

  bool _isPositionInsideTable(Offset position, TableItem table) {
    return position.dx >= table.position.dx &&
        position.dx <= table.position.dx + 100 && // Table width
        position.dy >= table.position.dy &&
        position.dy <= table.position.dy + 100; // Table height
  }

  void _addNewTable(TableItem table, Offset globalOffset) {
    final RenderBox renderBox = rightPanelKey.currentContext!.findRenderObject() as RenderBox;
    final localOffset = renderBox.globalToLocal(globalOffset);

    // Add new table
    context.read<TableCubit>().addIdToNewAddedTableIds(table.uniqueId);
    setState(() {
      TableItem newTable = TableItem(
        id: table.id,
        uniqueId: table.uniqueId,
        name: table.name,
        position: localOffset,
        assetWidget: table.assetWidget,
      );
      placedTables.add(newTable);
      selectedTable = newTable;

      widget.onStateChanged(placedTables); // Update state
    });
  }

  Future<void> loadPlacedTables() async {
    bool isContains = false;
    for (var element in context.read<SectionCubit>().originalSections) {
      if (element.title == widget.keyName) {
        isContains = true;
      }
    }
    setState(() {
      if (widget.initialTables != null && isContains) {
        setState(() {
          placedTables = widget.initialTables!;
        });
      } else {
        // placedTables = [];
      }
    });
  }

  void _setTableName(TableItem? table) {
    if (table == null) return;
    if (table.name != null && table.name!.isNotEmpty) {
      _tableNameController.text = table.name!;
    } else {
      _tableNameController.clear();
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Table Name'),
        content: TextField(
          controller: _tableNameController,
          onChanged: (value) {
            _tableNameController.text = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => onSetTableNameClicked(table),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  onSetTableNameClicked(TableItem table) {
    if (_tableNameController.text.isEmpty) return;
    if (checkName(_tableNameController.text)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('NAME ALREADY EXIST!!')));
    } else {
      table.name = _tableNameController.text;
      routeManager.pop();
    }
    setState(() {});
  }

  bool checkName(String name) {
    bool isExist = false;
    for (var table in placedTables) {
      if (name == table.name) {
        debugPrint('name already exist!');
        isExist = true;
        break;
      } else {
        debugPrint('new name!');
      }
    }
    return isExist;
  }

  @override
  bool get wantKeepAlive => true;
}
