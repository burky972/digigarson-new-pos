import 'dart:async';

import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/utils/helper/timer_convert.dart';
import 'package:flutter/material.dart';

/// Get current time as a Text
class CurrentTimeWidget extends StatefulWidget {
  const CurrentTimeWidget({super.key});

  @override
  State<CurrentTimeWidget> createState() => _CurrentTimeWidgetState();
}

class _CurrentTimeWidgetState extends State<CurrentTimeWidget> {
  String _timeString = '';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    if (mounted) {
      setState(() {
        _timeString = _getTimeString();
      });
    }
  }

  String _getTimeString() {
    DateTime now = DateTime.now();
    return '${TimerConvert().formatNumber(now.hour)}:${TimerConvert().formatNumber(now.minute)}:${TimerConvert().formatNumber(now.second)}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Text(
        _timeString,
        style: CustomFontStyle.titlesTextStyle.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
