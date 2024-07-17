import 'package:a_pos_flutter/feature/back_office/table_layout/model/table_layout_model.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    super.build(context);
    return DragTarget<TableItem>(
      key: rightPanelKey,
      builder: (context, candidateData, rejectedData) {
        return GestureDetector(
          onTap: () => setState(() {
            widget.onSelectedTableChanged(selectedTable);
            debugPrint(selectedTable?.uniqueId.toString());
          }),
          onDoubleTap: () {
            _setTableName(selectedTable);
          },
          onPanUpdate: (details) {
            debugPrint('selectedTable is onPanUpdate!!');

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
          debugPrint('selectedTable is position');
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
    setState(() {
      if (widget.initialTables != null) {
        setState(() {
          placedTables = widget.initialTables!;
        });
      } else {
        placedTables = [];
      }
    });
  }

  void _setTableName(TableItem? table) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Table Name'),
        content: TextField(
          onChanged: (value) {
            table!.name = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
