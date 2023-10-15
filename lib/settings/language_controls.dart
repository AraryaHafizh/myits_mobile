import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelector with ChangeNotifier {
  bool isEnglish = true;

  Future<void> getLanguagePref() async {
    final prefs = await SharedPreferences.getInstance();
    isEnglish = prefs.getBool('isEnglish') ?? true;
    notifyListeners();
  }

  Future<void> setLanguagePref(val) async {
    final prefs = await SharedPreferences.getInstance();
    isEnglish = val;
    await prefs.setBool('isEnglish', val);
    notifyListeners();
  }

  Future<void> initLanguage() async {
    await getLanguagePref();
  }
}
