import 'package:a_pos_flutter/feature/home/reopen/view/widget/re_open_left_widget.dart';
import 'package:a_pos_flutter/feature/home/reopen/view/widget/re_open_right_widget.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:flutter/material.dart';

class ReOpenView extends StatelessWidget {
  const ReOpenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Row(
              children: [
                SizedBox(
                  height: context.dynamicHeight(1),
                  width: context.dynamicWidth(.7),
                  child: const ReOpenLeftWidget(),
                ),
                Container(
                    height: context.dynamicHeight(1),
                    width: context.dynamicWidth(.3),
                    color: Colors.black12,
                    child: const ReOpenRightWidget())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
