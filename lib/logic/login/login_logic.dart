import 'package:flutter/material.dart';
import 'package:myits_portal/logic/widgets.dart';
import 'package:myits_portal/logic/provider_handler.dart';
import 'package:myits_portal/ui/home/home.dart';
import 'package:myits_portal/ui/login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> login(context, nrp) async {
  int parsedInt = int.parse(nrp);
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLogin', true);
  await prefs.setInt('nrp', parsedInt);
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Home(nrp: parsedInt)),
      (route) => false);
}

void userInputCheck(context, nrp, password) {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  bool isLoggedIn = false;

  userProvider.data.forEach((key, value) {
    if (key == nrp && value['password'] == encryptPassword(password)) {
      isLoggedIn = true;
    }
  });
  if (isLoggedIn) {
    login(context, nrp);
    return;
  } else {
    errorDialog(context);
  }
}
