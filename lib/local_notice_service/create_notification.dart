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
          key: 'cancel',
          label: 'Отмена',
          color: Colors.red,
          actionType: ActionType.DisabledAction,
        ),

        NotificationActionButton(
            key: 'repeat',
            label: 'Повтор',
            color: const Color.fromARGB(255, 187, 218, 73),
            actionType: ActionType.SilentAction,
           ),

        
        NotificationActionButton(
            key: 'next',
            label: 'Следующее',
            color: const Color.fromARGB(255, 4, 154, 27),
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
