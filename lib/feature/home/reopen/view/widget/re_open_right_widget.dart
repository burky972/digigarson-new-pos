import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
import 'package:a_pos_flutter/feature/home/printer/cubit/printer_cubit.dart';
import 'package:a_pos_flutter/feature/home/reopen/cubit/reopen_cubit.dart';
import 'package:a_pos_flutter/feature/home/reopen/cubit/reopen_state.dart';
import 'package:a_pos_flutter/feature/home/reopen/model/chek_old_model.dart';
import 'package:a_pos_flutter/feature/home/reopen/model/re_open_model.dart';
import 'package:a_pos_flutter/product/global/model/branch/branch_model.dart';
import 'package:a_pos_flutter/product/global/model/print/print_invoice_model.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/utils/helper/format_double.dart';
import 'package:a_pos_flutter/product/widget/dialog/old_checkout_dialog.dart';
import 'package:a_pos_flutter/product/widget/invoices/invoice_widget.dart';
import 'package:a_pos_flutter/product/widget/printer/printer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
part '../widget/sub/reopen_right_sub_widget.dart';

class ReOpenRightWidget extends StatefulWidget {
  const ReOpenRightWidget({super.key});

  @override
  State<ReOpenRightWidget> createState() => _ReOpenRightWidgetState();
}

