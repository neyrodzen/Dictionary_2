import 'package:permission_handler/permission_handler.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import '../local_notice_service/create_notification.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

int sec = 0;

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController textEditingController = TextEditingController();
  String textError = 'ошибка';
  NotifiCreate notifiCreate = NotifiCreate();
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Future<void> showInterstitialAd() async {
    final ad = await InterstitialAd.create(
      adUnitId: 'demo-interstitial-yandex',
      onAdLoaded: () {
        /* Do something */
      },
      onAdFailedToLoad: (error) {
        /* Do something */
      },
    );
    await ad.load(adRequest: const AdRequest());
    await ad.show();
    await ad.waitForDismiss();
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

  void ontapQuestions() {
    Navigator.of(context).pushNamed('/question_page');

    setState(() {});
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
              'Настройки',
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: SizedBox(
                          height: 35,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ontapQuestions();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(1)),
                        child: const Icon(
                          Icons.question_mark,
                        ),
                      ),
                    ],
                  ),

                  const Divider(
                    color: Color.fromARGB(255, 35, 35, 35),
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Expanded(
                        child: Text('Интервал уведомлений:',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ),
                      SizedBox(
                        width: 60,
                        height: 40,
                        child: TextField(
                            textAlign: TextAlign.center,
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
                        width: 60,
                        child: Center(
                          // width: 60,
                          child: Text(
                            'минут',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            dismissKeyboard();
                            requestPermissions();
                            showInterstitialAd();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Уведомление создано"),
                            ));
                          },
                          child: const Text('Ok'),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 35, 35, 35),
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Expanded(
                          child: Text(
                        'Тема',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )),
                      SizedBox(
                        height: 40,
                        child: ToggleSwitch(
                          customWidths: const [60.0, 60.0],
                          cornerRadius: 5.0,
                          activeBgColors: const [
                            [Colors.blue],
                            [Color.fromARGB(255, 91, 88, 88)]
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
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  // const Divider(
                  //   color: Color.fromARGB(255, 35, 35, 35),
                  //   thickness: 1,
                  //   indent: 10,
                  //   endIndent: 10,
                  // ),
                  // const SizedBox(
                  //   height: 25,
                  // ),
                  // Row(
                  //   children: [
                  //     const SizedBox(
                  //       width: 15,
                  //     ),
                  //     const Text('Доступно уведомлений:',
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //         )),
                  //     const Expanded(
                  //       child: SizedBox(),
                  //     ),
                  //     ConstrainedBox(
                  //       constraints: const BoxConstraints(
                  //         maxHeight: 40,
                  //         maxWidth: 60,
                  //         minHeight: 40,
                  //         minWidth: 60,
                  //       ),
                  //       child: DecoratedBox(
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(5),
                  //             color: const Color.fromARGB(183, 185, 24, 29)),
                  //         child: const Center(
                  //           child: Text(
                  //             'data',
                  //             style: TextStyle(
                  //               fontSize: 16,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 15,
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 25,
                  // ),
                  // const Divider(
                  //   color: Color.fromARGB(255, 35, 35, 35),
                  //   thickness: 1,
                  //   indent: 10,
                  //   endIndent: 10,
                  // ),
                  // const SizedBox(
                  //   height: 100,
                  // ),
                  // ConstrainedBox(
                  //     constraints:
                  //         const BoxConstraints(minHeight: 40, minWidth: 120),
                  //     child: ElevatedButton(
                  //         onPressed: () {},
                  //         style: ButtonStyle(
                  //             shape: MaterialStateProperty.all(
                  //               RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(5),
                  //               ),
                  //             ),
                  //             backgroundColor:
                  //                 MaterialStateProperty.all(Colors.green)),
                  //         child: const Text('Купить')))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
