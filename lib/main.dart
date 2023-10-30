import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/pages/home/home.dart';
import 'package:myits_portal/pages/login/login_page.dart';
import 'package:myits_portal/settings/chat_settings/chat_controls.dart';
import 'package:myits_portal/settings/home_page_settings/fav_app_controls.dart';
import 'package:myits_portal/settings/provider_controls.dart';
import 'package:myits_portal/settings/style.dart';
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
        ChangeNotifierProvider(create: (_) => MhsDataProvider()),
        ChangeNotifierProvider(create: (_) => AppDataProvider()),
        ChangeNotifierProvider(create: (_) => ClassDataProvider()),
        ChangeNotifierProvider(create: (_) => AnnounceDataProvider()),
        ChangeNotifierProvider(create: (_) => AgendaDataProvider()),
        ChangeNotifierProvider(create: (_) => BannerDataProvider()),
        ChangeNotifierProvider(create: (_) => FavAppHandler()),
        ChangeNotifierProvider(create: (_) => ChatbotHandler()),
      ],
      child: MyApp(isLogin: isLogin),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLogin;

  const MyApp({Key? key, required this.isLogin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'myITS Mobile',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => AnimatedSplashScreen(
              splash: Image.asset('assets/images/its.png'),
              backgroundColor: itsBlueStatic,
              nextScreen: isLogin ? Home() : LoginPage(),
              splashTransition: SplashTransition.fadeTransition,
              duration: 2000,
            ),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const Home(),
      },
    );
  }
}
