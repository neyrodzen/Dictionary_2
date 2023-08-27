import 'package:permission_handler/permission_handler.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';

import '../local_notice_service/create_notification.dart';

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
 late FocusNode focusNode;
  @override
  void initState() {
    super.initState();

     focusNode = FocusNode();
    // focusNode.addListener(() {
    //   print('Listener');
    // });
  }

    @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void requestPermissions() async {
    PermissionStatus permissionStatus = await Permission.notification.status;

    if (permissionStatus == PermissionStatus.granted) {
      await notifiCreate.getWords();
      notifiCreate.create();
      
    } else {
      openAppSettings();
    }
  }

 void dismissKeyboard() {
    focusNode.unfocus();
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
    return  Scaffold(
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
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                // const Center(
                //     child: Text(
                //   'Настройка уведомлений',
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.w500,
                //   ),
                // )),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Expanded(
                        child: Text(
                      'Theme',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )),
                    ToggleSwitch(
                      customWidths: const [60.0, 60.0],
                      cornerRadius: 20.0,
                      activeBgColors: const [
                        [Colors.blue],
                        [Color.fromARGB(255, 65, 61, 61)]
                      ],
                      initialLabelIndex:
                          Theme.of(context).brightness == Brightness.light
                              ? 0
                              : 1,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      radiusStyle: true,
                      labels: const ['Light', 'Dark'],
                      onToggle: (index) {
                        if (index == 1) {
                          AdaptiveTheme.of(context).setDark();
                        } else {
                          AdaptiveTheme.of(context).setLight();
                        }
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Expanded(
                      child: Text('Notification interval:',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      child: TextField(
                         focusNode: focusNode,
                          keyboardType: TextInputType.number,
                          controller: textEditingController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onChanged: onChange),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                      ElevatedButton(
                      onPressed: () {
                         dismissKeyboard();
                        requestPermissions();
                      },
                      
                      
                      child: const Text('Ok'),
                    
                    ),
                    
                    const SizedBox(
                      width: 10,
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
