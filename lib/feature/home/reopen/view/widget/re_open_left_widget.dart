import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
import 'package:a_pos_flutter/feature/home/reopen/cubit/reopen_cubit.dart';
import 'package:a_pos_flutter/feature/home/reopen/cubit/reopen_state.dart';
import 'package:a_pos_flutter/feature/home/reopen/model/chek_old_model.dart';
import 'package:a_pos_flutter/feature/home/reopen/model/re_open_model.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/model/branch/branch_model.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReOpenLeftWidget extends StatefulWidget {
  const ReOpenLeftWidget({super.key});

  @override
  State<ReOpenLeftWidget> createState() => _ReOpenLeftWidgetState();
}

class _ReOpenLeftWidgetState extends State<ReOpenLeftWidget> with ReOpenLeftMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const AppPadding(),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
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
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      width: context.dynamicWidth(1) * headTitle[index].width,
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
            padding: const AppPadding.extraMinAll(),
            child: BlocBuilder<ReopenCubit, ReopenState>(
              builder: (context, state) {
                return ListView(
                  children: List.generate(
                    state.reOpenModel.length,
                    (index) {
                      List<OldProducts> listProduct = [];
                      for (var order in state.reOpenModel[index].orders!) {
                        listProduct.addAll(order.products as Iterable<OldProducts>);
                      }
                      Iterable<TablesModel> table = context
                          .read<BranchCubit>()
                          .branchModel!
                          .tables!
                          .where((element) => element.sId == state.reOpenModel[index].table);

                      List<String> data = [
                        state.reOpenModel[index].checkNo.toString(),
                        table.isNotEmpty
                            ? '${context.read<BranchCubit>().branchModel!.sections!.where((element) => element.sId == table.first.section).first.title} ${table.first.title}'
                            : "",
                        state.reOpenModel[index].orderType.toString(),
                        listProduct.length.toString(),
                        state.reOpenModel[index].payments!
                            .fold<double>(
                                0,
                                (previousValue, payment) => payment.type == 2
                                    ? previousValue + payment.amount!
                                    : previousValue)
                            .toString(),
                        state.reOpenModel[index].payments!
                            .fold<double>(
                                0,
                                (previousValue, payment) => payment.type != 2
                                    ? payment.amount! + previousValue
                                    : previousValue)
                            .toString(),
                        state.reOpenModel[index].payments!
                            .fold<double>(
                                0, (previousValue, payment) => previousValue + payment.amount!)
                            .toString(),
                        "${state.reOpenModel[index].user!.name} ${state.reOpenModel[index].user!.lastname}",
                        state.reOpenModel[index].payments!.isNotEmpty
                            ? DateFormat("dd-MM-yyyy HH:mm").format(
                                state.reOpenModel[index].payments!.last.createdAt!.toLocal())
                            : DateFormat("dd-MM-yyyy HH:mm")
                                .format(state.reOpenModel[index].createdAt!.toLocal())
                      ];

                      return InkWell(
                        onTap: () {
                          Iterable<TablesModel> table = context
                              .read<BranchCubit>()
                              .branchModel!
                              .tables!
                              .where((element) => element.sId == state.reOpenModel[index].table);
                          if (table.isNotEmpty) {
                            context.read<ReopenCubit>().setSelectedOrder(
                                id: state.reOpenModel[index].sId.toString(),
                                listProduct: listProduct,
                                table:
                                    '${context.read<BranchCubit>().branchModel!.sections!.where((element) => element.sId == table.first.section).first.title} ${table.first.title}');
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          color: context.watch<ReopenCubit>().selectOrder != null
                              ? context.watch<ReopenCubit>().selectOrder!.orderId ==
                                      state.reOpenModel[index].sId.toString()
                                  ? context.colorScheme.primary
                                  : null
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              headTitle.length,
                              (index) => Container(
                                padding: const EdgeInsets.only(left: 3, right: 3),
                                width: context.dynamicWidth(1) * headTitle[index].width,
                                child: Text(
                                  _formatText(data[index]),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}

mixin ReOpenLeftMixin on State<ReOpenLeftWidget> {
  final List<ReOpenModel> headTitle = [
    const ReOpenModel(text: 'No', width: 0.06),
    const ReOpenModel(text: 'Table NO.', width: 0.07),
    const ReOpenModel(text: 'Gst', width: 0.04),
    const ReOpenModel(text: 'Items', width: 0.06),
    const ReOpenModel(text: 'Cash', width: 0.06),
    const ReOpenModel(text: 'Card', width: 0.06),
    const ReOpenModel(text: 'Total', width: 0.06),
    const ReOpenModel(text: 'Closed By', width: 0.08),
    const ReOpenModel(text: 'Closed DateTime', width: 0.1)
  ];

  /// if text is 14.50444444 this gonna make it 14.50
  String _formatText(String text) {
    if (!text.contains('.')) return text;
    try {
      double number = double.parse(text);
      return number.toStringAsFixed(2);
    } catch (e) {
      return text;
    }
  }

  // void setDataAndListProduct({
  //   required BuildContext context,
  //   required ReopenState state,
  //   required int index,
  // }) {
  //   listProduct = [];
  //   for (var order in state.reOpenModel[index].orders!) {
  //     listProduct.addAll(order.products as Iterable<OldProducts>);
  //   }

  //   Iterable<TablesModel> table = context
  //       .read<BranchCubit>()
  //       .branchModel!
  //       .tables!
  //       .where((element) => element.sId == state.reOpenModel[index].table);
  //   data = [
  //     state.reOpenModel[index].checkNo.toString(),
  //     table.isNotEmpty
  //         ? '${context.read<BranchCubit>().branchModel!.sections!.where((element) => element.sId == table.first.section).first.title} ${table.first.title}'
  //         : "",
  //     state.reOpenModel[index].orderType.toString(),
  //     listProduct.length.toString(),
  //     state.reOpenModel[index].payments!
  //         .fold<double>(
  //             0,
  //             (previousValue, payment) =>
  //                 payment.type == 2 ? previousValue + payment.amount! : previousValue)
  //         .toString(),
  //     state.reOpenModel[index].payments!
  //         .fold<double>(
  //             0,
  //             (previousValue, payment) =>
  //                 payment.type != 2 ? payment.amount! + previousValue : previousValue)
  //         .toString(),
  //     state.reOpenModel[index].payments!
  //         .fold<double>(0, (previousValue, payment) => previousValue + payment.amount!)
  //         .toString(),
  //     "${state.reOpenModel[index].user!.name} ${state.reOpenModel[index].user!.lastname}",
  //     state.reOpenModel[index].payments!.isNotEmpty
  //         ? DateFormat("dd-MM-yyyy HH:mm")
  //             .format(state.reOpenModel[index].payments!.last.createdAt!.toLocal())
  //         : DateFormat("dd-MM-yyyy HH:mm").format(state.reOpenModel[index].createdAt!.toLocal())
  //   ];
  // }

  // void onSelectOrder({
  //   required BuildContext context,
  //   required OldCheckModel model,
  // }) {
  //   Iterable<TablesModel> table = context
  //       .read<BranchCubit>()
  //       .branchModel!
  //       .tables!
  //       .where((element) => element.sId == model.table);
  //   if (table.isNotEmpty) {
  //     APosLogger.instance!.warning(' listProduct.length.: ', listProduct.length.toString());
  //     context.read<ReopenCubit>().setSelectedOrder(
  //         id: model.sId.toString(),
  //         listProduct: listProduct,
  //         table:
  //             '${context.read<BranchCubit>().branchModel!.sections!.where((element) => element.sId == table.first.section).first.title} ${table.first.title}');
  //   }

  //   APosLogger.instance!.warning('REOPENmodel SELECTED ORDER : ',
  //       context.read<ReopenCubit>().selectOrder!.item.length.toString());
  //   for (var ele in context.read<ReopenCubit>().selectOrder!.item) {
  //     APosLogger.instance!.warning('REOPENmodel SELECTED ORDER : ', ele.price.toString());
  //   }
  // }
}
