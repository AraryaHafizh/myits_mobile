import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSelector with ChangeNotifier {
  bool isNotified = true;

  Future<void> getNotifierPref() async {
    final prefs = await SharedPreferences.getInstance();
    isNotified = prefs.getBool('isNotified') ?? true;
    notifyListeners();
  }

  Future<void> setNotifierPref(val) async {
    final prefs = await SharedPreferences.getInstance();
    isNotified = val;
    await prefs.setBool('isNotified', val);
    notifyListeners();
  }

  Future<void> initNotifier() async {
    await getNotifierPref();
  }
}
