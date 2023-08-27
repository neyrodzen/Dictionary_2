import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../data_base/data_base.dart';
import '../setting_page/setting_page.dart';

 class NotifiCreate {
 static String keys = 'word';
 static String values = 'translate';
  DataBase database = DataBase();
   void create() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: keys,
          body: values,
          actionType: ActionType.SilentAction,
          wakeUpScreen: false,
          category: NotificationCategory.Message),
      schedule: NotificationInterval(
        interval: sec*60,
        preciseAlarm: true,
      ),
      actionButtons: [
        NotificationActionButton(
            key: 'repeat',
            label: 'repeat',
            color: const Color.fromARGB(255, 25, 95, 39),
            actionType: ActionType.SilentAction),
        NotificationActionButton(
          key: 'cancel',
          label: 'cancel',
          color: Colors.red,
          actionType: ActionType.DisabledAction,
        ),
        NotificationActionButton(
            key: 'next',
            label: 'next',
            color: const Color.fromARGB(255, 35, 22, 22),
            actionType: ActionType.SilentAction),
      ],
    );
  }

  Future<void> getWords() async {
    Map<String, String> mapa = await database.getNextWords();
    keys = mapa.keys.elementAt(0);
    values = mapa[keys]!;
  }
}
