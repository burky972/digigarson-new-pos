import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/calendar/calendar_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InitialReportView extends StatelessWidget {
  const InitialReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              height: context.dynamicHeight(0.05),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Reports'.tr(),
                    style: CustomFontStyle.titlesTextStyle.copyWith(fontWeight: FontWeight.bold)),
              )),
          SizedBox(
            height: context.dynamicHeight(0.7),
            child: Row(
              children: [
                // Sidebar
                SizedBox(
                  width: 250,
                  child: ListView(
                    children: [
                      const ListTile(
                          title:
                              Text('Basic Reports', style: TextStyle(fontWeight: FontWeight.bold))),
                      const _LeftClickableReportTitle(title: 'Close Day/Shift', icon: Icons.people),
                      const _LeftClickableReportTitle(title: 'Sales Report', icon: Icons.bar_chart),
                      const _LeftClickableReportTitle(
                          title: 'Product', icon: Icons.shopping_basket),
                      const _LeftClickableReportTitle(title: 'Inventory', icon: Icons.inventory),
                      const _LeftClickableReportTitle(title: 'Void', icon: Icons.block),
                      const _LeftClickableReportTitle(title: 'Time Clock', icon: Icons.access_time),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Adv. Reports'),
                      ),
                    ],
                  ),
                ),
                // Calendar
                const Expanded(child: CalendarWidget()),
              ],
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(32),
            alignment: Alignment.centerRight,
            child: LightBlueButton(
                buttonText: LocaleKeys.exit.tr(), onTap: () => Navigator.pop(context)),
          )
        ],
      ),
    );
  }
}

class _LeftClickableReportTitle extends StatelessWidget {
  const _LeftClickableReportTitle({
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {},
    );
  }
}
