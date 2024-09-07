import 'dart:io';
import 'dart:typed_data';

import 'package:a_pos_flutter/feature/home/checks/model/re_open_model.dart';

import 'package:a_pos_flutter/product/constant/app/app_constant.dart';
import 'package:a_pos_flutter/product/constant/string/incoive.dart';
import 'package:a_pos_flutter/product/global/model/print/customer_printer_model.dart';
import 'package:a_pos_flutter/product/global/model/print/print_invoice_model.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/utils/helper/format_double.dart';
import 'package:a_pos_flutter/product/utils/helper/formatter.dart';
import 'package:a_pos_flutter/product/utils/helper/general.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:logger/logger.dart';
import 'package:pdf/pdf.dart';

class InvoiceWidget {
  final List<ReOpenModel> headTitle = [
    const ReOpenModel(text: 'Item', width: 0.16),
    const ReOpenModel(text: 'Qty', width: 0.05),
    const ReOpenModel(text: 'Price', width: 0.06)
  ];

  static pw.Widget buildItems(
      {required double screenWidth,
      required String title,
      required String value,
      int reducedWidth = 0,
      double? fontSize,
      bool isBold = false,
      bool centerPos = false}) {
    final Uint8List fontData = File(AppConstants.font_URL).readAsBytesSync();
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    const divider = InvoiceConstant.invoiceItemDivider;
    const multiplier = InvoiceConstant.invoiceItemMultiplier;

    int rowCount = (value.length / divider).ceil();
    num totalRow = rowCount > 0 ? rowCount : 1;
    totalRow *= multiplier;
    Logger().i(
        'value length: $value / row count: $screenWidth / height size: $reducedWidth / width size: ${screenWidth - reducedWidth}');

    return pw.Container(
      height: double.parse(totalRow.toString()),
      width: screenWidth - reducedWidth,
      decoration: const pw.BoxDecoration(),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment:
            centerPos ? pw.MainAxisAlignment.center : pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title,
              style: pw.TextStyle(
                  font: ttf, fontSize: fontSize, fontWeight: isBold ? pw.FontWeight.bold : null)),
          pw.SizedBox(width: centerPos ? 0 : (title.length >= 14 ? 20 : 50)),
          centerPos
              ? pw.Text(value,
                  textAlign: pw.TextAlign.end,
                  style: pw.TextStyle(
                      font: ttf,
                      fontSize: fontSize,
                      fontWeight: isBold ? pw.FontWeight.bold : null))
              : pw.Expanded(
                  child: pw.Text(value,
                      textAlign: pw.TextAlign.end,
                      style: pw.TextStyle(
                          font: ttf,
                          fontSize: fontSize,
                          fontWeight: isBold ? pw.FontWeight.bold : null)))
        ],
      ),
    );
  }

  static pw.Widget buildTitleItem(
      {required double screenWidth, required String title, double? fontSize, bool isBold = false}) {
    final Uint8List fontData = File(AppConstants.font_URL).readAsBytesSync();
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());

    return pw.Container(
      width: screenWidth,
      decoration: const pw.BoxDecoration(),
      child: pw.Center(
        child: pw.Text(title,
            style: pw.TextStyle(
                font: ttf, fontSize: fontSize, fontWeight: isBold ? pw.FontWeight.bold : null),
            textAlign: pw.TextAlign.center),
      ),
    );
  }

  static pw.Widget buildItemsSpecial(
      {required double screenWidth,
      required String title,
      required String value,
      int reducedWidth = 0,
      double? fontSize,
      bool isBold = false}) {
    const divider = InvoiceConstant.invoiceItemDivider;
    const multiplier = InvoiceConstant.invoiceItemMultiplier;
    // final Uint8List fontData = File(AppConstants.font_URL).readAsBytesSync();
    // final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    int rowCount = (value.length / divider).ceil();
    num totalRow = rowCount > 0 ? rowCount : 1;
    totalRow *= multiplier;
    Logger().i('value length: ${value.length} / row count: $rowCount / height size: $totalRow');

    return pw.Container(
      height: double.parse(totalRow.toString()),
      width: screenWidth - reducedWidth,
      decoration: const pw.BoxDecoration(),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title,
              style:
                  pw.TextStyle(fontSize: fontSize, fontWeight: isBold ? pw.FontWeight.bold : null)),
          pw.Expanded(
              child: pw.Text(value,
                  textAlign: pw.TextAlign.end,
                  style: pw.TextStyle(
                      fontSize: fontSize, fontWeight: isBold ? pw.FontWeight.bold : null)))
        ],
      ),
    );
  }

  static pw.Widget buildDottedLineWithCurrentDateTime(
      {required double screenWidth, int reducedWidth = 0, double? fontSize}) {
    final currentDate = Formatter.formatDate(dateString: DateTime.now().toString());

    return pw.SizedBox(
      width: screenWidth - reducedWidth,
      // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Stack(
            children: [
              pw.SizedBox(
                  // margin: const EdgeInsets.only(top: 20),
                  // width: screenWidth - reducedWidth,
                  height: 28,
                  // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        '<',
                        style: const pw.TextStyle(fontSize: 18),
                      ),
                      ...List.generate(screenWidth ~/ 10, (index) {
                        return pw.Expanded(
                            child: pw.Container(
                          height: 2,
                        ));
                      }),
                      pw.Text(
                        '>',
                        style: const pw.TextStyle(fontSize: 18),
                      ),
                    ],
                  )),
              pw.Center(
                child: pw.Container(
                    alignment: pw.Alignment.center,
                    height: 28,
                    width: 220,
                    // width: currentDate.length * 8.5,
                    child: pw.Text(
                      currentDate,
                      style: const pw.TextStyle(fontSize: 18),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildFooterLine(
      {required double leftPos, double? width, required String text, enablePadding = false}) {
    return Positioned(
      left: leftPos,
      child: Container(
          color: Colors.white,
          padding: enablePadding ? const EdgeInsets.only(left: 10, right: 10) : null,
          width: width,
          // height: 14,
          child: Center(
            child: Text(text, style: const TextStyle(fontSize: 18)),
          )),
    );
  }

  static pw.Widget buildDottedLine(
      {required double screenWidth, int reducedWidth = 0, double topMargin = 1}) {
    return pw.Container(
        margin: pw.EdgeInsets.only(bottom: 1, top: topMargin, left: 0),
        width: screenWidth - reducedWidth,
        child: pw.Row(
          children: [
            ...List.generate(screenWidth ~/ 10, (index) {
              return pw.Expanded(
                  child: pw.Container(
                height: 2,
              ));
            }),
          ],
        ));
  }

  static pw.Widget buildPadding({required double screenWidth, required index_}) {
    return pw.Container(
        width: screenWidth,
        child: pw.Row(
          children: [
            ...List.generate(index_, (index) {
              Logger().i(index);
              return pw.Expanded(
                  child: pw.Container(
                height: 2,
              ));
            }),
          ],
        ));
  }

  static pw.Widget buildDottedLineSpecial(
      {required double screenWidth, int reducedWidth = 0, double topMargin = 0}) {
    return pw.Container(
        margin: pw.EdgeInsets.only(bottom: 3, top: topMargin, left: 0),
        width: screenWidth - reducedWidth,
        child: pw.Row(
          children: [
            ...List.generate(screenWidth ~/ 10, (index) {
              return pw.Expanded(
                  child: pw.Container(
                height: 2,
              ));
            }),
          ],
        ));
  }

  static Widget buildHorizontalLine({required double screenWidth, int reducedWidth = 0}) {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      width: screenWidth - reducedWidth,
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 2,
            decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
          )),
        ],
      ),
    );
  }

  print(CustomPrinterModel? printer, PrinterInvoiceModel invoice) async {
    if (printer == null) return;
    final Uint8List fontData = File(AppConstants.font_URL).readAsBytesSync();
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final doc = pw.Document();
    double screenWidth = (printer.pdfPageSize) * PdfPageFormat.mm;
    const height = 300.0 * PdfPageFormat.mm;
    var pageFormat = PdfPageFormat(screenWidth, height);
    int reducedSize = 0;
    doc.addPage(
      pw.MultiPage(
        pageFormat: pageFormat,
        build: (pw.Context context) {
          return [
            pw.Padding(
              padding: const pw.EdgeInsetsDirectional.only(start: 12),
              child: pw.Column(
                children: [
                  /// ********************************* invoice header ******************************** ///

                  InvoiceWidget.buildTitleItem(
                      title: invoice.headerData.header1,
                      isBold: true,
                      fontSize: printer.titleFontSize,
                      screenWidth: screenWidth),

                  InvoiceWidget.buildDottedLineSpecial(
                      reducedWidth: reducedSize, screenWidth: screenWidth),

                  /// ********************************* invoice items ******************************** ///
                  if (invoice.transactionData.items.isNotEmpty) ...[
                    InvoiceWidget.buildItems(
                        title: 'Date',
                        value: invoice.transactionData.date,
                        reducedWidth: reducedSize,
                        fontSize: printer.fontSize,
                        screenWidth: screenWidth),
                    InvoiceWidget.buildItems(
                        title: 'Transaction ID',
                        value: invoice.transactionData.orderNo.toString(),
                        reducedWidth: reducedSize,
                        fontSize: printer.fontSize,
                        screenWidth: screenWidth),
                    InvoiceWidget.buildItemsSpecial(
                        title: 'Cashier Name',
                        value: invoice.transactionData.cashierName,
                        reducedWidth: reducedSize,
                        fontSize: printer.fontSize,
                        screenWidth: screenWidth),
                    InvoiceWidget.buildItems(
                        title: 'Table',
                        value: invoice.transactionData.table,
                        reducedWidth: reducedSize,
                        fontSize: printer.fontSize,
                        screenWidth: screenWidth),
                    InvoiceWidget.buildDottedLine(
                        reducedWidth: reducedSize, screenWidth: screenWidth),

                    /// *************************** part nama item, quantity, price, tax ****************************** ///

                    pw.Table(
                      defaultColumnWidth: const pw.IntrinsicColumnWidth(),
                      children: [
                        pw.TableRow(children: [
                          pw.Container(
                              constraints: const pw.BoxConstraints(
                                minWidth: 30,
                              ),
                              child: pw.Text('Qty',
                                  style: pw.TextStyle(
                                      font: ttf, fontWeight: pw.FontWeight.bold, fontSize: 10.0),
                                  textAlign: pw.TextAlign.center)),
                          pw.Padding(
                              padding: const pw.EdgeInsetsDirectional.only(start: 2),
                              child: pw.Text('Product',
                                  style: pw.TextStyle(
                                      font: ttf, fontWeight: pw.FontWeight.bold, fontSize: 10.0))),
                          pw.Container(
                            constraints: const pw.BoxConstraints(
                              minWidth: 30,
                            ),
                            child: pw.Text('',
                                style: pw.TextStyle(
                                    font: ttf, fontWeight: pw.FontWeight.bold, fontSize: 9.0),
                                textAlign: pw.TextAlign.right),
                          ),
                          pw.Container(
                            constraints: const pw.BoxConstraints(
                              minWidth: 59,
                            ),
                            child: pw.Text('Price',
                                style: pw.TextStyle(
                                    font: ttf, fontWeight: pw.FontWeight.bold, fontSize: 10.0),
                                textAlign: pw.TextAlign.end),
                          )
                        ]),
                        pw.TableRow(children: [
                          pw.Container(height: 3),
                          pw.Container(),
                          pw.Container(),
                        ]),
                        // Item satırları
                        ...invoice.transactionData.items.map((e) {
                          return pw.TableRow(children: [
                            pw.Text(DoubleConvert().formatDouble(e.qty),
                                style: pw.TextStyle(fontSize: printer.productFontSize, font: ttf),
                                textAlign: pw.TextAlign.center),
                            pw.Container(
                                padding: const pw.EdgeInsetsDirectional.only(start: 2, bottom: 1.0),
                                child: pw.Text(e.itemName,
                                    style:
                                        pw.TextStyle(fontSize: printer.productFontSize, font: ttf),
                                    textAlign: pw.TextAlign.start)),
                            pw.Text("%21",
                                style: pw.TextStyle(fontSize: 9.0, font: ttf),
                                textAlign: pw.TextAlign.right),
                            pw.Text(
                                e.status == 2
                                    ? "IKRAM"
                                    : DoubleConvert().formatPriceDouble(e.itemPrice),
                                style: pw.TextStyle(fontSize: printer.productFontSize, font: ttf),
                                textAlign: pw.TextAlign.end),
                          ]);
                        }),
                      ],
                    ),

                    InvoiceWidget.buildDottedLine(
                        reducedWidth: reducedSize, screenWidth: screenWidth),

                    /// ************************ end of part nama item, quantity, price, tax ************************** ///

                    InvoiceWidget.buildItems(
                        title: 'SubTotal',
                        value: invoice.transactionData.subTotal.toString(),
                        reducedWidth: reducedSize,
                        fontSize: printer.subFontSize,
                        isBold: true,
                        screenWidth: screenWidth),
                    InvoiceWidget.buildPadding(screenWidth: screenWidth, index_: 2),

                    ...invoice.transactionData.service.map((e) {
                      return pw.Container(
                        child: pw.Column(
                          children: [
                            InvoiceWidget.buildItems(
                                title: 'Service${e.percentile > 0 ? " %${e.percentile}" : ""}',
                                value: e.amount.toString(),
                                reducedWidth: reducedSize,
                                fontSize: printer.fontSize,
                                screenWidth: screenWidth),
                          ],
                        ),
                      );
                    }),

                    ...invoice.transactionData.cover.map((e) {
                      return pw.Container(
                        child: pw.Column(
                          children: [
                            InvoiceWidget.buildItems(
                                title:
                                    'Cover ${e.percentile > 0 ? ('%${DoubleConvert().formatDouble(e.percentile)}') : ""}',
                                value: e.price.toString(),
                                reducedWidth: reducedSize,
                                fontSize: printer.fontSize,
                                screenWidth: screenWidth),
                          ],
                        ),
                      );
                    }),
                    invoice.transactionData.discountTotal == 0
                        ? pw.Container()
                        : InvoiceWidget.buildItems(
                            title: 'Total Discount',
                            value: invoice.transactionData.discountTotal.toString(),
                            reducedWidth: reducedSize,
                            fontSize: printer.fontSize,
                            screenWidth: screenWidth),
                    InvoiceWidget.buildItems(
                        title: 'Total Tax',
                        value: invoice.transactionData.taxTotal.toString(),
                        reducedWidth: reducedSize,
                        fontSize: printer.fontSize,
                        screenWidth: screenWidth),

                    InvoiceWidget.buildItems(
                        title: 'Total',
                        value: invoice.transactionData.total.toString(),
                        reducedWidth: reducedSize,
                        fontSize: printer.totalFontSize,
                        isBold: true,
                        screenWidth: screenWidth),
                    invoice.transactionData.payAmount > 0
                        ? InvoiceWidget.buildItems(
                            title: 'Pay amount',
                            value: invoice.transactionData.payAmount.toString(),
                            reducedWidth: reducedSize,
                            fontSize: printer.fontSize,
                            screenWidth: screenWidth)
                        : pw.Container(),
                    invoice.transactionData.payAmount > 0
                        ? InvoiceWidget.buildItems(
                            title: 'Change',
                            value: invoice.transactionData.change.toString(),
                            reducedWidth: reducedSize,
                            fontSize: printer.fontSize,
                            screenWidth: screenWidth)
                        : pw.Container()
                  ],

                  /// ********************************* invoice footer ******************************** ///
                  InvoiceWidget.buildDottedLine(
                      reducedWidth: reducedSize, screenWidth: screenWidth),
                  InvoiceWidget.buildItems(
                      title: invoice.footerData.footer1,
                      value: '',
                      fontSize: 10,
                      centerPos: true,
                      screenWidth: screenWidth),
                  InvoiceWidget.buildItems(
                      title: invoice.footerData.footer2,
                      value: '',
                      fontSize: 10,
                      centerPos: true,
                      screenWidth: screenWidth),
                ],
              ),
            )
          ];
        },
      ),
    );

    final res = await Printing.directPrintPdf(
      printer: Printer(url: printer.url),
      onLayout: (_) => doc.save(),
      format: pageFormat,
      usePrinterSettings: true,
    );

    if (res) {
      Logger().i("Printer");
    } else {
      Logger().i(res);
    }
  }

  printKitchen(CustomPrinterModel? printer, PrinterKitchenInvoice invoice) async {
    if (printer == null) return;
    final Uint8List fontData = File(AppConstants.font_URL).readAsBytesSync();
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final doc = pw.Document();
    double screenWidth = (printer.pdfPageSize) * PdfPageFormat.mm;
    const height = 300.0 * PdfPageFormat.mm;
    var pageFormat = PdfPageFormat(screenWidth, height);

    int reducedSize = 0;
    doc.addPage(
      pw.MultiPage(
        pageFormat: pageFormat,
        build: (pw.Context context) {
          return [
            pw.Padding(
              padding: const pw.EdgeInsetsDirectional.only(start: 12),
              child: pw.Column(
                children: [
                  /// ********************************* invoice header ******************************** ///

                  InvoiceWidget.buildTitleItem(
                      title: invoice.headerData.header1,
                      isBold: true,
                      fontSize: printer.titleFontSize,
                      screenWidth: screenWidth),

                  InvoiceWidget.buildDottedLineSpecial(
                      reducedWidth: reducedSize, screenWidth: screenWidth),

                  /// ********************************* invoice items ******************************** ///
                  if (invoice.transactionData.items.isNotEmpty) ...[
                    InvoiceWidget.buildItems(
                        title: 'Date',
                        value: invoice.transactionData.date,
                        reducedWidth: reducedSize,
                        fontSize: printer.fontSize,
                        screenWidth: screenWidth),
                    InvoiceWidget.buildItems(
                        title: 'Transaction ID',
                        value: invoice.transactionData.orderNo.toString(),
                        reducedWidth: reducedSize,
                        fontSize: printer.fontSize,
                        screenWidth: screenWidth),
                    InvoiceWidget.buildItemsSpecial(
                        title: 'Cashier Name',
                        value: invoice.transactionData.cashierName,
                        reducedWidth: reducedSize,
                        fontSize: printer.fontSize,
                        screenWidth: screenWidth),
                    InvoiceWidget.buildItems(
                        title: 'Table',
                        value: invoice.transactionData.table,
                        reducedWidth: reducedSize,
                        fontSize: printer.fontSize,
                        screenWidth: screenWidth),
                    InvoiceWidget.buildDottedLine(
                        reducedWidth: reducedSize, screenWidth: screenWidth),

                    /// *************************** part nama item, quantity, price, tax ****************************** ///
                    pw.Divider(height: 2),
                    InvoiceWidget.buildDottedLine(
                        reducedWidth: reducedSize, screenWidth: screenWidth),
                    pw.Table(
                      defaultColumnWidth: const pw.IntrinsicColumnWidth(),
                      defaultVerticalAlignment: pw.TableCellVerticalAlignment.full,
                      children: [
                        ...invoice.transactionData.firstItems.expand((e) {
                          return [
                            pw.TableRow(
                              children: [
                                pw.Container(
                                    constraints: const pw.BoxConstraints(
                                      minWidth: 30,
                                    ),
                                    child: pw.Text(
                                      DoubleConvert().formatDouble(e.qty),
                                      style: pw.TextStyle(
                                          fontSize: printer.productFontSize, font: ttf),
                                      textAlign: pw.TextAlign.center,
                                    )),
                                pw.Padding(
                                  padding:
                                      const pw.EdgeInsetsDirectional.only(start: 2, bottom: 1.0),
                                  child: pw.Text(
                                    '${e.itemName} | ${e.itemPriceName}',
                                    style:
                                        pw.TextStyle(fontSize: printer.productFontSize, font: ttf),
                                    textAlign: pw.TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            ...e.itemOption.expand((o) {
                              return [
                                pw.TableRow(
                                  children: [
                                    pw.Container(
                                        constraints: const pw.BoxConstraints(
                                          minWidth: 30,
                                        ),
                                        child: pw.Text(
                                          "+",
                                          style: pw.TextStyle(
                                              fontSize: printer.optionFontSize + 1,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold),
                                          textAlign: pw.TextAlign.end,
                                        )),
                                    pw.Padding(
                                      padding: const pw.EdgeInsetsDirectional.only(
                                          top: 3.0, start: 2.0, bottom: 3.0),
                                      child: pw.Text(
                                        '${o.name}: ${getOptionString(o.items)}',
                                        style: pw.TextStyle(
                                            fontSize: printer.optionFontSize,
                                            font: ttf,
                                            fontWeight: pw.FontWeight.bold),
                                        textAlign: pw.TextAlign.start,
                                      ),
                                    ),
                                  ],
                                )
                              ];
                            }),
                            e.note.isNotEmpty
                                ? pw.TableRow(
                                    children: [
                                      pw.Container(
                                          constraints: const pw.BoxConstraints(
                                            minWidth: 30,
                                          ),
                                          child: pw.Text(
                                            "*",
                                            style: pw.TextStyle(
                                                fontSize: printer.noteFontSize + 1,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold),
                                            textAlign: pw.TextAlign.end,
                                          )),
                                      pw.Padding(
                                        padding: const pw.EdgeInsetsDirectional.only(
                                            top: 3.0, start: 2.0, bottom: 3.0),
                                        child: pw.Text(
                                          e.note,
                                          style: pw.TextStyle(
                                              fontSize: printer.noteFontSize,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold),
                                          textAlign: pw.TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  )
                                : const pw.TableRow(children: []),
                          ];
                        }),
                        invoice.transactionData.firstItems.isNotEmpty
                            ? pw.TableRow(
                                children: [
                                  pw.Padding(
                                      padding: const pw.EdgeInsetsDirectional.only(bottom: 3.0),
                                      child: pw.Divider(height: 1)),
                                  pw.Padding(
                                      padding: const pw.EdgeInsetsDirectional.only(bottom: 3.0),
                                      child: pw.Divider(height: 1)),
                                ],
                              )
                            : const pw.TableRow(children: []),
                        ...invoice.transactionData.items.expand((e) {
                          return [
                            pw.TableRow(
                              children: [
                                pw.Container(
                                    constraints: const pw.BoxConstraints(
                                      minWidth: 30,
                                    ),
                                    child: pw.Text(
                                      DoubleConvert().formatDouble(e.qty),
                                      style: pw.TextStyle(
                                          fontSize: printer.productFontSize, font: ttf),
                                      textAlign: pw.TextAlign.center,
                                    )),
                                pw.Padding(
                                  padding:
                                      const pw.EdgeInsetsDirectional.only(start: 2, bottom: 1.0),
                                  child: pw.Text(
                                    '${e.itemName} | ${e.itemPriceName}',
                                    style:
                                        pw.TextStyle(fontSize: printer.productFontSize, font: ttf),
                                    textAlign: pw.TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            ...e.itemOption.expand((o) {
                              return [
                                pw.TableRow(
                                  children: [
                                    pw.Container(
                                        constraints: const pw.BoxConstraints(
                                          minWidth: 30,
                                        ),
                                        child: pw.Text(
                                          "+",
                                          style: pw.TextStyle(
                                              fontSize: printer.optionFontSize + 1,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold),
                                          textAlign: pw.TextAlign.end,
                                        )),
                                    pw.Padding(
                                      padding: const pw.EdgeInsetsDirectional.only(
                                          top: 3.0, start: 2.0, bottom: 3.0),
                                      child: pw.Text(
                                        '${o.name}: ${getOptionString(o.items)}',
                                        style: pw.TextStyle(
                                            fontSize: printer.optionFontSize,
                                            font: ttf,
                                            fontWeight: pw.FontWeight.bold),
                                        textAlign: pw.TextAlign.start,
                                      ),
                                    ),
                                  ],
                                )
                              ];
                            }),
                            e.note.isNotEmpty
                                ? pw.TableRow(
                                    children: [
                                      pw.Container(
                                          constraints: const pw.BoxConstraints(
                                            minWidth: 30,
                                          ),
                                          child: pw.Text(
                                            "*",
                                            style: pw.TextStyle(
                                                fontSize: printer.noteFontSize + 1,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold),
                                            textAlign: pw.TextAlign.end,
                                          )),
                                      pw.Padding(
                                        padding: const pw.EdgeInsetsDirectional.only(
                                            top: 3.0, start: 2.0, bottom: 3.0),
                                        child: pw.Text(
                                          e.note,
                                          style: pw.TextStyle(
                                              fontSize: printer.noteFontSize,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold),
                                          textAlign: pw.TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  )
                                : const pw.TableRow(children: []),
                          ];
                        }),
                      ],
                    ),

                    InvoiceWidget.buildDottedLine(
                        reducedWidth: reducedSize, screenWidth: screenWidth),

                    /// ************************ end of part nama item, quantity, price, tax ************************** ///
                  ],

                  /// ********************************* invoice footer ******************************** ///
                  /*          InvoiceWidget.buildDottedLine(
                      reducedWidth: reducedSize, screenWidth: screenWidth),
                  InvoiceWidget.buildItems(
                      title: invoice.footerData.footer1,
                      value: '',
                      fontSize: 10,
                      centerPos: true,
                      screenWidth: screenWidth),
                  InvoiceWidget.buildItems(
                      title: invoice.footerData.footer2,
                      value: '',
                      fontSize: 10,
                      centerPos: true,
                      screenWidth: screenWidth),*/
                ],
              ),
            )
          ];
        },
      ),
    );

    final res = await Printing.directPrintPdf(
      printer: Printer(url: printer.url),
      onLayout: (_) => doc.save(),
      format: pageFormat,
      usePrinterSettings: true,
    );

    if (res) {
      Logger().i("Printer");
    } else {
      Logger().i(res);
    }
  }

  printKitchenCancelInfo(CustomPrinterModel? printer, PrinterKitchenCancelInvoice invoice) async {
    if (printer == null) return;
    final Uint8List fontData = File(AppConstants.font_URL).readAsBytesSync();
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final doc = pw.Document();
    double screenWidth = (printer.pdfPageSize) * PdfPageFormat.mm;
    const height = 300.0 * PdfPageFormat.mm;
    var pageFormat = PdfPageFormat(screenWidth, height);
    int reducedSize = 0;
    doc.addPage(
      pw.MultiPage(
        pageFormat: pageFormat,
        build: (pw.Context context) {
          return [
            pw.Padding(
              padding: const pw.EdgeInsetsDirectional.only(start: 12),
              child: pw.Column(
                children: [
                  /// ********************************* invoice header ******************************** ///

                  InvoiceWidget.buildTitleItem(
                      title: invoice.headerData.header1,
                      isBold: true,
                      fontSize: printer.titleFontSize,
                      screenWidth: screenWidth),

                  InvoiceWidget.buildDottedLineSpecial(
                      reducedWidth: reducedSize, screenWidth: screenWidth),

                  /// ********************************* invoice items ******************************** ///
                  if (invoice.transactionData.items.isNotEmpty) ...[
                    InvoiceWidget.buildItems(
                        title: 'Date',
                        value: invoice.transactionData.date,
                        reducedWidth: reducedSize,
                        fontSize: printer.fontSize,
                        screenWidth: screenWidth),
                    InvoiceWidget.buildItems(
                        title: 'Transaction ID',
                        value: invoice.transactionData.orderNo.toString(),
                        reducedWidth: reducedSize,
                        fontSize: printer.fontSize,
                        screenWidth: screenWidth),
                    InvoiceWidget.buildItemsSpecial(
                        title: 'Cashier Name',
                        value: invoice.transactionData.cashierName,
                        reducedWidth: reducedSize,
                        fontSize: printer.fontSize,
                        screenWidth: screenWidth),
                    InvoiceWidget.buildItems(
                        title: 'Table',
                        value: invoice.transactionData.table,
                        reducedWidth: reducedSize,
                        fontSize: printer.fontSize,
                        screenWidth: screenWidth),
                    InvoiceWidget.buildDottedLine(
                        reducedWidth: reducedSize, screenWidth: screenWidth),

                    /// *************************** part nama item, quantity, price, tax ****************************** ///
                    pw.Divider(height: 2),
                    InvoiceWidget.buildDottedLine(
                        reducedWidth: reducedSize, screenWidth: screenWidth),
                    pw.Table(
                      defaultColumnWidth: const pw.IntrinsicColumnWidth(),
                      defaultVerticalAlignment: pw.TableCellVerticalAlignment.full,
                      children: [
                        ...invoice.transactionData.items.expand((e) {
                          return [
                            pw.TableRow(
                              children: [
                                pw.Container(
                                    constraints: const pw.BoxConstraints(
                                      minWidth: 30,
                                    ),
                                    child: pw.Text(
                                      DoubleConvert().formatDouble(e.qty),
                                      style: pw.TextStyle(
                                          fontSize: printer.productFontSize, font: ttf),
                                      textAlign: pw.TextAlign.center,
                                    )),
                                pw.Padding(
                                  padding:
                                      const pw.EdgeInsetsDirectional.only(start: 2, bottom: 1.0),
                                  child: pw.Text(
                                    '${e.itemName} | ${e.itemPriceName}',
                                    style:
                                        pw.TextStyle(fontSize: printer.productFontSize, font: ttf),
                                    textAlign: pw.TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            e.optionString.isNotEmpty
                                ? pw.TableRow(
                                    children: [
                                      pw.Container(
                                          constraints: const pw.BoxConstraints(
                                            minWidth: 30,
                                          ),
                                          child: pw.Text(
                                            "+",
                                            style: pw.TextStyle(
                                                fontSize: printer.optionFontSize + 1,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold),
                                            textAlign: pw.TextAlign.end,
                                          )),
                                      pw.Padding(
                                        padding: const pw.EdgeInsetsDirectional.only(
                                            top: 3.0, start: 2.0, bottom: 3.0),
                                        child: pw.Text(
                                          '${getOptionProductString(e.optionString)}',
                                          style: pw.TextStyle(
                                              fontSize: printer.optionFontSize,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold),
                                          textAlign: pw.TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  )
                                : const pw.TableRow(children: []),
                            e.note.isNotEmpty
                                ? pw.TableRow(
                                    children: [
                                      pw.Container(
                                          constraints: const pw.BoxConstraints(
                                            minWidth: 30,
                                          ),
                                          child: pw.Text(
                                            "*",
                                            style: pw.TextStyle(
                                                fontSize: printer.noteFontSize + 1,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold),
                                            textAlign: pw.TextAlign.end,
                                          )),
                                      pw.Padding(
                                        padding: const pw.EdgeInsetsDirectional.only(
                                            top: 3.0, start: 2.0, bottom: 3.0),
                                        child: pw.Text(
                                          e.note,
                                          style: pw.TextStyle(
                                              fontSize: printer.noteFontSize,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold),
                                          textAlign: pw.TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  )
                                : const pw.TableRow(children: []),
                          ];
                        }),
                      ],
                    ),

                    InvoiceWidget.buildDottedLine(
                        reducedWidth: reducedSize, screenWidth: screenWidth),
                  ],
                ],
              ),
            )
          ];
        },
      ),
    );

    final res = await Printing.directPrintPdf(
      printer: Printer(url: printer.url),
      onLayout: (_) => doc.save(),
      format: pageFormat,
      usePrinterSettings: true,
    );

    if (res) {
      Logger().i("Printer");
    } else {
      Logger().i(res);
    }
  }

  Future<List<Printer>> findPrinters() async {
    Logger().i(await Printing.listPrinters());
    return await Printing.listPrinters();
  }
}
