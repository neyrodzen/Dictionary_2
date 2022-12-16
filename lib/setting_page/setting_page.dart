import 'package:permission_handler/permission_handler.dart';
import 'package:dictionary_with_not/local_notice_service/create_notification.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

int sec = 0;

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController textEditingController = TextEditingController();
  String textError = 'error';
  NotifiCreate notifiCreate = NotifiCreate();
  @override
  void initState() {
    super.initState();
  }

  void requestPermissions() async {
    PermissionStatus permissionStatus = await Permission.notification.status;

    if (permissionStatus == PermissionStatus.granted) {
      await notifiCreate.getWords();
      notifiCreate.create();
    } else {
      //  if (permissionStatus == PermissionStatus.denied  ||
      //     permissionStatus == PermissionStatus.permanentlyDenied ||
      //     permissionStatus == PermissionStatus.restricted){
      openAppSettings();
    }
  }

  void onChange(String value) {
    if (value != '') {
      try {
        sec = int.parse(value);
      } catch (error) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(textError),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Text(''),
            )
          ],
          title: const Center(
            child: Text(
              'Settings',
            ),
          )),
      body: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: double.infinity,
          minWidth: double.infinity,
        ),
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.white),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Center(
                    child: Text(
                  'Настройка уведомлений',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Введите интервал в минутах:',
                    style: const TextStyle(
              fontSize: 16,
             )),
                    SizedBox(
                      width: 60,
                      child: TextField(
                          keyboardType: TextInputType.number,
                          controller: textEditingController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onChanged: onChange),
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    ElevatedButton(
                      onPressed: () async {
                        requestPermissions();
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
