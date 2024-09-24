import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/enums/service_type/enum.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/model/service_fee/service_fee_request_model.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/utils/helper/service_fee_type_converter.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/keyboard/custom_keyboard.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceFeeDialog {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _amountController = TextEditingController();
  OverlayEntry? _overlayEntry;
  final FocusNode _amountNode = FocusNode();
  int type = 1;
  int title = 1;

  void showCustomNumberKeyKeyboard(
      BuildContext context, TextEditingController controller, FocusNode focusNode) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 30,
        left: (context.width - 280) / 2,
        right: (context.width - 280) / 2,
        child: Material(
          elevation: 4.0,
          child: CustomNumberKeyboard(
            onKeyPressed: (String value) {
              if (value == 'clear') {
                if (controller.text.isNotEmpty) {
                  controller.text = controller.text.substring(0, controller.text.length - 1);
                }
              } else if (value == 'allClear') {
                controller.clear();
              } else {
                controller.text += value;
              }
              controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length),
              );
            },
            onClose: () {
              _overlayEntry?.remove();
              _overlayEntry = null;
            },
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void toggleFullScreen() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  void showServiceDialog(BuildContext context, {int? index}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          onPopInvoked: (bool didPop) {
            if (didPop) {
              toggleFullScreen();
              return;
            }
          },
          child: StatefulBuilder(builder: (context, setState) {
            return BlocBuilder<TableCubit, TableState>(
              builder: (context, state) {
                return AlertDialog(
                  title: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            title = ServiceFeeType.AMOUNT.value;
                          });
                        },
                        child: Text(
                          LocaleKeys.serviceFeeAdd.tr(),
                          style: TextStyle(
                            fontSize: 17,
                            color: title == ServiceFeeType.AMOUNT.value
                                ? Colors.green.shade700
                                : context.colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text("|", style: CustomFontStyle.popupNotificationTextStyle),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          setState(() {
                            title = ServiceFeeType.PERCENT.value;
                          });
                        },
                        child: Text(
                          LocaleKeys.serviceFeeShow.tr(),
                          style: TextStyle(
                            fontSize: 17,
                            color: title == ServiceFeeType.PERCENT.value
                                ? Colors.green.shade700
                                : context.colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  content: Container(
                      width: context.dynamicWidth(.5),
                      constraints: BoxConstraints(
                        minWidth: 400,
                        maxWidth: 500,
                        maxHeight: title == ServiceFeeType.AMOUNT.value ? 100 : 230,
                      ),
                      child: title == ServiceFeeType.AMOUNT.value
                          ? ListView(
                              children: [
                                type == ServiceFeeType.PERCENT.value
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              postService(context, state, 2.5);
                                            },
                                            style: ElevatedButton.styleFrom(),
                                            child: const Text('%2.5'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              postService(context, state, 5);
                                            },
                                            child: const Text('%5'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              postService(context, state, 7.5);
                                            },
                                            child: const Text('%7.5'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              postService(context, state, 10);
                                            },
                                            child: const Text('%10'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              postService(context, state, 20);
                                            },
                                            child: const Text('%20'),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    /// amount textfield
                                    Container(
                                      width: context.dynamicWidth(.1),
                                      constraints:
                                          const BoxConstraints(minWidth: 100, maxWidth: 150),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          border: BorderConstants.borderAllSmall),
                                      child: TextField(
                                        onTap: () {
                                          showCustomNumberKeyKeyboard(
                                              context, _amountController, _amountNode);
                                        },
                                        controller: _amountController,
                                        focusNode: _amountNode,
                                        keyboardType: TextInputType.none,
                                        decoration: const InputDecoration(
                                            hintText: 'Amount...',
                                            contentPadding: AppPadding.minAll()),
                                      ),
                                    ),
                                    const SizedBox(width: 5),

                                    /// percent / amount buttons

                                    Padding(
                                      padding: const AppPadding.extraMinAll(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _PercentButton(
                                              onPressed: () {
                                                setState(() {
                                                  type = ServiceFeeType.PERCENT.value;
                                                });
                                              },
                                              type: type),
                                          const SizedBox(width: 5),
                                          _AmountButton(
                                              onPressed: () {
                                                setState(() {
                                                  type = ServiceFeeType.AMOUNT.value;
                                                });
                                              },
                                              type: type),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          : Scrollbar(
                              thumbVisibility: true,
                              trackVisibility: true,
                              thickness: 10,
                              controller: _scrollController,
                              child: ListView.separated(
                                controller: _scrollController,
                                itemCount: state.selectedTable!.serviceFee.length,
                                separatorBuilder: (BuildContext context, int index) =>
                                    const Padding(
                                  padding: EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Divider(),
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                    child: ListTile(
                                      title: Text(
                                          'Amount: ${state.selectedTable!.serviceFee[index].amount!.toStringAsFixed(2)}, Percentile: ${state.selectedTable!.serviceFee[index].percentile!.toStringAsFixed(2)}'),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () async {
                                          await deleteService(context,
                                              state.selectedTable!.serviceFee[index].id.toString());
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )),
                  actions: <Widget>[
                    title == ServiceFeeType.AMOUNT.value
                        ? LightBlueButton(
                            buttonText: LocaleKeys.save.tr(),
                            onTap: () {
                              try {
                                postService(context, state, double.parse(_amountController.text));
                              } catch (e) {}
                            },
                          )
                        : const SizedBox(),
                    LightBlueButton(
                      buttonText: LocaleKeys.close.tr(),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                );
              },
            );
          }),
        );
      },
    );
  }

  Future<void> postService(BuildContext context, TableState state, double amount) async {
    appLogger.error('SELECTED TABLE: ', '${state.selectedTable == null}');
    if (amount > 0 && state.selectedTable != null) {
      String savedType = ServiceFeeTypeConverter.getStringType(type);
      appLogger.warning("TAG", ':amount$amount - type: $savedType');

      try {
        bool return_ = await context.read<TableCubit>().postServiceFee(
              serviceFeeRequestModel: ServiceFeeRequestModel(
                amount: amount.toInt(),
                type: savedType,
              ),
            );

        if (return_) {
          await showOrderSuccessDialog(context, LocaleKeys.serviceFeeCreated.tr(),
              secondClose: true);
        } else {
          await showOrderErrorDialog(context, LocaleKeys.serviceFeeNotCreated.tr());
        }
      } catch (e) {
        print('Error in postService: $e');
        await showOrderErrorDialog(context, LocaleKeys.serviceFeeNotCreated.tr());
      }
    } else {
      showOrderErrorNotProductDialog(context, LocaleKeys.enterValidValue.tr());
    }
    toggleFullScreen();
  }

  Future<void> deleteService(BuildContext context, String serviceId) async {
    bool return_ = await context.read<TableCubit>().deleteServiceFee(
          serviceId: serviceId,
        );
    if (return_) {
      await showOrderSuccessDialog(context, LocaleKeys.serviceFeeDeleted.tr(), secondClose: true);
    } else {
      await showOrderErrorDialog(context, LocaleKeys.serviceFeeNotDeleted.tr());
    }
    toggleFullScreen();
  }
}

class _AmountButton extends StatelessWidget {
  const _AmountButton({required VoidCallback onPressed, required int type})
      : _onPressed = onPressed,
        _type = type;
  final VoidCallback _onPressed;
  final int _type;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(_type == ServiceFeeType.AMOUNT.value
            ? Colors.green.shade300
            : context.colorScheme.surfaceTint),
      ),
      child: Text(
        LocaleKeys.Fractional,
        style: CustomFontStyle.titlesTextStyle.copyWith(
            color: context.colorScheme.tertiary, fontWeight: FontWeight.bold, fontSize: 20),
      ).tr(),
    );
  }
}

class _PercentButton extends StatelessWidget {
  const _PercentButton({required VoidCallback onPressed, required int type})
      : _onPressed = onPressed,
        _type = type;
  final VoidCallback _onPressed;
  final int _type;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(_type == ServiceFeeType.PERCENT.value
            ? Colors.green.shade300
            : context.colorScheme.surfaceTint),
      ),
      child: Text(
        LocaleKeys.Percentage,
        style: CustomFontStyle.titlesTextStyle.copyWith(
            color: context.colorScheme.tertiary, fontWeight: FontWeight.bold, fontSize: 20),
      ).tr(),
    );
  }
}
