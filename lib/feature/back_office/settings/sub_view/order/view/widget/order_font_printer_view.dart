import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class OrderFontPrinterView extends StatefulWidget {
  const OrderFontPrinterView({super.key});

  @override
  State<OrderFontPrinterView> createState() => _OrderFontPrinterViewState();
}

class _OrderFontPrinterViewState extends State<OrderFontPrinterView>
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
    tabController = TabController(length: 11, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Column(
          children: [
            _TabsMenuTitles(tabController: tabController),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  orderStarPrinter(),
                  orderOtherPrinter(),
                ],
              ),
            ),
          ],
        ));
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
            .copyWith(fontWeight: FontWeight.w200, fontSize: 18),
        unselectedLabelColor: Colors.black,
        tabs: const [
          Tab(text: 'Order Font Of Star Printer'),
          Tab(text: 'Order Font Of Other Printers'),
        ],
      ),
    );
  }
}

class orderStarPrinter extends StatefulWidget {
  const orderStarPrinter({super.key});

  @override
  State<orderStarPrinter> createState() => _orderStarPrinterState();
}

class _orderStarPrinterState extends State<orderStarPrinter> {
  int _selectedTitle = 1;
  int _selectedSubTitle = 1;
  int _selectedItem = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flexible(
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Title',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Small',
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Radio<int>(
                      value: 1,
                      groupValue: _selectedTitle,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedTitle = value!;
                        });
                      },
                      fillColor: WidgetStateProperty.all(
                          Colors.black), // Radio yuvarlağı siyah
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Medium',
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Radio<int>(
                      value: 2,
                      groupValue: _selectedTitle,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedTitle = value!;
                        });
                      },
                      fillColor: WidgetStateProperty.all(
                          Colors.black), // Radio yuvarlağı siyah
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Large',
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Radio<int>(
                      value: 3,
                      groupValue: _selectedTitle,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedTitle = value!;
                        });
                      },
                      fillColor: WidgetStateProperty.all(
                          Colors.black), // Radio yuvarlağı siyah
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Sub Title',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Small',
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Radio<int>(
                      value: 1,
                      groupValue: _selectedSubTitle,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedSubTitle = value!;
                        });
                      },
                      fillColor: WidgetStateProperty.all(
                          Colors.black), // Radio yuvarlağı siyah
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Medium',
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Radio<int>(
                      value: 2,
                      groupValue: _selectedSubTitle,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedSubTitle = value!;
                        });
                      },
                      fillColor: WidgetStateProperty.all(
                          Colors.black), // Radio yuvarlağı siyah
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Large',
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Radio<int>(
                      value: 3,
                      groupValue: _selectedSubTitle,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedSubTitle = value!;
                        });
                      },
                      fillColor: WidgetStateProperty.all(
                          Colors.black), // Radio yuvarlağı siyah
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Item',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Small',
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Radio<int>(
                      value: 1,
                      groupValue: _selectedItem,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedItem = value!;
                        });
                      },
                      fillColor: WidgetStateProperty.all(
                          Colors.black), // Radio yuvarlağı siyah
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Medium',
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Radio<int>(
                      value: 2,
                      groupValue: _selectedItem,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedItem = value!;
                        });
                      },
                      fillColor: WidgetStateProperty.all(
                          Colors.black), // Radio yuvarlağı siyah
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Large',
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Radio<int>(
                      value: 3,
                      groupValue: _selectedItem,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedItem = value!;
                        });
                      },
                      fillColor: WidgetStateProperty.all(
                          Colors.black), // Radio yuvarlağı siyah
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Happy Hour tabı
class orderOtherPrinter extends StatefulWidget {
  const orderOtherPrinter({super.key});

  @override
  State<orderOtherPrinter> createState() => _orderOtherPrinterState();
}

class _orderOtherPrinterState extends State<orderOtherPrinter> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Flexible(
            child: Row(
              children: [],
            ),
          ),
          SizedBox(height: 8),
          Flexible(
            child: Row(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
