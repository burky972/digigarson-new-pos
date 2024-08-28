import 'dart:convert';

import 'package:a_pos_flutter/feature/home/printer/cubit/i_printer_cubit.dart';
import 'package:a_pos_flutter/feature/home/printer/cubit/printer_state.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/model/print/customer_printer_model.dart';
import 'package:core/cache/shared_manager.dart';
import 'package:printing/printing.dart';

class PrinterCubit extends IPrinterCubit {
  PrinterCubit() : super(PrinterState.initial());

  @override
  void init() {
    loadFindPrinters();
  }

  List<Printer> printerList = [];

  List<CustomPrinterModel> allPrinterList = [];
  CustomPrinterModel? casePrinter;
  List<CustomPrinterModel> customPrinterList = [];
  CustomPrinterModel? selectedCustomPrinter;

  CustomPrinterModel? selectedCustomEditPrinter;

  @override
  Future<List<CustomPrinterModel>> getPrinters() async {
    String? storedList = SharedManager.instance.getStringValue('customPrinterList');

    List<dynamic> jsonList = json.decode(storedList!);
    List<CustomPrinterModel> printerList =
        jsonList.map((item) => CustomPrinterModel.fromJson(item)).toList();
    return printerList;
  }

  @override
  Future<CustomPrinterModel?> getGeneralePrinter() async {
    String? storedList = SharedManager.instance.getStringValue('customPrinterList');
    var jsonList = json.decode(storedList!);
    CustomPrinterModel printerList = CustomPrinterModel.fromJson(jsonList);
    return printerList;
  }

  @override
  Future<void> saveGeneralePrinter(CustomPrinterModel? printers) async {
    if (printers != null) {
      appLogger.info('Printer Cubit:', printers.toJson().toString());
      String jsonString = json.encode(printers.toJson());
      await SharedManager.instance.setStringValue(CacheKeys.customPrinterList, jsonString);
    } else {
      await SharedManager.instance.removeValue(CacheKeys.customPrinterList.name);
    }
  }

  @override
  Future<void> savePrinters(List<CustomPrinterModel> printers) async {
    String jsonString = json.encode(
      printers.map((printer) => printer.toJson()).toList(),
    );
    await SharedManager.instance.setStringValue(CacheKeys.customPrinterList, jsonString);
  }

  @override
  Future<List<Printer>> findPrinters() async {
    return await Printing.listPrinters();
  }

  @override
  Future<void> loadFindPrinters() async {
    allPrinterList = [];
    emit(state.copyWith(allPrinterList: []));
    printerList = await findPrinters();
    CustomPrinterModel? casePrinter_ = await getGeneralePrinter();
    emit(state.copyWith(printerList: printerList, casePrinter: casePrinter_));

    for (var printer in printerList) {
      allPrinterList.add(CustomPrinterModel(
          url: printer.url,
          name: printer.name,
          showName: casePrinter_ != null ? casePrinter_.showName : "",
          fontSize: casePrinter_ != null ? casePrinter_.fontSize : 11,
          noteFontSize: casePrinter_ != null ? casePrinter_.noteFontSize : 11,
          optionFontSize: casePrinter_ != null ? casePrinter_.optionFontSize : 11,
          priceFontSize: casePrinter_ != null ? casePrinter_.priceFontSize : 11,
          productFontSize: casePrinter_ != null ? casePrinter_.productFontSize : 11,
          subFontSize: casePrinter_ != null ? casePrinter_.subFontSize : 11,
          titleFontSize: casePrinter_ != null ? casePrinter_.titleFontSize : 11,
          totalFontSize: casePrinter_ != null ? casePrinter_.totalFontSize : 11,
          pdfPageSize: casePrinter_ != null ? casePrinter_.pdfPageSize : 71.9,
          isGeneralPrinter: false,
          customField: casePrinter_ != null ? casePrinter_.customField : "",
          comment: casePrinter_ != null ? casePrinter_.comment : "",
          categoryIdList: [],
          productIdList: [],
          tableIdList: []));
      if (casePrinter_ != null) {
        if (casePrinter_.url == printer.url) {
          casePrinter = allPrinterList.last;
        }
      }
    }
    customPrinterList = await getPrinters();

    emit(state.copyWith(customPrinterList: customPrinterList, allPrinterList: allPrinterList));
  }

  @override
  customPrinterListAdd(CustomPrinterModel? printer) {
    if (printer != null && !customPrinterList.any((print) => print.name == printer.name)) {
      customPrinterList.add(printer);
      savePrinters(customPrinterList);
      emit(state.copyWith(customPrinterList: customPrinterList));
    }
  }

  @override
  customPrinterListDel(CustomPrinterModel? printer) {
    if (printer != null && customPrinterList.any((print) => print.name == printer.name)) {
      customPrinterList.remove(printer);
      savePrinters(customPrinterList);
      emit(state.copyWith(customPrinterList: customPrinterList));
    }
  }

  @override
  casePrinterSet(CustomPrinterModel? printer) {
    casePrinter = printer;
    saveGeneralePrinter(casePrinter!);
    emit(state.copyWith(casePrinter: printer));
  }

  @override
  Future<void> setSelectedPrinter(CustomPrinterModel? customPrinterList) async {
    selectedCustomPrinter = customPrinterList;
    // notifyListeners();
    emit(state.copyWith(selectedCustomPrinter: customPrinterList));
  }

  @override
  Future<void> setSelectedEditPrinter(CustomPrinterModel? customPrinterList) async {
    selectedCustomEditPrinter = customPrinterList;
    // notifyListeners();
    emit(state.copyWith(selectedCustomEditPrinter: customPrinterList));
  }

  @override
  Future<void> setSelectedPrinterEdit(String id, int type) async {
    switch (type) {
      case 0:
        selectedCustomPrinter!.categoryIdList.any((element) => element == id)
            ? selectedCustomPrinter!.categoryIdList.remove(id)
            : selectedCustomPrinter!.categoryIdList.add(id);
        break;
      case 1:
        selectedCustomPrinter!.productIdList.any((element) => element == id)
            ? selectedCustomPrinter!.productIdList.remove(id)
            : selectedCustomPrinter!.productIdList.add(id);
        break;
      case 2:
        selectedCustomPrinter!.tableIdList.any((element) => element == id)
            ? selectedCustomPrinter!.tableIdList.remove(id)
            : selectedCustomPrinter!.tableIdList.add(id);
        break;
    }
    if (customPrinterList
                .indexWhere((print) => print.name == selectedCustomPrinter!.name.toString()) >=
            0 &&
        selectedCustomPrinter != null) {
      customPrinterList[customPrinterList
              .indexWhere((print) => print.name == selectedCustomPrinter!.name.toString())] =
          selectedCustomPrinter!;
      savePrinters(customPrinterList);
      emit(state.copyWith(customPrinterList: customPrinterList));
    }
    emit(state.copyWith());
  }
}
