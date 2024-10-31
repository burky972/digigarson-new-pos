import 'package:a_pos_flutter/feature/home/checks/cubit/check_cubit.dart';
import 'package:a_pos_flutter/feature/home/checks/cubit/check_state.dart';
import 'package:a_pos_flutter/feature/home/checks/model/re_open_model.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/date_time_format/date_time_format.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckLeftWidget extends StatefulWidget {
  const CheckLeftWidget({super.key});

  @override
  State<CheckLeftWidget> createState() => _ReOpenLeftWidgetState();
}

class _ReOpenLeftWidgetState extends State<CheckLeftWidget> with ReOpenLeftMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const AppPadding(),
      decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
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
                      padding: const AppPadding.lowHorizontal(),
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
            child: BlocBuilder<CheckCubit, CheckState>(
              builder: (context, state) {
                return ListView(
                  children: List.generate(
                    state.checkModelList?.length ?? 0,
                    (index) {
                      List<String> data = [
                        state.checkModelList?[index].checkNo.toString() ?? '-',
                        state.checkModelList![index].table?.title.toString() ?? '-',
                        state.checkModelList![index].orderType.toString(),
                        state.checkModelList![index].totalProducts.toString(),
                        '${(double.parse(state.checkModelList![index].totalPrice.toString()) + double.parse(state.checkModelList![index].totalTax.toString()))}',
                        state.checkModelList![index].user?.name.toString() ?? '',

                        //TODO: check closed time
                        state.checkModelList![index].createdAt!.toLocal().toFormattedString()
                      ];

                      return InkWell(
                        onTap: () async {
                          await context
                              .read<CheckCubit>()
                              .getSingleCheck(checkId: state.checkModelList![index].id.toString());
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          color: state.selectedCheck?.id == state.checkModelList![index].id
                              ? context.colorScheme.primary
                              : Colors.white,
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

mixin ReOpenLeftMixin on State<CheckLeftWidget> {
  final List<ReOpenModel> headTitle = [
    const ReOpenModel(text: 'No', width: 0.06),
    const ReOpenModel(text: 'Table Name', width: 0.07),
    const ReOpenModel(text: 'Gst', width: 0.04),
    const ReOpenModel(text: 'Items', width: 0.06),
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
}
