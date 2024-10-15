import 'package:a_pos_flutter/product/routes/go_routes.dart';
import 'package:a_pos_flutter/product/theme/custom_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: APosTheme,
      routerConfig: AppRoute.router,
    );
  }
}
