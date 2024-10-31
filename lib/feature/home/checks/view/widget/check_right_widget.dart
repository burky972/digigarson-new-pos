import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_cubit.dart';
import 'package:a_pos_flutter/feature/home/checks/cubit/check_cubit.dart';
import 'package:a_pos_flutter/feature/home/checks/cubit/check_state.dart';
import 'package:a_pos_flutter/feature/home/checks/model/check_response_model.dart';
import 'package:a_pos_flutter/feature/home/checks/model/re_open_model.dart';
import 'package:a_pos_flutter/feature/home/checks/model/single_check_model.dart';
import 'package:a_pos_flutter/feature/home/printer/cubit/printer_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/date_time_format/date_time_format.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/model/print/print_invoice_model.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/utils/helper/format_double.dart';
import 'package:a_pos_flutter/product/widget/dialog/old_checkout_dialog.dart';
import 'package:a_pos_flutter/product/widget/invoices/invoice_widget.dart';
import 'package:a_pos_flutter/product/widget/printer/printer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'sub/check_right_sub_widget.dart';

class CheckRightWidget extends StatefulWidget {
  const CheckRightWidget({super.key});

  @override
  State<CheckRightWidget> createState() => _CheckRightWidgetState();
}

class _CheckRightWidgetState extends State<CheckRightWidget> with _CheckRightMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      child: ListView(
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const AppPadding.extraMinAll(),
            child: Container(
              height: context.dynamicHeight(.35),
              decoration: BoxDecoration(
                color: Colors.white,
                border: BorderConstants.borderAllSmall,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const AppPadding.extraMinAll(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        headTitle.length,
                        (index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: const AppPadding.extraMinAll(),
                              width: context.dynamicWidth(headTitle[index].width),
                              child: Text(headTitle[index].text),
                            ),
                            index < headTitle.length - 1
                                ? const SizedBox(
                                    width: 1,
                                    child: Text("|", style: TextStyle(fontSize: 20)),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: BlocSelector<CheckCubit, CheckState, SingleCheckModel?>(
                            selector: (state) => state.selectedCheck,
                            builder: (context, selectedCheck) {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: selectedCheck?.orders?.first.products.length ?? 0,
                                itemBuilder: (context, rowIndex) {
                                  List<Product?> products =
                                      selectedCheck!.orders?.first.products ?? [];
                                  Product? product = products[rowIndex];

                                  // Main product data
                                  List<String> productData = [
                                    (product?.cancelStatus?.isCancelled ?? false ? '0' : ''),
                                    product?.productName.toString() ?? '',
                                    product?.price.toString() ?? '',
                                    DoubleConvert()
                                        .formatDouble(product?.quantity?.toDouble() ?? 0)
                                        .toString()
                                  ];

                                  return Column(
                                    children: [
                                      // Main product row
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: List.generate(
                                          headTitle.length,
                                          (index) => Container(
                                            padding: const EdgeInsets.only(left: 3, right: 3),
                                            width: context.dynamicWidth(headTitle[index].width),
                                            child: index == 0
                                                ? Icon(
                                                    productData[index] == "0"
                                                        ? Icons.cancel_rounded
                                                        : Icons.check,
                                                    color: productData[index] == "0"
                                                        ? Colors.red
                                                        : Colors.green)
                                                : Text(
                                                    productData[index],
                                                    style: CustomFontStyle.menuTextStyle
                                                        .copyWith(fontSize: 16),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      // Options and items if they exist
                                      if (product?.options != null && product!.options.isNotEmpty)
                                        ...product.options.map((option) {
                                          if (option.items.isNotEmpty) {
                                            return Column(
                                              children: option.items.map((item) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(left: 40.0, right: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.only(
                                                            left: 3, right: 3),
                                                        width: context
                                                            .dynamicWidth(headTitle[0].width),
                                                        child:
                                                            const SizedBox(), // Empty space for alignment
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.only(
                                                            left: 3, right: 3),
                                                        width: context
                                                            .dynamicWidth(headTitle[1].width),
                                                        child: Text(
                                                          "++ ${item.itemName}",
                                                          style: CustomFontStyle.menuTextStyle
                                                              .copyWith(
                                                            fontSize: 14,
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.only(
                                                            left: 3, right: 3),
                                                        width: context
                                                            .dynamicWidth(headTitle[2].width),
                                                        child: Text(
                                                          "${item.price}",
                                                          style: CustomFontStyle.menuTextStyle
                                                              .copyWith(
                                                            fontSize: 14,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.only(
                                                            left: 3, right: 3),
                                                        width: context
                                                            .dynamicWidth(headTitle[3].width),
                                                        child: const Text(
                                                          "1",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            );
                                          }
                                          return const SizedBox.shrink();
                                        }),
                                    ],
                                  );
                                },
                              );
                            },
                          ))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: context.dynamicHeight(.18),
            constraints: const BoxConstraints(minHeight: 120, maxHeight: 130),
            decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
            padding: const EdgeInsets.all(5),
            child: BlocSelector<CheckCubit, CheckState, SingleCheckModel?>(
                selector: (state) => state.selectedCheck,
                builder: ((context, selectOrder) => Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: context.dynamicWidth(.25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const _CheckLeftTextWidget(text: "Open Date:"),
                              _CheckRightText(
                                  text: selectOrder != null
                                      ? selectOrder.createdAt!.toLocal().toFormattedString()
                                      : "")
                            ],
                          ),
                        ),
                        SizedBox(
                          width: context.dynamicWidth(.25),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween, //TODO: check closed time
                            children: [
                              const _CheckLeftTextWidget(text: "Closed Date:"),
                              _CheckRightText(
                                  text: selectOrder != null
                                      ? selectOrder.updatedAt!.toLocal().toFormattedString()
                                      : "")
                            ],
                          ),
                        ),
                        SizedBox(
                          width: context.dynamicWidth(.25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const _CheckLeftTextWidget(text: "Closed by:"),
                              _CheckRightText(
                                  text: selectOrder != null ? selectOrder.user!.name ?? "" : "")
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: context.dynamicWidth(.35),
            constraints: const BoxConstraints(minHeight: 240, maxHeight: 250),
            decoration: BoxDecoration(
              border: BorderConstants.borderAllSmall,
            ),
            padding: const EdgeInsets.all(5),
            child: BlocBuilder<CheckCubit, CheckState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: context.dynamicWidth(.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _CheckLeftTextWidget(text: "Sub Total:"),
                          _CheckRightText(
                              text: state.selectedCheck != null
                                  ? state.selectedCheck!.totalPrice.toString()
                                  : "")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: context.dynamicWidth(.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _CheckLeftTextWidget(text: "Tax:"),
                          _CheckRightText(
                              text: state.selectedCheck != null
                                  ? state.selectedCheck!.totalTax.toString()
                                  : "")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: context.dynamicWidth(.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _CheckLeftTextWidget(text: "Discount:"),
                          _CheckRightText(
                              text: state.selectedCheck != null &&
                                      state.selectedCheck!.discounts != null &&
                                      state.selectedCheck!.discounts!.isNotEmpty
                                  ? state.selectedCheck!.discounts?.first.amount.toString() ?? '0.0'
                                  : "0.0")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: context.dynamicWidth(.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _CheckLeftTextWidget(text: "Service:"),
                          _CheckRightText(
                              text: state.selectedCheck != null &&
                                      state.selectedCheck!.serviceFee != null &&
                                      state.selectedCheck!.serviceFee!.isNotEmpty
                                  ? state.selectedCheck!.serviceFee?.first.amount.toString() ??
                                      '0.0'
                                  : "0.0")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: context.dynamicWidth(.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _CheckLeftTextWidget(text: "Cover:"),
                          _CheckRightText(
                              text: state.selectedCheck != null &&
                                      state.selectedCheck!.covers != null &&
                                      state.selectedCheck!.covers!.isNotEmpty
                                  ? state.selectedCheck!.covers?.first.price.toString() ?? '0.0'
                                  : "0.0")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: context.dynamicWidth(.25),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _CheckLeftTextWidget(text: "Gratuity:"),
                          _CheckRightText(text: "0.0")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: context.dynamicWidth(.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _CheckLeftTextWidget(text: "Amount Due:"),
                          _CheckRightText(
                              text: state.selectedCheck != null
                                  ? (state.selectedCheck!.totalPrice! +
                                          state.selectedCheck!.totalTax!)
                                      .toStringAsFixed(2)
                                  : "")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: context.dynamicWidth(.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _CheckLeftTextWidget(text: "Card Payment:"),
                          _CheckRightText(
                              text: state.selectedCheck?.payments!
                                      .where((e) => e.type == 1)
                                      .fold(
                                          0.0,
                                          (previousValue, element) =>
                                              previousValue + element.amount!)
                                      .toStringAsFixed(2) ??
                                  "")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: context.dynamicWidth(.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _CheckLeftTextWidget(text: "Cash Payment:"),
                          _CheckRightText(
                            text: state.selectedCheck?.payments!
                                    .where((e) => e.type == 2)
                                    .fold(0.0,
                                        (previousValue, element) => previousValue + element.amount!)
                                    .toStringAsFixed(2) ??
                                "",
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<CheckCubit, CheckState>(
                builder: (context, state) {
                  return InkWell(
                      onTap: () {
                        if (state.selectedCheck == null) return;
                        OldCheckDialog().show(context, index: 1, state.selectedCheck);
                      },
                      child: const _CheckButton(buttonText: "Re Open"));
                },
              ),
              BlocBuilder<CheckCubit, CheckState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () async {
                      if (state.selectedCheck == null ||
                          state.checkModelList == null ||
                          state.checkModelList!.isEmpty) return;
                      Iterable<CheckModel> order = state.checkModelList!
                          .where((element) => element.id == state.selectedCheck?.id);
                      if (order.isNotEmpty) {
                        Iterable<TableModel> table = context
                            .read<TableCubit>()
                            .tableModel
                            .where((element) => element.id == order.first.table?.id);
                        PrinterInvoiceModel invoice = PrinterWidget().invoiceOldCheckConvert(
                            printer: context.read<PrinterCubit>().casePrinter,
                            selectedTable: state.selectedCheck,
                            check: order.first,
                            context: context,
                            section: table.isNotEmpty
                                ? '${context.read<SectionCubit>().allSectionList.where((element) => element.id == table.first.section).first.title} ${table.first.title}'
                                : "");
                        InvoiceWidget().print(context.read<PrinterCubit>().casePrinter, invoice);
                      }
                    },
                    child: const _CheckButton(buttonText: 'Print'),
                  );
                },
              ),
              InkWell(
                  onTap: () {
                    routeManager.pop();
                  },
                  child: const _CheckButton(buttonText: 'Cancel')),
            ],
          ),
        ],
      ),
    );
  }
}

mixin _CheckRightMixin on State<CheckRightWidget> {
  final List<ReOpenModel> headTitle = [
    const ReOpenModel(text: 'ST', width: 0.03),
    const ReOpenModel(text: 'Item', width: 0.12),
    const ReOpenModel(text: 'Price', width: 0.06),
    const ReOpenModel(text: 'Qty', width: 0.05)
  ];

  @override
  void initState() {
    super.initState();
  }
}
