import 'package:flutter/material.dart';
import 'package:myits_portal/pages/home/home_page.dart';
import 'package:myits_portal/pages/login/login_page.dart';
import 'package:myits_portal/settings/fav_app_controls.dart';
import 'package:myits_portal/settings/language_controls.dart';
import 'package:myits_portal/settings/notification_controls.dart';
import 'package:myits_portal/settings/theme_controls.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLogin = prefs.getBool('islogin') ?? false;
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  // final isEng = prefs.getBool('isEnglish') ?? true;
  final isNotified = prefs.getBool('isNotified') ?? true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeSelector()),
        ChangeNotifierProvider(create: (_) => LanguageSelector()),
        ChangeNotifierProvider(create: (_) => NotificationSelector()),
        ChangeNotifierProvider(create: (_) => TappedState()),
      ],
      child: MyApp(
          isLogin: isLogin,
          isDarkMode: isDarkMode,
          // isEng: isEng,
          isNotified: isNotified),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  final bool isDarkMode;
  // final bool isEng;
  final bool isNotified;

  const MyApp(
      {Key? key,
      required this.isLogin,
      required this.isDarkMode,
      // required this.isEng,
      required this.isNotified})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeSelector = Provider.of<ThemeSelector>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'myITS Mobile',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeSelector.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // themeMode: ThemeMode.dark,
      initialRoute: isLogin ? '/homepage' : '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/homepage': (context) => const HomePage(),
      },
    );
  }
}
