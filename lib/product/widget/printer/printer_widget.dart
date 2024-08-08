import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
import 'package:a_pos_flutter/feature/home/reopen/model/chek_old_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/global/model/print/customer_printer_model.dart';
import 'package:a_pos_flutter/product/global/model/print/print_invoice_model.dart';
import 'package:a_pos_flutter/product/utils/helper/format_double.dart';
import 'package:a_pos_flutter/product/utils/helper/formatter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrinterWidget {
  PrinterInvoiceModel invoiceConvert(
      TableModel? selectedTable, CustomPrinterModel? printer, BuildContext context) {
    String table = "";
    int orderNo = 0;
    List<ItemPrinter> items = [];
    List<ServicePrinter> service = [];
    List<CoverPrinter> cover = [];
    double subTotal = 0.0;
    double discountTotal = 0.0;
    double taxTotal = 0.0;
    double total = 0.0;
    double payAmount = 0.0;
    double change = 0.0;
    if (selectedTable != null) {
      table =
          '${context.read<BranchCubit>().branchModel!.sections!.where((element) => element.sId == selectedTable.section).first.title} ${selectedTable.title}';
      for (var order in selectedTable.orders) {
        orderNo = order.checkNo!;
        for (var product in order.products) {
          subTotal += (product!.status! > 0
              ? product.isServe!
                  ? 0.0
                  : product.price!
              : 0.0);
          if (product.status! != 0) {
            ItemPrinter newItem = ItemPrinter(
                itemId: product.product.toString(),
                itemPriceName: product.priceName.toString(),
                itemName: product.productName.toString().trim(),
                itemOptionString: product.optionsString.toString().trim(),
                itemPrice: product.price!,
                qty: product.quantity!,
                discountAmounte: 0,
                status: product.isServe! ? 2 : 1,
                discountName: "");
            updateItemIfExist(items, newItem);
          }
        }
      }
      for (var serviceFree in selectedTable.serviceFee!) {
        service.add(ServicePrinter(
            amount: double.parse(DoubleConvert().formatPriceDouble(serviceFree.amount!)),
            percentile: double.parse(DoubleConvert().formatDouble(serviceFree.percentile!)),
            type: serviceFree.type!,
            id: serviceFree.id!));
      }
      for (var cover_ in selectedTable.cover) {
        cover.add(CoverPrinter(
            isPaid: cover_.isPaid!,
            price: double.parse(DoubleConvert().formatDouble(cover_.price!)),
            percentile: 10,
            quantity: cover_.quantity!,
            title: cover_.title!,
            id: cover_.id!));
      }
      for (var discount in selectedTable.discount) {
        discountTotal += discount.amount!;
      }
      total = selectedTable.totalPrice!;
      for (var payment in selectedTable.payments) {
        payAmount += payment.amount!;
      }
      change = selectedTable.remainingPrice!;
    }
    TransactionData transactionData = TransactionData(
        date: Formatter.formatDate(dateString: DateTime.now().toString()),
        cashierName: "Sedat Dayan",
        table: table,
        orderNo: orderNo,
        items: items,
        service: service,
        cover: cover,
        subTotal: double.parse(DoubleConvert().formatDouble(subTotal)),
        discountTotal: double.parse(DoubleConvert().formatDouble(discountTotal)),
        taxTotal: double.parse(DoubleConvert().formatDouble(taxTotal)),
        total: double.parse(DoubleConvert().formatDouble(total)),
        payAmount: double.parse(DoubleConvert().formatDouble(payAmount)),
        change: double.parse(DoubleConvert().formatDouble(change)));
    FooterData footerData =
        FooterData(footer1: "Thank you for choosing us", footer2: "www.digigarson.com");
    return PrinterInvoiceModel(
        headerData:
            HeaderData(header1: printer != null ? printer.comment.toString() : "Digigarson "),
        transactionData: transactionData,
        footerData: footerData,
        msg: "msg");
  }

  PrinterInvoiceModel invoiceOldCheckConvert(
      OldCheckModel? selectedTable, CustomPrinterModel? printer, BuildContext context,
      {String? section}) {
    String table = "";
    int orderNo = 0;
    List<ItemPrinter> items = [];
    List<ServicePrinter> service = [];
    List<CoverPrinter> cover = [];
    double subTotal = 0.0;
    double discountTotal = 0.0;
    double serviceTotal = 0.0;
    double coverTotal = 0.0;
    double taxTotal = 0.0;
    double total = 0.0;
    double payAmount = 0.0;
    double change = 0.0;
    if (selectedTable != null) {
      table = section ?? "";
      for (var order in selectedTable.orders!) {
        orderNo = order.checkNo!;
        for (var product in order.products!) {
          subTotal += (product.status! > 0
              ? product.isServe!
                  ? 0.0
                  : product.price!
              : 0.0);
          if (product.status! != 0) {
            ItemPrinter newItem = ItemPrinter(
                itemId: product.product.toString(),
                itemPriceName: "",
                itemName: product.productName.toString().trim(),
                itemOptionString: product.optionsString.toString().trim(),
                itemPrice: product.price!,
                qty: product.quantity!,
                discountAmounte: 0,
                status: product.isServe! ? 2 : 1,
                discountName: "");
            updateItemIfExist(items, newItem);
          }
        }
      }
      for (var serviceFree in selectedTable.serviceFee!) {
        serviceTotal += double.parse(DoubleConvert().formatPriceDouble(serviceFree.amount!));
        service.add(ServicePrinter(
            amount: double.parse(DoubleConvert().formatPriceDouble(serviceFree.amount!)),
            percentile: double.parse(DoubleConvert().formatDouble(serviceFree.percentile!)),
            type: serviceFree.type!,
            id: serviceFree.sId!));
      }
      for (var cover_ in selectedTable.covers!) {
        coverTotal += double.parse(DoubleConvert().formatDouble(cover_.price!));
        cover.add(CoverPrinter(
            isPaid: cover_.isPaid!,
            price: double.parse(DoubleConvert().formatDouble(cover_.price!)),
            percentile: 10,
            quantity: cover_.quantity!,
            title: cover_.title!,
            id: cover_.sId!));
      }
      for (var discount in selectedTable.discounts!) {
        discountTotal += discount.amount!;
      }
      total = (subTotal + coverTotal + serviceTotal) - discountTotal;
      for (var payment in selectedTable.payments!) {
        payAmount += payment.amount!;
      }
      change = 0;
    }
    TransactionData transactionData = TransactionData(
        date: Formatter.formatDate(dateString: DateTime.now().toString()),
        cashierName: "Sedat Dayan",
        table: table,
        orderNo: orderNo,
        items: items,
        service: service,
        cover: cover,
        subTotal: double.parse(DoubleConvert().formatDouble(subTotal)),
        discountTotal: double.parse(DoubleConvert().formatDouble(discountTotal)),
        taxTotal: double.parse(DoubleConvert().formatDouble(taxTotal)),
        total: double.parse(DoubleConvert().formatDouble(total)),
        payAmount: double.parse(DoubleConvert().formatDouble(payAmount)),
        change: double.parse(DoubleConvert().formatDouble(change)));
    FooterData footerData =
        FooterData(footer1: "Thank you for choosing us", footer2: "www.digigarson.com");
    return PrinterInvoiceModel(
        headerData:
            HeaderData(header1: printer != null ? printer.comment.toString() : "Digigarson "),
        transactionData: transactionData,
        footerData: footerData,
        msg: "msg");
  }

  PrinterKitchenInvoice invoiceKitchenConvert(TableModel? selectedTable,
      Iterable<NewOrderProduct> product, CustomPrinterModel? printer, BuildContext context) {
    String table = "";
    int orderNo = 0;
    if (selectedTable != null) {
      table =
          '${context.read<BranchCubit>().branchModel!.sections!.where((element) => element.sId == selectedTable.section).first.title} ${selectedTable.title}';
      orderNo = selectedTable.checkNo!;
    }
    List<ItemKitchenPrinter> items = [];
    List<ItemKitchenPrinter> firstItems = [];
    for (var o in product) {
      if (o.isFirst) {
        firstItems.add(ItemKitchenPrinter(
            itemId: o.product,
            itemName: o.productName,
            itemPriceName: o.priceName,
            note: o.note,
            itemOption: o.options,
            qty: o.quantity));
      } else {
        items.add(ItemKitchenPrinter(
            itemId: o.product,
            itemName: o.productName,
            itemPriceName: o.priceName,
            note: o.note,
            itemOption: o.options,
            qty: o.quantity));
      }
    }
    TransactionKitchenData transactionData = TransactionKitchenData(
      date: Formatter.formatDate(dateString: DateTime.now().toString()),
      cashierName: "Sedat Dayan",
      table: table,
      orderNo: orderNo,
      items: items,
      firstItems: firstItems,
    );
    FooterData footerData =
        FooterData(footer1: "Thank you for choosing us", footer2: "www.digigarson.com");
    return PrinterKitchenInvoice(
        headerData:
            HeaderData(header1: printer != null ? printer.comment.toString() : "Digigarson "),
        transactionData: transactionData,
        footerData: footerData,
        msg: "msg");
  }

  PrinterKitchenCancelInvoice invoiceKitchenCancelConvert(TableModel? selectedTable,
      Iterable<Product> product, CustomPrinterModel? printer, BuildContext context) {
    String table = "";
    int orderNo = 0;
    if (selectedTable != null) {
      table =
          '${context.read<BranchCubit>().branchModel!.sections!.where((element) => element.sId == selectedTable.section).first.title} ${selectedTable.title}';
      orderNo = selectedTable.checkNo!;
    }
    List<ItemKitchenCancelPrinter> items = [];
    for (var o in product) {
      items.add(ItemKitchenCancelPrinter(
          itemId: o.product.toString(),
          itemName: o.productName.toString(),
          itemPriceName: o.priceName.toString(),
          note: o.note.toString(),
          optionString: o.optionsString.toString(),
          qty: o.quantity!));
    }

    TransactionKitchenCancelData transactionData = TransactionKitchenCancelData(
      date: Formatter.formatDate(dateString: DateTime.now().toString()),
      cashierName: "Sedat Dayan",
      table: table,
      orderNo: orderNo,
      items: items,
    );
    FooterData footerData =
        FooterData(footer1: "Thank you for choosing us", footer2: "www.digigarson.com");
    return PrinterKitchenCancelInvoice(
        //TODO: make it like comment
        // headerData: HeaderData(header1: LocaleKeys.cancelProduct.tr()),
        headerData: HeaderData(header1: LocaleKeys.CANCEL.tr()),
        transactionData: transactionData,
        footerData: footerData,
        msg: "msg");
  }

  void updateItemIfExist(List<ItemPrinter> items, ItemPrinter newItem) {
    String targetItemId = newItem.itemId.toString();

    bool found = false;
    for (int i = 0; i < items.length; i++) {
      if (items[i].itemId == targetItemId && (items[i].status == newItem.status)) {
        if (items[i].itemPrice / items[i].qty == newItem.itemPrice / newItem.qty) {
          items[i].qty += newItem.qty;
          items[i].itemPrice += newItem.itemPrice;
          found = true;
          break;
        }
      }
    }
    if (!found) {
      items.add(newItem);
    }
  }
}
