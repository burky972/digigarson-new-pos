import 'package:a_pos_flutter/app.dart';
import 'package:a_pos_flutter/bootstrap.dart';
import 'package:a_pos_flutter/product/app/app_container_items.dart';

import 'package:core/language/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'bloc_provider_initialize_widget.dart';

Future<void> main() async {
  await bootstrap(
    () => const LocalizationWidget(),
  );
}

class LocalizationWidget extends StatelessWidget {
  const LocalizationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProviderInitializeWidget(
      child: EasyLocalization(
        supportedLocales: LanguageManager.supportedLocales,
        path: LanguageManager.instance!.localizationPath,
        useOnlyLangCode: true,
        child: const App(),
      ),
    );
  }
}
