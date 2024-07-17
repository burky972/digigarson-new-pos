import 'package:a_pos_flutter/feature/home/printer/cubit/printer_state.dart';
import 'package:a_pos_flutter/product/global/model/print/customer_printer_model.dart';
import 'package:core/base/cubit/base_cubit.dart';
import 'package:printing/printing.dart';

abstract class IPrinterCubit extends BaseCubit<PrinterState> {
  IPrinterCubit(super.initialState);
  Future<List<CustomPrinterModel>> getPrinters();
  Future<CustomPrinterModel?> getGeneralePrinter();
  Future<void> saveGeneralePrinter(CustomPrinterModel? printers);
  Future<void> savePrinters(List<CustomPrinterModel> printers);
  Future<List<Printer>> findPrinters();
  void loadFindPrinters();
  customPrinterListAdd(CustomPrinterModel? printer);
  customPrinterListDel(CustomPrinterModel? printer);
  casePrinterSet(CustomPrinterModel? printer);
  Future<void> setSelectedPrinter(CustomPrinterModel? customPrinterList);
  Future<void> setSelectedEditPrinter(CustomPrinterModel? customPrinterList);
  Future<void> setSelectedPrinterEdit(String id, int type);
}
