import 'package:flutter/material.dart';
import 'package:myits_portal/pages/home/home_page.dart';
import 'package:myits_portal/pages/login/login_page.dart';
import 'package:myits_portal/settings/home_page_settings/fav_app_controls.dart';
import 'package:myits_portal/settings/language_controls.dart';
import 'package:myits_portal/settings/notification_controls.dart';
import 'package:myits_portal/settings/theme_controls.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final isLogin = prefs.getBool('islogin') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageSelector()),
        ChangeNotifierProvider(create: (_) => NotificationSelector()),
        ChangeNotifierProvider(create: (_) => FavAppHandler()),
      ],
      child: MyApp(
          isLogin: isLogin),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLogin;

  const MyApp(
      {Key? key,
      required this.isLogin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'myITS Mobile',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: isLogin ? '/homepage' : '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/homepage': (context) => const HomePage(),
      },
    );
  }
}
