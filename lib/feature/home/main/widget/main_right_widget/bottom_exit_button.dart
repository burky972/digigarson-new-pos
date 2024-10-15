import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/routes/route_constants.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/custom_yes_no_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainRightBottomExitButton extends StatelessWidget {
  const MainRightBottomExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(.08),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text(LocaleKeys.sureWannaCloseWindow).tr(),
                actions: [
                  CustomNoButton(
                    onPressed: () => routeManager.pop(),
                  ),
                  CustomYesButton(
                    onPressed: () => routeManager.go(RouteConstants.login),
                  )
                ],
              );
            },
          );
        },
        child: Container(
          width: context.dynamicWidth(.15),
          decoration: BoxDecoration(
              color: context.colorScheme.onSurface,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              border: BorderConstants.borderAllSmall),
          child: Center(
            child: Text(
              LocaleKeys.exit,
              style: CustomFontStyle.buttonTextStyle.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
            ).tr(),
          ),
        ),
      ),
    );
  }
}
