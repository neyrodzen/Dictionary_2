
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:push_word/view/languages_page.dart';
import 'package:push_word/view/question_page.dart';
import 'view/home_page.dart';
import 'model/model_page.dart';
import 'model/model_page_provider.dart';
import 'view/my_colors.dart';
import 'local_notice_service/notification_controller.dart';
import 'view/setting_page.dart';
import 'package:yandex_mobileads/mobile_ads.dart';


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
    MobileAds.initialize();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch:
            MaterialColorGenerator.from(const Color.fromARGB(212, 5, 165, 205)),
        primaryColor: const Color.fromARGB(212, 5, 165, 205),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(211, 3, 125, 155),
        ),
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch:
            MaterialColorGenerator.from(const Color.fromARGB(115, 79, 78, 78)),
        primaryColor: const Color.fromARGB(115, 79, 78, 78),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromARGB(255, 39, 36, 36)),
      ),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Английский в уведомлениях',
        theme: theme,
        darkTheme: darkTheme,

        navigatorKey: MyApp.navigatorKey,
        //title: MyApp.name,
        debugShowCheckedModeBanner: false,
        home: ModelProvider(model: model, child: const HomePage()),
        routes: {
          //'/': (context) => HomePage(),
          '/settings_page': (context) => const SettingsPage(),
          '/question_page': (context) => const QuestionPage(),
          '/languages_page':  (context) => const LanguagesPage(),
        },
        // initialRoute: '/'
      ),
    );
  }
}
