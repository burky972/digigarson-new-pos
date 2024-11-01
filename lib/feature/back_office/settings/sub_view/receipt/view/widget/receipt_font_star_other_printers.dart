import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class ReceiptFontStarOtherPrinters extends StatefulWidget {
  const ReceiptFontStarOtherPrinters({super.key});

  @override
  State<ReceiptFontStarOtherPrinters> createState() =>
      _ReceiptFontStarOtherPrintersState();
}

class _ReceiptFontStarOtherPrintersState
    extends State<ReceiptFontStarOtherPrinters>
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
                  receiptStarPrinter(),
                  receiptOtherPrinter(),
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

class receiptStarPrinter extends StatefulWidget {
  const receiptStarPrinter({super.key});

  @override
  State<receiptStarPrinter> createState() => _receiptStarPrinterState();
}

class _receiptStarPrinterState extends State<receiptStarPrinter> {
  int _selectedTitle = 1;
  int _selectedSubTitle = 1;
  int _selectedItem = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                        Colors.black),
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
                        Colors.black),
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
                        Colors.black),
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
                        Colors.black),
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
                        Colors.black),
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
                        Colors.black),
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
                        Colors.black),
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
                        Colors.black),
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
                        Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Happy Hour tabı
class receiptOtherPrinter extends StatefulWidget {
  const receiptOtherPrinter({super.key});

  @override
  State<receiptOtherPrinter> createState() => _receiptOtherPrinterState();
}

class _receiptOtherPrinterState extends State<receiptOtherPrinter> {
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