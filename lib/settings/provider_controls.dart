import 'package:myits_portal/settings/controls.dart';
import 'package:flutter/material.dart';

class MhsDataProvider with ChangeNotifier {
  Map<String, dynamic> mhsData = {};

  Map<String, dynamic> get data => mhsData;

  dynamic getFavApp(request, nrp) {
    dynamic reqData;
    mhsData.forEach((key, value) {
      if (key == nrp.toString()) {
        reqData = value[request];
      }
    });
    notifyListeners();
    return reqData;
  }

  Future<void> fetchDataFromAPI() async {
    try {
      final mhsResponse = await dio.get(mhsURL);
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

class AppDataProvider with ChangeNotifier {
  List<dynamic> appData = [];

  List<dynamic> get data => appData;

  Future<void> fetchDataFromAPI() async {
    try {
      final appResponse = await dio.get(appURL);
      if (appResponse.statusCode == 200) {
        appData = appResponse.data;
        notifyListeners(); // Memberitahu listener bahwa data telah diperbarui.
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      throw Exception('Failed to load data from API: $error');
    }
  }
}

class ClassDataProvider with ChangeNotifier {
  List<dynamic> classData = [];

  List<dynamic> get data => classData;

  Future<void> fetchDataFromAPI() async {
    try {
      final classResponse = await dio.get(classScheduleURL);
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

class AnnounceDataProvider with ChangeNotifier {
  List<dynamic> announceData = [];

  List<dynamic> get data => announceData;

  Future<void> fetchDataFromAPI() async {
    try {
      final announceResponse = await dio.get(announcementURL);
      if (announceResponse.statusCode == 200) {
        announceData = announceResponse.data;
        notifyListeners(); // Memberitahu listener bahwa data telah diperbarui.
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      throw Exception('Failed to load data from API: $error');
    }
  }
}

class AgendaDataProvider with ChangeNotifier {
  List<dynamic> agendaData = [];

  List<dynamic> get data => agendaData;

  Future<void> fetchDataFromAPI() async {
    try {
      final agendaResponse = await dio.get(agendaURL);
      if (agendaResponse.statusCode == 200) {
        agendaData = agendaResponse.data;
        notifyListeners(); // Memberitahu listener bahwa data telah diperbarui.
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      throw Exception('Failed to load data from API: $error');
    }
  }
}

class BannerDataProvider with ChangeNotifier {
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
