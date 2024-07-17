import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/widget/button/custom_yes_no_button.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TopRightCloseButtons extends StatelessWidget with MainRightMixin {
  const TopRightCloseButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.onSurface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.open_in_full, size: 24, color: Colors.greenAccent),
            onPressed: onWindowScreenSize,
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 24, color: Colors.red),
            onPressed: () {
              onWindowClose(context);
            },
          ),
        ],
      ),
    );
  }
}

mixin MainRightMixin on StatelessWidget {
  onWindowScreenSize() async {
    bool isPreventClose = await windowManager.isFullScreen();
    if (isPreventClose) {
      await windowManager.setFullScreen(false);
    } else {
      await windowManager.setFullScreen(true);
    }
  }

  onWindowClose(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Are you sure you want to close this window?'),
          actions: [
            CustomNoButton(onPressed: () => Navigator.of(context).pop()),
            CustomYesButton(onPressed: () async {
              Navigator.of(context).pop();
              await windowManager.destroy();
            })
          ],
        );
      },
    );
  }
}
