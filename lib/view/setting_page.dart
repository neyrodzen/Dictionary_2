import 'package:permission_handler/permission_handler.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:push_word/data_base/data_base.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';
import '../local_notice_service/create_notification.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

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
  DataBase dataBase = DataBase();
  late int spin;
  @override
  void initState() {
    super.initState();
    dataBase.initialSpin();
    showInterstitialAd();
    focusNode = FocusNode();
  }

  Future<int> getSpin() async {
    var spin = dataBase.getSpin();
    setState(() {});
    return spin;
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

  void ontapQuestions() {
    Navigator.of(context).pushNamed('/question_page');
    setState(() {});
  }

  Future<void> showInterstitialAd() async {
    final ad = await InterstitialAd.create(
      adUnitId: 'R-M-2953427-1',
      onAdLoaded: () {},
      onAdFailedToLoad: (error) {
        /* Do something */
      },
    );
    await ad.load(adRequest: const AdRequest());
    await ad.show();
    await ad.waitForDismiss();
  }

  void getSnackBar(String text) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  Future<void> showRewardedAd() async {
    final ad = await RewardedAd.create(
      adUnitId: 'R-M-2953427-2',
      onAdLoaded: () {},
      onAdFailedToLoad: (error) {
        /* Do something */
      },
    );
    await ad.load(adRequest: const AdRequest());
    await ad.show();
    final reward = await ad.waitForDismiss();
    if (reward != null) {
      //getSnackBar('Получено!');
     await dataBase.putSpin();
     setState(() {
     });
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
                        height: 35,
                        child: TextField(
                            textAlign: TextAlign.center,
                            focusNode: focusNode,
                            keyboardType: TextInputType.number,
                            controller: textEditingController,
                            onTapOutside: (event) { 
                              dismissKeyboard();
                            setState(() {
                            });},
                            onEditingComplete: () {
                              dismissKeyboard();
                              if (spin > 0) {
                                requestPermissions();
                                getSnackBar("Уведомления созданы");
                              } else {
                                getSnackBar('Уведомления закончились. Получите Free Push');
                              }
                            },
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
                        height: 35,
                        width: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            dismissKeyboard();
                            if (spin > 0) {
                              requestPermissions();
                              getSnackBar("Уведомления созданы");
                            } else {
                              getSnackBar('Получите Free Push');
                            }
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
                        height: 35,
                        child: ToggleSwitch(
                          customWidths: const [60.0, 60.0],
                          cornerRadius: 5.0,
                          activeBgColors: const [
                            [Color.fromARGB(212, 5, 165, 205)],
                            [Color.fromARGB(255, 54, 53, 53)]
                          ],
                          initialLabelIndex:
                              Theme.of(context).brightness == Brightness.light
                                  ? 0
                                  : 1,
                          activeFgColor: Colors.white,
                        animate: true,
                        animationDuration: 300,
                          inactiveBgColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(130, 54, 53, 53)
                                  : const Color.fromARGB(51, 6, 197, 245),
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
                      const Text('Доступно уведомлений:',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 35,
                          maxWidth: 60,
                          minHeight: 35,
                          minWidth: 60,
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(183, 185, 24, 29)),
                          child: Center(
                            child: FutureBuilder(
                                future: getSpin(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  spin = snapshot.data;
                                  return Text(
                                    snapshot.data.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  );
                                }),
                          ),
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
                    height: 20,
                  ),
                  ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 40, minWidth: 120),
                      child: ElevatedButton(
                          onPressed: () {
                            showRewardedAd();
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          child: const Text('Free Push'))),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