class _ReOpenRightWidgetState extends State<ReOpenRightWidget> with _ReopenRightMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.all(0),
      child: ListView(
        children: [
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              height: MediaQuery.of(context).size.height * .35,
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        headTitle.length,
                        (index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              width: MediaQuery.of(context).size.width * headTitle[index].width,
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
                        child: BlocSelector<ReopenCubit, ReopenState, OrderModel?>(
                          selector: (state) => state.selectOrder,
                          builder: (context, selectOrder) {
                            return ListView(
                              scrollDirection: Axis.vertical,
                              children: List.generate(
                                selectOrder != null ? selectOrder.item.length : 0,
                                (rowIndex) {
                                  List<ItemModel> order = selectOrder!.item;
                                  List<String> data = [
                                    order[rowIndex].statusType.toString(),
                                    order[rowIndex].itemName.toString(),
                                    order[rowIndex].price.toString(),
                                    DoubleConvert()
                                        .formatDouble(order[rowIndex].quantitty)
                                        .toString()
                                  ];
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                      headTitle.length,
                                      (index) => Container(
                                        padding: const EdgeInsets.only(left: 3, right: 3),
                                        width: MediaQuery.of(context).size.width *
                                            headTitle[index].width,
                                        child: index == 0
                                            ? Icon(
                                                data[index] == "0"
                                                    ? Icons.cancel_rounded
                                                    : data[index] == "99"
                                                        ? Icons.indeterminate_check_box_outlined
                                                        : Icons.check,
                                                color: data[index] == "0"
                                                    ? Colors.red
                                                    : data[index] == "99"
                                                        ? Colors.amber
                                                        : Colors.green,
                                              )
                                            : Text(
                                                data[index],
                                                style: const TextStyle(fontSize: 17),
                                              ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .18,
            constraints: const BoxConstraints(minHeight: 120, maxHeight: 130),
            decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
            padding: const EdgeInsets.all(5),
            child: BlocSelector<ReopenCubit, ReopenState, OrderModel?>(
                selector: (state) => state.selectOrder,
                builder: ((context, selectOrder) => Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const _ReOpenLeftTextWidget(text: "Open Date:"),
                              _ReOpenRightText(
                                  text: selectOrder != null
                                      ? DateFormat("dd-MM-yyyy HH:mm")
                                          .format(selectOrder.openDate.toLocal())
                                      : "")
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const _ReOpenLeftTextWidget(text: "Closed Date:"),
                              _ReOpenRightText(
                                  text: selectOrder != null
                                      ? DateFormat("dd-MM-yyyy HH:mm")
                                          .format(selectOrder.closedDate.toLocal())
                                      : "")
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const _ReOpenLeftTextWidget(text: "Closed by:"),
                              _ReOpenRightText(
                                  text: selectOrder != null ? selectOrder.closedBy : "")
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
            height: MediaQuery.of(context).size.height * .35,
            constraints: const BoxConstraints(minHeight: 240, maxHeight: 250),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black26,
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.all(5),
            child: BlocBuilder<ReopenCubit, ReopenState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _ReOpenLeftTextWidget(text: "Sub Total:"),
                          _ReOpenRightText(
                              text: state.selectOrder != null
                                  ? state.selectOrder!.item
                                      .fold(
                                          0.0,
                                          (previousValue, element) =>
                                              element.price.toDouble() + previousValue)
                                      .toString()
                                  : "")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _ReOpenLeftTextWidget(text: "Tax:"),
                          _ReOpenRightText(
                              text: state.selectOrder != null
                                  ? state.selectOrder!.Tax.toString()
                                  : "")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _ReOpenLeftTextWidget(text: "Discount:"),
                          _ReOpenRightText(
                              text: state.selectOrder != null
                                  ? state.selectOrder!.discount.toString()
                                  : "")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _ReOpenLeftTextWidget(text: "Service:"),
                          _ReOpenRightText(
                              text: state.selectOrder != null
                                  ? state.selectOrder!.service.toString()
                                  : "")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _ReOpenLeftTextWidget(text: "Cover:"),
                          _ReOpenRightText(
                              text: state.selectOrder != null
                                  ? state.selectOrder!.cover.toString()
                                  : "")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _ReOpenLeftTextWidget(text: "Gratuity:"),
                          _ReOpenRightText(
                              text: state.selectOrder != null
                                  ? state.selectOrder!.gratuity.toString()
                                  : "")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _ReOpenLeftTextWidget(text: "Amount Due:"),
                          _ReOpenRightText(
                              text: state.selectOrder != null
                                  ? (state.selectOrder!.card + state.selectOrder!.cash).toString()
                                  : "")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _ReOpenLeftTextWidget(text: "Card Payment:"),
                          _ReOpenRightText(
                              text: state.selectOrder != null
                                  ? state.selectOrder!.card.toString()
                                  : "")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _ReOpenLeftTextWidget(text: "Cash Payment:"),
                          _ReOpenRightText(
                            text:
                                state.selectOrder != null ? state.selectOrder!.cash.toString() : "",
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<ReopenCubit, ReopenState>(
                builder: (context, state) {
                  return InkWell(
                      onTap: () {
                        if (state.selectOrder == null) return;
                        Iterable<OldCheckModel> order = state.reOpenModel
                            .where((element) => element.sId == state.selectOrder!.orderId);
                        OldCheckDialog().showPutDialog(
                            context, index: 1, order.isNotEmpty ? order.first : null);
                      },
                      child: const _ReOpenButton(buttonText: "Re Open"));
                },
              ),
              BlocBuilder<ReopenCubit, ReopenState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () async {
                      Iterable<OldCheckModel> order = state.reOpenModel
                          .where((element) => element.sId == state.selectOrder?.orderId);
                      if (order.isNotEmpty) {
                        Iterable<TablesModel> table = context
                            .read<BranchCubit>()
                            .branchModel!
                            .tables!
                            .where((element) => element.sId == order.first.table);
                        PrinterInvoiceModel invoice = PrinterWidget().invoiceOldCheckConvert(
                            order.first, context.read<PrinterCubit>().casePrinter, context,
                            section: table.isNotEmpty
                                ? '${context.read<BranchCubit>().branchModel!.sections!.where((element) => element.sId == table.first.section).first.title} ${table.first.title}'
                                : "");
                        InvoiceWidget().print(context.read<PrinterCubit>().casePrinter, invoice);
                      }
                    },
                    child: const _ReOpenButton(buttonText: 'Print'),
                  );
                },
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const _ReOpenButton(buttonText: 'Cancel')),
            ],
          ),
        ],
      ),
    );
  }
}

mixin _ReopenRightMixin on State<ReOpenRightWidget> {
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
