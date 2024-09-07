import 'dart:async';

import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/service/global_service.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/utils/helper/timer_convert.dart';
import 'package:flutter/material.dart';

class TopMainInfo extends StatefulWidget {
  const TopMainInfo({super.key});

  @override
  State<TopMainInfo> createState() => _TopMainInfoState();
}

class _TopMainInfoState extends State<TopMainInfo> with _TopMainInfoMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(.14),
      color: context.colorScheme.onSurface,
      margin: const AppPadding.extraMinAll(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _EachInfoRow(
              leftText: "Date:",
              rightText:
                  '${_currentDateTime.day}/${_currentDateTime.month}/${_currentDateTime.year}'),
          _EachInfoRow(
            leftText: "Time:",
            rightText:
                '${TimerConvert().formatNumber(_currentDateTime.hour)}:${TimerConvert().formatNumber(_currentDateTime.minute)}:${TimerConvert().formatNumber(_currentDateTime.second)}',
          ),
          _EachInfoRow(
            leftText: "User:",
            rightText: '${GlobalService.user.name} ${GlobalService.user.lastName}',
          )
        ],
      ),
    );
  }
}

class _EachInfoRow extends StatelessWidget {
  const _EachInfoRow({
    required String leftText,
    required String rightText,
  })  : _leftText = leftText,
        _rightText = rightText;

  final String _leftText;
  final String _rightText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidth(.18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: context.dynamicWidth(.06),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: const AlignmentDirectional(0, 0),
                child: Text(
                  _leftText,
                  style: CustomFontStyle.generalTextStyle.copyWith(
                      color: context.colorScheme.onSecondary,
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                ),
              )),
          SizedBox(
              width: context.dynamicWidth(.1),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: const AlignmentDirectional(0, 0),
                child: Text(
                  _rightText,
                  style: CustomFontStyle.generalTextStyle
                      .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }
}

mixin _TopMainInfoMixin on State<TopMainInfo> {
  late DateTime _currentDateTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentDateTime = DateTime.now();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        _currentDateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
