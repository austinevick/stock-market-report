import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'constant.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void showDialogFlash(
    {String title = '', String? content, VoidCallback? onTap}) {
  navigatorKey.currentContext!.showFlashDialog(
      constraints: const BoxConstraints(maxWidth: 300),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      content: Text(content!, style: const TextStyle(fontSize: 14)),
      negativeActionBuilder: (context, controller, _) {
        return TextButton(
          onPressed: () => controller.dismiss(),
          child: const Text('CANCEL'),
        );
      },
      positiveActionBuilder: (context, controller, _) {
        return TextButton(
            onPressed: onTap ??
                () {
                  controller.dismiss();
                },
            child: const Text('OK'));
      });
}

void hasInternetConnection() {
  Connectivity().onConnectivityChanged.listen((event) {
    if (event == ConnectivityResult.none) {
      showDialogFlash(
        title: noConnection,
        content: noConnectionMessage,
        onTap: () => AppSettings.openWirelessSettings(),
      );
    }
  });
}
