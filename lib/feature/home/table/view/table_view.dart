import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/widget/table_header_widget.dart';
import 'package:a_pos_flutter/feature/home/table/widget/table_left_widget.dart';
import 'package:a_pos_flutter/feature/home/table/widget/table_right_widget.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              child: Row(
                children: [
                  BlocBuilder<TableCubit, TableState>(
                    buildWhen: (previous, current) =>
                        previous.newOrderProducts.length != current.newOrderProducts.length,
                    builder: (context, state) {
                      return SizedBox(
                        width: context.dynamicWidth(.38),
                        height: context.height - 60,
                        child: TableLeftWidget(
                          tableModel: state.selectedTable!,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                      width: context.dynamicWidth(.62),
                      height: context.height - 60,
                      child: const TableRightWidget())
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

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().setSelectedCategory(null);
  }
}
