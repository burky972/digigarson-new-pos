import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:core/core.dart';

class TableState extends BaseState {
  const TableState({
    required this.states,
    required this.tableModel,
  });

  factory TableState.initial() {
    return const TableState(
      states: TableStates.initial,
      tableModel: [],
    );
  }

  final TableStates states;
  final List<TableModel> tableModel;

  TableState copyWith({
    TableStates? states,
    List<TableModel>? tableModel,
  }) {
    return TableState(
      states: states ?? this.states,
      tableModel: tableModel ?? this.tableModel,
    );
  }

  @override
  List<Object?> get props => [states, tableModel];
}

enum TableStates { initial, loading, completed, error }
