import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/widget/category_list_widget.dart';
import 'package:a_pos_flutter/feature/home/table/widget/table_button_widget.dart';
import 'package:a_pos_flutter/product/enums/button_action/button_action_enum.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:flutter/material.dart';
import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
import 'package:a_pos_flutter/feature/home/branch/cubit/branch_state.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/model/branch/branch_model.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'product_list_widget.dart';

class TableRightWidget extends StatefulWidget {
  const TableRightWidget({super.key});

  @override
  State<TableRightWidget> createState() => _TableRightWidgetState();
}

class _TableRightWidgetState extends State<TableRightWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .62,
          height: MediaQuery.of(context).size.height - (80 * heightCal()) - 60,
          child: const _ProductListWidget(),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .62,
          height: 79 * heightCal(),
          child: const CategoryListWidget(),
        ),
      ],
    );
  }

  double heightCal() {
    int categoryLength = context.read<CategoryCubit>().getAllCategories.length;
    int rowCategoryLength = (MediaQuery.of(context).size.width * .62 / 170).floor();
    if (categoryLength > rowCategoryLength) {
      int cal = (categoryLength / rowCategoryLength).ceil();
      if (cal == 2) {
        return 2;
      } else {
        return 3;
      }
    } else {
      return 1;
    }
  }
}
