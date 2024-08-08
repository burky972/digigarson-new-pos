import 'dart:async';
import 'dart:io';

import 'package:a_pos_flutter/feature/auth/login/cubit/login_cubit.dart';
import 'package:a_pos_flutter/feature/auth/login/cubit/login_state.dart';
import 'package:a_pos_flutter/feature/auth/login/model/login_model.dart';
import 'package:a_pos_flutter/feature/auth/login/view/widget/login_body_widget.dart';
import 'package:a_pos_flutter/feature/home/case/cubit/case_cubit.dart';
import 'package:a_pos_flutter/feature/home/case/view/case_view.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/home/main/view/main_view.dart';

import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/product_cubit.dart';
import 'package:a_pos_flutter/feature/home/reopen/cubit/reopen_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/global/cubit/global_cubit.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/utils/helper/network_info.dart';
import 'package:a_pos_flutter/product/utils/helper/timer_convert.dart';
import 'package:a_pos_flutter/product/widget/button/custom_yes_no_button.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

mixin LoginMixin on State<LoginBodyWidget> {
  late TextEditingController passwordController;
  late TextEditingController branchCustomIdController;
  late GlobalKey<FormState> formKeyLogin;
  final FocusNode passNode = FocusNode();
  LoginModel loginModel = LoginModel();
  final FocusNode branchCustomIdNode = FocusNode();
  String timeString = '';
  late Timer timer;
  bool isFullScreen = false;
  String _getTimeString() {
    DateTime now = DateTime.now();
    return '${TimerConvert().formatNumber(now.hour)}:${TimerConvert().formatNumber(now.minute)}:${TimerConvert().formatNumber(now.second)}';
  }

  @override
  void initState() {
    APosLogger.instance!.info('SignIn', 'Sign in widget initState run!');

    super.initState();
    formKeyLogin = GlobalKey<FormState>();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);

    load();

    branchCustomIdController = TextEditingController();
    passwordController = TextEditingController();
    _updateTime();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
    NetworkInfo().listen(context); // listen for network change
    branchCustomIdController.text = context.read<LoginCubit>().getUserEmail();
  }

  @override
  void dispose() {
    branchCustomIdController.dispose();
    passwordController.dispose();
    timer.cancel();
    super.dispose();
  }

  Future<void> load() async {
    try {
      final serverSocket = await ServerSocket.bind(InternetAddress.anyIPv4, 12345);

      await for (var socket in serverSocket) {
        socket.listen(
          (List<int> data) {
            final message = String.fromCharCodes(data);
            APosLogger.instance!.info('load func SignIn Widget', message);
          },
          onError: (error) {
            APosLogger.instance!.error('load func SignIn Widget', 'Hata: $error');
            socket.destroy();
          },
          onDone: () {
            APosLogger.instance!.error('load func SignIn Widget', 'Bağlantı: kesildi ');
          },
          cancelOnError: true,
        );
      }
    } catch (e) {
      APosLogger.instance!.error('load func SignIn Widget', 'Sunucu başlatılamadı: $e');
    }
  }

  onWindowScreenSize() async {
    bool isPreventClose = await windowManager.isFullScreen();
    if (isPreventClose) {
      await windowManager.setFullScreen(false);
    } else {
      await windowManager.setFullScreen(true);
    }
  }

  void toggleFullScreen() {
    setState(() {
      isFullScreen = !isFullScreen;
      isFullScreen ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive) : null;
    });
  }

  void _updateTime() {
    if (mounted) {
      setState(() {
        timeString = _getTimeString();
      });
    }
  }

  Future loginUser(LoginState state) async {
    if (formKeyLogin.currentState!.validate()) {
      formKeyLogin.currentState!.save();
      String branchCustomId = branchCustomIdController.text.trim();
      String password = passwordController.text.trim();
      if (branchCustomId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(LocaleKeys.EMAIL_MUST_BE_REQUIRED).tr(),
          backgroundColor: Colors.red,
        ));
      } else if (password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(LocaleKeys.PASSWORD_MUST_BE_REQUIRED).tr(),
          backgroundColor: Colors.red,
        ));
      } else {
        context.read<LoginCubit>().saveUserEmail(branchCustomId);
        await context
            .read<LoginCubit>()
            .login(LoginModel(branch_custom_id: branchCustomId, password: password));
      }
    }
  }

  onWindowClose(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Are you sure you want to close this window?',
            style: CustomFontStyle.popupNotificationTextStyle,
          ),
          actions: [
            CustomNoButton(onPressed: () => Navigator.of(context).pop()),
            CustomYesButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await windowManager.destroy();
              },
            )
          ],
        );
      },
    );
  }

  onCustomKeyboardPressed(String value) {
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(passNode);
    final oldSelection = passwordController.selection;
    final currentOffset = oldSelection.baseOffset;
    if (value.toString() == "clear") {
      if (currentOffset > 0) {
        passwordController.text = passwordController.text.substring(0, currentOffset - 1) +
            passwordController.text.substring(currentOffset);
        passwordController.selection = TextSelection.collapsed(offset: currentOffset - 1);
      }
    } else if (value.toString() == "allClear") {
      passwordController.text = "";
      passwordController.selection = const TextSelection.collapsed(offset: 0);
    } else {
      passwordController.text = passwordController.text.replaceRange(
        oldSelection.start,
        oldSelection.end,
        value,
      );
      passwordController.selection = TextSelection.collapsed(
        offset: oldSelection.baseOffset + value.length,
      );
    }
  }

  Future<void> route({required LoginState state}) async {
    if (state.userModel == null || state.userModel!.accessToken == null) {
      // Navigator.pushAndRemoveUntil(//TODO: open this code later! also get datas from DB.
      //     context, MaterialPageRoute(builder: (_) => MainScreen()), (route) => false);
      return;
    }

    if (state.states == LoginStates.completed && state.userModel!.accessToken!.isNotEmpty) {
      List<int> permissions = state.userModel?.user?.role?.permissions ?? [];
      // if (permissions.contains(511) || permissions.contains(510)) {//TODO Check permissions LATER!
      if (permissions.contains(1) || permissions.contains(2)) {
        bool isOpenCase = await context.read<CaseCubit>().getOpenCase();
        await callNecessaryFunctions(isOpenCase, state);
      }
    }
  }

  Future<void> callNecessaryFunctions(bool isCaseOpened, LoginState state) async {
    await Future.wait([
      // context.read<BranchCubit>().getBranch(
      //     userModel: state.userModel!, languageModel: LanguageManager.supportedLocales.first),
      context.read<CategoryCubit>().getCategories(),
      context.read<ProductCubit>().getProducts(),
      //TODO: OPEN THIS CODE LATER!
      // context.read<NoteServePaymentCancelReasonCubit>().getALLFunctions(state.userModel!),
      context.read<ReopenCubit>().getAllCheck(
          userModel: state.userModel!, id: context.read<CaseCubit>().cases!.id.toString()),
      context.read<TableCubit>().getTable(state.userModel!),
    ]).then((_) {
      if (isCaseOpened) {
        context.read<GlobalCubit>().setUser(state.userModel!);
        context.read<LoginCubit>().updateIsLoading(false);
        //TODO: check HERE TO NAVIGATE AFTER CLICKING LOGIN BUTTON!
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => const MainView()), (route) => false);
      } else {
        context.read<LoginCubit>().updateIsLoading(false);
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => const CaseView()), (route) => false);
      }
    });
  }
}
