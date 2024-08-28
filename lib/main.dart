import 'package:a_pos_flutter/app.dart';
import 'package:a_pos_flutter/bootstrap.dart';
import 'package:a_pos_flutter/feature/auth/token/cubit/token_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/restaurant/cubit/restaurant_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_cubit.dart';
import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
import 'package:a_pos_flutter/feature/home/case/cubit/case_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/cubit/note_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/cubit/option_cubit.dart';
import 'package:a_pos_flutter/feature/home/order/cubit/order_cubit.dart';
import 'package:a_pos_flutter/feature/home/printer/cubit/printer_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/product_cubit.dart';
import 'package:a_pos_flutter/feature/home/reopen/cubit/reopen_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/product/global/cubit/global_cubit.dart';
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
