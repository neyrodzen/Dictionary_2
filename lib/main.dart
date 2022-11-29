
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'home_page/home_page.dart';
import 'home_page/model/model_page.dart';
import 'home_page/model/model_page_provider.dart';
import 'local_notice_service/notification_controller.dart';
import 'setting_page/setting_page.dart';

Future<void> main() async {
  await NotificationController.initializeLocalNotifications();

  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const String name = 'Awesome Notifications - Example App';
  static const Color mainColor = Colors.deepPurple;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ModelOfPage model = ModelOfPage(0);

  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
    
      title: MyApp.name,
      color: MyApp.mainColor,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
        onPrimary: Colors.white70,
      )),
      home: ModelProvider(
        model: model,
       child: const HomePage()),
      routes: {
        //'/': (context) => HomePage(),
        '/settings_page': (context) => const SettingsPage()
      },
      // initialRoute: '/'
    );
  }
}
