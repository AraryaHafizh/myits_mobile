import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/logic/style.dart';
import 'package:myits_portal/ui/home/home.dart';
import 'package:myits_portal/ui/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLogin = false;
  int userNRP = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    bool loginStatus = await prefs.getBool('isLogin') ?? false;
    int loggedInNrp = await prefs.getInt('nrp')!;
    setState(() {
      isLogin = loginStatus;
      userNRP = loggedInNrp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/its.png'),
      backgroundColor: itsBlueStatic,
      nextScreen: isLogin ? Home(nrp: userNRP) : const LoginPage(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 2000,
    );
  }
}
