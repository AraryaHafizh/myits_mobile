import 'package:myits_portal/pages/chat_dptsi_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/settings/style.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

// -------------- load json data  --------------
// var dataStud = dataMhs;
Map<String, dynamic> dataAnnounce = {};
Map<String, dynamic> dataClass = {};
Map<String, dynamic> dataApplication = {};
Map<String, dynamic> dataAgenda = {};
Map<String, dynamic> dataMhs = {};
List<String> dataBanner = [];

Future<void> loadDataAnnounce() async {
  // await Future.delayed(const Duration(seconds: 1)); //simulate loading
  final String jsonData =
      await rootBundle.loadString('assets/data/data_announcement.json');
  dataAnnounce = json.decode(jsonData);
}

Future<void> loadDataClass() async {
  // await Future.delayed(const Duration(seconds: 1)); //simulate loading
  final String jsonData =
      await rootBundle.loadString('assets/data/data_class.json');
  dataClass = json.decode(jsonData);
}

Future<void> loadDataApp() async {
  // await Future.delayed(const Duration(seconds: 1)); //simulate loading
  final String jsonData =
      await rootBundle.loadString('assets/data/data_app.json');
  dataApplication = json.decode(jsonData);
}

Future<void> loadDataAgenda() async {
  // await Future.delayed(const Duration(seconds: 1)); //simulate loading
  final String jsonData =
      await rootBundle.loadString('assets/data/data_agenda.json');
  dataAgenda = json.decode(jsonData);
}

Future<void> loadDataMhs() async {
  // await Future.delayed(const Duration(seconds: 1)); //simulate loading
  final String jsonData =
      await rootBundle.loadString('assets/data/data_mhs.json');
  dataMhs = json.decode(jsonData);
}

Future<void> loadDataBanner() async {
  final String jsonData =
      await rootBundle.loadString('assets/data/data_banner.json');
  final Map<String, dynamic> jsonMap = json.decode(jsonData);
  final List<dynamic> images = jsonMap['images'];
  dataBanner = List<String>.from(images);
}

// -------------- request data from student --------------
dynamic getStudData(request, nrp) {
  dynamic reqData;
  dataMhs.forEach((key, value) {
    // print(key);
    if (key == nrp.toString()) {
      // print(key);
      // print(value[request]);
      reqData = value[request];
    }
  });
  // print(reqData);
  return reqData;
}

// -------------- launch URL --------------
launchURL(data) async {
  final Uri url = Uri.parse(data.toString());
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

// -------------- message button  --------------
msgButton(context) {
  return FloatingActionButton(
    backgroundColor: itsBlue,
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OpenChat(),
        ),
      );
    },
    child: const Icon(
      Icons.chat,
      color: Colors.white,
    ),
  );
}

// -------------- credit --------------
Widget credit(bool isLight, context) {
  return Center(
    child: Column(
      children: [
        Image.asset(
          'assets/images/myits_w.png',
          width: 35,
          height: 35,
          color:
              isLight ? Theme.of(context).colorScheme.tertiary : Colors.white,
        ),
        Text(
          '© 2023 Institut Teknologi Sepuluh Nopember',
          style: isLight
              ? Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w100, fontSize: 8)
              : jakarta.copyWith(
                  fontWeight: FontWeight.w100,
                  fontSize: 8,
                  color: Colors.white),
        ),
        Text(
          'V 0.39',
          style: isLight
              ? Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w100, fontSize: 8)
              : jakarta.copyWith(
                  fontWeight: FontWeight.w100,
                  fontSize: 8,
                  color: Colors.white),
        ),
      ],
    ),
  );
}
