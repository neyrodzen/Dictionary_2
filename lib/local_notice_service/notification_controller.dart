import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_with_not/local_notice_service/create_notification.dart';
import 'package:dictionary_with_not/data_base/data_base.dart';

 class  NotificationController {

  static ReceivedAction? initialAction;

  NotifiCreate notifiCreate = NotifiCreate();
  static Future<void> initializeLocalNotifications() async {
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          enableVibration: true,
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true,
    );

    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.buttonKeyPressed == 'repeat') {
      await NotifiCreate().getWords();
      NotifiCreate().create();
    }
    if (receivedAction.buttonKeyPressed == 'next') {
      DataBase.count++;
      await NotifiCreate().getWords();
      NotifiCreate().create();
    }
  }
}
