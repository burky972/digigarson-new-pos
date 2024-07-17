import 'dart:developer';
import 'dart:io';

import 'package:window_manager/window_manager.dart';

class WindowManagerInitialize {
  Future<void> setup() async {
// Must add this line.
    if (Platform.isWindows) {
      log('PLATFORM IS WINDOWS çalıştı.');
      await windowManager.ensureInitialized();

      // Use it only after calling `hiddenWindowAtLaunch`
      windowManager.waitUntilReadyToShow().then((_) async {
        // Hide window title bar
        await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
        await windowManager.center();
        await windowManager.show();
        await windowManager.setSkipTaskbar(false);
        await WindowManager.instance.setFullScreen(false);
        await windowManager.setFullScreen(true);
      });
    }
  }
}
