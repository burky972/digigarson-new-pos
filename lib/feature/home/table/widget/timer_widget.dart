import 'dart:async';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/utils/helper/timer_convert.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final DateTime? lastOrderTime;
  final Color? color;

  const TimerWidget({super.key, required this.lastOrderTime, this.color});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late DateTime? lastOrderTime;
  Timer? timer;
  Duration? elapsedTime;

  @override
  void initState() {
    super.initState();
    lastOrderTime = widget.lastOrderTime;
    if (lastOrderTime != null) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {
          elapsedTime = DateTime.now().difference(lastOrderTime!);
        });
      });
    } else {
      Text(
        '00.00',
        style: CustomFontStyle.generalTextStyle
            .copyWith(color: widget.color ?? context.colorScheme.tertiary),
      );
    }
  }

  @override
  void dispose() {
    // Check if the timer has been initialized before canceling it
    timer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(TimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.lastOrderTime != oldWidget.lastOrderTime) {
      lastOrderTime = widget.lastOrderTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    int seconds = 0;
    int minutes = 0;
    int hours = 0;
    if (elapsedTime != null) {
      seconds = elapsedTime!.inSeconds % 60;
      minutes = (elapsedTime!.inMinutes % 60);
      hours = elapsedTime!.inHours;
    }

    return Text(
      //TODO: IF WANNA SHOW THE SECONDS OPEN THE COMMENT LINE
      // '${TimerConvert().formatNumber(hours)}:${TimerConvert().formatNumber(minutes)}:${TimerConvert().formatNumber(seconds)}',
      '${TimerConvert().formatNumber(hours)}:${TimerConvert().formatNumber(minutes)}',
      style: CustomFontStyle.popupNotificationTextStyle
          .copyWith(color: widget.color ?? context.colorScheme.primary),
    );
  }
}
