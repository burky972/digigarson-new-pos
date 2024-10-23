import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/product_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/model/product_model.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/widget/select_date_widget.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/table_cell/table_cell_widget.dart';
import 'package:a_pos_flutter/product/widget/text/from_to_title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../widget/left_table_widget.dart';
part '../widget/right_table_widget.dart';
part '../widget/bottom_date_and_button_widgets.dart';

class TimeClockView extends StatelessWidget {
  const TimeClockView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController endDateController = TextEditingController();
    return Scaffold(
        body: ListView(padding: const AppPadding.minAll(), children: [
      const Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text('Time Clock', style: CustomFontStyle.titleBoldTertiaryStyle),
      ),
      const Row(
        children: [
          _LeftTableWidget(),
          _RightTableWidget(),
        ],
      ),
      SizedBox(
        height: context.dynamicHeight(0.05),
      ),
      _BottomDateAndButtonWidgets(
        startDateController: startDateController,
        endDateController: endDateController,
      )
    ]));
  }
}
