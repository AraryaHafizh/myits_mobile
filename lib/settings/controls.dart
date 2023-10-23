import 'package:dio/dio.dart';
import 'package:myits_portal/pages/chat_dptsi_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/settings/style.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

final dio = Dio();

// -------------- load json data  --------------
String bannerURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/-NhFSVgMHQbDkrkoyJ5m.json';
String appURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/-NhFLTa_HU65ZaKrjjvr.json';
String mhsURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/-NhS9qciBm6rdP1hTAKd.json';
String announcementURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/-NhFSDOEdHNNEqf5hUyA.json';
String agendaURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/-NhFKvjMi1HWCfaFQzGe.json';

Map<String, dynamic> dataClass = {};

List<dynamic> bannerData = [];
List<dynamic> appData = [];
List<dynamic> mhsData = [];
List<dynamic> announcementData = [];
List<dynamic> agendaData = [];

Future<void> loadDataClass() async {
  // await Future.delayed(const Duration(seconds: 1)); //simulate loading
  final String jsonData =
      await rootBundle.loadString('assets/data/data_class.json');
  dataClass = json.decode(jsonData);
}

// -------------- request data from student --------------
dynamic getStudData(request, nrp) {
  dynamic reqData;
  mhsData.forEach((element) {
    // print(key);
    if (element['id'] == nrp.toString()) {
      // print(key);
      // print(value[request]);
      reqData = element['data'][request];
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
