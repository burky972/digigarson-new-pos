import 'dart:async';
import 'package:a_pos_flutter/feature/welcome/splash/view/widget/splas_painter.dart';
import 'package:a_pos_flutter/gen/assets.gen.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/routes/route_constants.dart';
import 'package:a_pos_flutter/product/widget/custom_snackbar.dart';
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
        if (isNotConnected) {
          const SizedBox();
        } else {
          if (!mounted) return;
          CustomSnackBar.show(
            context: context,
            message: isNotConnected ? LocaleKeys.no_connection.tr() : LocaleKeys.connected.tr(),
            type: isNotConnected ? SnackBarType.error : SnackBarType.success,
            duration: Duration(seconds: isNotConnected ? 6000 : 3),
          );
        }

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
      routeManager.go(RouteConstants.login);
    });
  }
}
