import 'package:myits_portal/logic/home/chat_logic.dart';
import 'package:myits_portal/logic/widgets.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/logic/url_collection.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic> mhsData = {};
  Map data4GPT = {};
  Map get dataGPT => data4GPT;
  Map<String, dynamic> get data => mhsData;

  dynamic getStudData(request, nrp) {
    dynamic reqData;
    mhsData.forEach((key, value) {
      if (key == nrp.toString()) {
        reqData = value[request];
      }
    });
    return reqData;
  }

  void loadData4GPT(nrp) {
    mhsData.forEach((key, value) {
      if (key == nrp.toString()) {
        data4GPT = value;
      }
    });
  }

  Future<void> fetchDataFromAPI() async {
    try {
      final mhsResponse = await dio.get(userURL);
      if (mhsResponse.statusCode == 200) {
        mhsData = mhsResponse.data;
        notifyListeners();
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      throw Exception('Failed to load data from API: $error');
    }
  }
}

class AppProvider with ChangeNotifier {
  List<dynamic> appData = [];

  List<dynamic> get data => appData;

  Future<void> fetchDataFromAPI() async {
    try {
      final appResponse = await dio.get(appURL);
      if (appResponse.statusCode == 200) {
        appData = appResponse.data;
        notifyListeners();
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      throw Exception('Failed to load data from API: $error');
    }
  }
}

class UserClassProvider with ChangeNotifier {
  List<dynamic> classData = [];

  List<dynamic> get data => classData;

  Future<void> fetchDataFromAPI() async {
    try {
      final classResponse = await dio.get(userClassURL);
      if (classResponse.statusCode == 200) {
        classData = classResponse.data;
        notifyListeners(); // Memberitahu listener bahwa data telah diperbarui.
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      throw Exception('Failed to load data from API: $error');
    }
  }
}

class AnnouncementProvider with ChangeNotifier {
  List<dynamic> announceData = [];
  List<dynamic> agenda4GPT = [];
  List<dynamic> get data => announceData;
  List<dynamic> get dataGPT => agenda4GPT;

  Future<void> fetchDataFromAPI() async {
    try {
      final announceResponse = await dio.get(announcementURL);
      if (announceResponse.statusCode == 200) {
        announceData = announceResponse.data;
        notifyListeners();
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      throw Exception('Failed to load data from API: $error');
    }
  }

  void dataForGPT() {
    for (var agenda in data) {
      String title = agenda['title'] ?? '';
      String subtitle = agenda['subtitle'] ?? '';

      agenda4GPT.add({"title": title, "subtitle": subtitle});
    }
  }
}

class AgendaProvider with ChangeNotifier {
  List<dynamic> agendaData = [];
  List<dynamic> agenda4GPT = [];
  List<dynamic> get data => agendaData;
  List<dynamic> get dataGPT => agenda4GPT;

  Future<void> fetchDataFromAPI() async {
    try {
      final agendaResponse = await dio.get(agendaURL);
      if (agendaResponse.statusCode == 200) {
        agendaData = agendaResponse.data;
        notifyListeners();
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      throw Exception('Failed to load data from API: $error');
    }
  }

  void dataForGPT() {
    for (var agenda in data) {
      String title = agenda['title'] ?? '';
      String desc = agenda['desc'] ?? '';
      String date = agenda['date'] ?? '';

      agenda4GPT.add({"title": title, "desc": desc, "date": date});
    }
  }
}

class BannerProvider with ChangeNotifier {
  List<dynamic> bannerData = [];

  List<dynamic> get data => bannerData;

  Future<void> fetchDataFromAPI() async {
    try {
      final bannerResponse = await dio.get(bannerURL);
      if (bannerResponse.statusCode == 200) {
        bannerData = bannerResponse.data;
        notifyListeners(); // Memberitahu listener bahwa data telah diperbarui.
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      throw Exception('Failed to load data from API: $error');
    }
  }
}

class EditFavAppProvider extends ChangeNotifier {
  List copyFav = [];
  int get favLen => copyFav.length;

  bool isFav(idx) {
    return copyFav.contains(idx);
  }

  void toggleTap(idx) {
    if (isFav(idx)) {
      copyFav.remove(idx);
    } else {
      copyFav.add(idx);
    }
    notifyListeners();
  }

  void eraseOne(idx) {
    copyFav.remove(idx);
    notifyListeners();
  }
}

class ChatbotProvider extends ChangeNotifier {
  String gptOutput = '';
  String userInput = '';
  List<dynamic> chatHistory = [];

  String get output => gptOutput;
  String get input => userInput;
  List<dynamic> get history => chatHistory;

  void updateLoadingState() {
    waitGPTAnswer = !waitGPTAnswer;
    notifyListeners();
  }

  void updateOutput(data) {
    gptOutput = data;
    notifyListeners();
  }

  void updateInput(data) {
    userInput = data;
    notifyListeners();
  }

  void updateHistory() {
    chatHistory.add([input, output]);
    notifyListeners();
  }

  void clearChat() {
    chatHistory.clear();
    notifyListeners();
  }

  void askGPT(context, data, nrp) async {
    updateInput(data);
    await submit(context, data, nrp);
  }
}
