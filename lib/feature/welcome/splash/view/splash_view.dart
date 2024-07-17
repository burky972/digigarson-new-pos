import 'dart:async';
import 'package:a_pos_flutter/feature/auth/login/view/login_view.dart';
import 'package:a_pos_flutter/feature/welcome/splash/view/widget/splas_painter.dart';
import 'package:a_pos_flutter/gen/assets.gen.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SplashMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: context.dynamicWidth(1),
          height: context.dynamicHeight(1),
          color: context.colorScheme.primary,
          child: CustomPaint(
            painter: SplashPainter(),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.icon.icLogo.image(
                height: 250.0,
                fit: BoxFit.scaleDown,
                width: 250.0,
                color: Theme.of(context).cardColor,
              )
            ],
          ),
        ),
      ],
    ));
  }
}

mixin SplashMixin on State<SplashView> {
  late StreamSubscription<List<ConnectivityResult>> _onConnectivityChanged;
  bool _firstTime = true;

  @override
  void initState() {
    super.initState();

    _onConnectivityChanged =
        Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (!_firstTime) {
        bool isNotConnected = results.every(
            (result) => result != ConnectivityResult.wifi && result != ConnectivityResult.mobile);
        isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? LocaleKeys.no_connection : LocaleKeys.connected,
            textAlign: TextAlign.center,
          ).tr(),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });
    _route();
  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  void _route() {
    Timer(const Duration(seconds: 1), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const LoginView()));
    });
  }
}
