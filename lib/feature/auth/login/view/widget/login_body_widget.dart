import 'package:a_pos_flutter/feature/auth/login/cubit/login_cubit.dart';
import 'package:a_pos_flutter/feature/auth/login/cubit/login_state.dart';
import 'package:a_pos_flutter/feature/auth/login/mixin/login_mixin.dart';
import 'package:a_pos_flutter/feature/auth/login/view/widget/login_widget.dart';
import 'package:a_pos_flutter/gen/assets.gen.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/custom_button.dart';
import 'package:a_pos_flutter/product/widget/keyboard/custom_keyboard.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_password_textfield.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_textfield.dart';
import 'package:core/const/space.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBodyWidget extends StatefulWidget {
  const LoginBodyWidget({super.key});

  @override
  State<LoginBodyWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<LoginBodyWidget> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleFullScreen,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 64),
        child: Form(
          key: formKeyLogin,
          child: ListView(
            children: [
              const TopLogoWidget(),
              SizedBox(
                height: context.dynamicHeight(0.8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _LeftItemsWidget(timeString: timeString),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: context.colorScheme.primary,
                                borderRadius: BorderRadius.circular(12)),
                            padding: const AppPadding.xLargeAll(),
                            constraints: BoxConstraints(
                              minHeight: context.dynamicHeight(.5),
                              maxHeight: context.dynamicHeight(.8),
                            ),
                            child: Column(
                              children: [
                                /// Title text
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'FALCON DINNER',
                                    style: CustomFontStyle.titlesTextStyle.copyWith(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),

                                /// Branch id  textfield
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                      width: context.dynamicWidth(.2),
                                      child: Center(
                                        child: CustomTextField(
                                          hintText: LocaleKeys.BranchCode.tr(),
                                          fillColor: Colors.white,
                                          focusNode: branchCustomIdNode,
                                          textInputType: TextInputType.none,
                                          controller: branchCustomIdController,
                                          onTap: () {},
                                        ),
                                      )),
                                ),

                                /// Password textfield
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      width: context.dynamicWidth(.2),
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: Center(
                                        child: CustomPasswordTextField(
                                          hintTxt: LocaleKeys.Password.tr(),
                                          textInputAction: TextInputAction.done,
                                          focusNode: passNode,
                                          controller: passwordController,
                                          onTap: () {},
                                        ),
                                      )),
                                ),

                                /// Custom Keyboard field
                                Expanded(
                                  flex: 6,
                                  child: Center(
                                    child: Container(
                                      padding: const AppPadding.minAll(),
                                      child: CustomNumberKeyboard(
                                        onKeyPressed: (value) => onCustomKeyboardPressed(value),
                                        onClose: () {},
                                        isOnClose: false,
                                      ),
                                    ),
                                  ),
                                ),

                                /// Login Button
                                BlocConsumer<LoginCubit, LoginState>(
                                    listener: (context, state) async {
                                      if (state.states == LoginStates.error) {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content:
                                              const Text('Please check your username and password')
                                                  .tr(),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                      if (state.states == LoginStates.completed && mounted) {
                                        await route(state: state);
                                      }
                                    },
                                    listenWhen: (previous, current) =>
                                        previous.states != current.states &&
                                        current.states == LoginStates.completed,
                                    builder: (context, state) {
                                      return Expanded(
                                        flex: 2,
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 20, right: 20, bottom: 1, top: 30),
                                            child: state.isLoading
                                                ? Center(
                                                    child: CircularProgressIndicator(
                                                      valueColor: AlwaysStoppedAnimation<Color>(
                                                        context.colorScheme.surface,
                                                      ),
                                                    ),
                                                  )
                                                : CustomButton(
                                                    onTap: () async {
                                                      await loginUser(state);
                                                    },
                                                    buttonText: LocaleKeys.LOGIN.tr(),
                                                  )),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              /// Pencere modu
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 2, right: 2, top: 10),
                    constraints: const BoxConstraints(minHeight: 50, minWidth: 50),
                    child: CustomButton(
                      onTap: () => onWindowScreenSize(),
                      buttonText: LocaleKeys.min_screen.tr(),
                      heightBtn: 50,
                      paddingBtn: 10,
                      buttonColor: context.colorScheme.tertiary,
                      textColor: context.colorScheme.surface,
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// Kapat butonu
                  Container(
                    margin: const EdgeInsets.only(left: 2, right: 2, top: 10),
                    child: CustomButton(
                      onTap: () => onWindowClose(context),
                      buttonText: LocaleKeys.close.tr(),
                      paddingBtn: 10,
                      heightBtn: 50,
                      buttonColor: context.colorScheme.primary,
                      textColor: context.colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeftItemsWidget extends StatelessWidget {
  const _LeftItemsWidget({
    required this.timeString,
  });

  final String timeString;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: context.dynamicWidth(0.4),
            height: context.dynamicHeight(0.4),
            constraints: const BoxConstraints(minHeight: 200, maxHeight: 465),
            decoration: BoxDecoration(
                color: context.colorScheme.primary, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Assets.images.onBoarding.clock.image(
                  height: 250,
                  width: 250,
                  color: Colors.white,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.currentTime,
                      style: CustomFontStyle.titlesTextStyle
                          .copyWith(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    ).tr(),
                    kGap5,
                    Text(
                      timeString,
                      style: CustomFontStyle.titlesTextStyle
                          .copyWith(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          flex: 3,
          child: Center(
            child: Container(
                constraints: const BoxConstraints(minHeight: 250),
                child: Assets.images.onBoarding.onboardingImageTwo.image(
                  fit: BoxFit.scaleDown,
                )),
          ),
        ),
      ],
    );
  }
}
