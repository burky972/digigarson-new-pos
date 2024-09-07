import 'package:a_pos_flutter/feature/auth/login/view/login_view.dart';
import 'package:a_pos_flutter/feature/home/case/cubit/case_cubit.dart';
import 'package:a_pos_flutter/feature/home/case/model/case_model.dart';
import 'package:a_pos_flutter/feature/home/main/view/main_view.dart';
import 'package:a_pos_flutter/gen/assets.gen.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/service/global_service.dart';
import 'package:a_pos_flutter/product/widget/button/custom_button.dart';
import 'package:a_pos_flutter/product/widget/button/exit_button.dart';
import 'package:a_pos_flutter/product/widget/keyboard/custom_keyboard.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_textfield.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaseView extends StatefulWidget {
  const CaseView({super.key});

  @override
  State<CaseView> createState() => _CaseViewState();
}

class _CaseViewState extends State<CaseView> {
  OverlayEntry? _overlayEntry;
  late TextEditingController _startAmountController;
  final FocusNode _startAmountNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _startAmountController = TextEditingController();
    _startAmountController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  void toggleFullScreen() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  void _showCustomKeyboard(
      BuildContext context, TextEditingController controller, FocusNode focusNode) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 10,
        left: MediaQuery.of(context).size.width * .4,
        right: MediaQuery.of(context).size.width * .4,
        child: CustomNumberKeyboard(
          width: 150,
          onKeyPressed: (value) => onCustomKeyboardPressed(value),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  onCustomKeyboardPressed(String value) {
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(_startAmountNode);
    final oldSelection = _startAmountController.selection;
    final currentOffset = oldSelection.baseOffset;
    if (value.toString() == "clear") {
      if (currentOffset > 0) {
        _startAmountController.text = _startAmountController.text.substring(0, currentOffset - 1) +
            _startAmountController.text.substring(currentOffset);
        _startAmountController.selection = TextSelection.collapsed(offset: currentOffset - 1);
      }
    } else if (value.toString() == "allClear") {
      _startAmountController.text = "";
      _startAmountController.selection = const TextSelection.collapsed(offset: 0);
    } else {
      _startAmountController.text = _startAmountController.text.replaceRange(
        oldSelection.start,
        oldSelection.end,
        value,
      );
      _startAmountController.selection = TextSelection.collapsed(
        offset: oldSelection.baseOffset + value.length,
      );
    }
  }

  route(bool isRoute, String? token) async {
    if (isRoute) {
      if (token != null || token!.isNotEmpty) {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => const MainView()), (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          GestureDetector(
            onTap: toggleFullScreen,
            child: SizedBox(
              width: context.width,
              height: context.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: context.dynamicHeight(.4),
                    child: Center(child: Assets.icon.icLogo.image()),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .3,
                            child: CustomTextField(
                              onTap: () {
                                _showCustomKeyboard(
                                    context, _startAmountController, _startAmountNode);
                              },
                              hintText: 'Enter the initial amount',
                              textInputType: TextInputType.none,
                              focusNode: _startAmountNode,
                              controller: _startAmountController,
                            )),
                        Container(width: 5),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                          child: CustomButton(
                            buttonColor: context.colorScheme.surfaceTint,
                            onTap: () async {
                              final token = GlobalService.userModel.accessToken;
                              bool isPosted = await context.read<CaseCubit>().postCase(
                                    balanceModel: BalanceModel(
                                      amount: double.parse(_startAmountController.text),
                                      currency: 'USD',
                                      type: 2,
                                    ),
                                  );
                              appLogger.info('CASE VIEW', 'token: $token , isPosted: $isPosted');
                              if (isPosted) {
                                if (token != null || token!.isNotEmpty) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (_) => const MainView()),
                                      (route) => false);
                                }
                              }
                            },
                            buttonText: LocaleKeys.LOGIN.tr(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 16.0,
              right: 16.0,
              child: ExitButton(
                onPressed: () {
                  _overlayEntry?.remove();
                  _overlayEntry = null;
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_) => const LoginView()), (route) => false);
                },
                buttonColor: context.colorScheme.error,
              )),
        ],
      ),
    );
  }
}
