// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/cubit/base_cubit.dart';
import 'package:printing/printing.dart';

import 'package:a_pos_flutter/product/global/model/print/customer_printer_model.dart';

class PrinterState extends BaseState {
  const PrinterState({
    required this.states,
    required this.casePrinter,
    required this.customPrinterList,
    required this.allPrinterList,
    required this.printerList,
    required this.selectedCustomPrinter,
    required this.selectedCustomEditPrinter,
  });

  factory PrinterState.initial() {
    return const PrinterState(
      states: PrinterStates.initial,
      casePrinter: null,
      customPrinterList: [],
      allPrinterList: [],
      printerList: [],
      selectedCustomPrinter: null,
      selectedCustomEditPrinter: null,
    );
  }
  final PrinterStates states;
  final CustomPrinterModel? casePrinter;
  final List<CustomPrinterModel> customPrinterList;
  final List<CustomPrinterModel> allPrinterList;
  final List<Printer> printerList;
  final CustomPrinterModel? selectedCustomPrinter;
  final CustomPrinterModel? selectedCustomEditPrinter;

  @override
  List<Object?> get props => [
        states,
        casePrinter,
        customPrinterList,
        allPrinterList,
        printerList,
        selectedCustomPrinter,
        selectedCustomEditPrinter
      ];

  PrinterState copyWith({
    PrinterStates? states,
    CustomPrinterModel? casePrinter,
    List<CustomPrinterModel>? customPrinterList,
    List<CustomPrinterModel>? allPrinterList,
    List<Printer>? printerList,
    CustomPrinterModel? selectedCustomPrinter,
    CustomPrinterModel? selectedCustomEditPrinter,
  }) {
    return PrinterState(
      states: states ?? this.states,
      casePrinter: casePrinter ?? this.casePrinter,
      customPrinterList: customPrinterList ?? this.customPrinterList,
      allPrinterList: allPrinterList ?? this.allPrinterList,
      printerList: printerList ?? this.printerList,
      selectedCustomPrinter: selectedCustomPrinter ?? this.selectedCustomPrinter,
      selectedCustomEditPrinter: selectedCustomEditPrinter ?? this.selectedCustomEditPrinter,
    );
  }
}

enum PrinterStates { initial, loading, completed, error }
