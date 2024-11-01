import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class LunchHappyHourView extends StatefulWidget {
  const LunchHappyHourView({super.key});

  @override
  State<LunchHappyHourView> createState() => _LunchHappyHourViewState();
}

class _LunchHappyHourViewState extends State<LunchHappyHourView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Flexible(
        child: Column(
          children: [
            _TabsMenuTitles(tabController: tabController),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  lunchHour(),
                  happyHour(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabsMenuTitles extends StatelessWidget {
  const _TabsMenuTitles({
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: context.dynamicWidth(0.3),
      child: TabBar(
        controller: _tabController,
        labelColor: context.colorScheme.tertiary,
        labelStyle: CustomFontStyle.menuTextStyle
            .copyWith(fontWeight: FontWeight.w200, fontSize: 16),
        unselectedLabelColor: Colors.black,
        tabs: const [
          Tab(text: 'Lunch Hour'),
          Tab(text: 'Happy Hour'),
        ],
      ),
    );
  }
}

// Lunch Hour tabı
class lunchHour extends StatelessWidget {
  const lunchHour({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Flexible(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Lunch Hour Enabled'),
                const SizedBox(width: 8),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Dine-In'),
                const SizedBox(width: 8),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Bar'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Take Out/Pick Up'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Delivery'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Quick Service'),
                
              ],
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Mondays'),
                const SizedBox(width: 8),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Tuesday'),
                const SizedBox(width: 8),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Wednesday'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Thursday'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Friday'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Saturday'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Sunday'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Happy Hour tabı
class happyHour extends StatelessWidget {
  const happyHour({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Flexible(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Lunch Hour Enabled'),
                const SizedBox(width: 8),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Dine-In'),
                const SizedBox(width: 8),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Bar'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Take Out/Pick Up'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Delivery'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Quick Service'),
                
              ],
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Mondays'),
                const SizedBox(width: 8),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Tuesday'),
                const SizedBox(width: 8),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Wednesday'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Thursday'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Friday'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Saturday'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(width: 8),
                const Text('Sunday'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
