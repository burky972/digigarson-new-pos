import 'package:a_pos_flutter/feature/home/table/widget/table_header_widget.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TableView extends StatefulWidget {
  const TableView({super.key});

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> with _TableMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: toggleFullScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60,
              width: context.width,
              child: const TableHeaderWidget(),
            ),
            SizedBox(
              height: context.height - 60,
              child: const Row(
                children: [
                  // SizedBox(
                  //   width: context.dynamicWidth(.38),
                  //   height: context.height - 60,
                  //   child: TableLeftWidget(
                  //     tableModel: widget.tableModel,
                  //   ),
                  // ),
                  // SizedBox(
                  //     width: context.dynamicWidth(.62),
                  //     height: context.height - 60,
                  //     child: TableRightWidget())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

mixin _TableMixin on State<TableView> {
  bool isFullScreen = false;
  void toggleFullScreen() {
    setState(() {
      isFullScreen = !isFullScreen;
      isFullScreen ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive) : null;
    });
  }
}
