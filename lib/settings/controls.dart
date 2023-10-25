import 'package:dio/dio.dart';
import 'package:myits_portal/pages/chat_dptsi_page.dart';
import 'package:myits_portal/settings/provider_controls.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/settings/style.dart';

final dio = Dio();

// -------------- load json data  --------------
String bannerURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/-NhZv_EAb2aPMOux2uCA.json';
String appURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/-NhZvp75myiUERSGGFMN.json';
String mhsURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/-NhZvIHt6AKiTb-zQDnn.json';
String announcementURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/-NhZvyqd1OrSpeNRxwb-.json';
String agendaURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/-NhZw49cbFF1L7zJIE5B.json';
String classScheduleURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/-NhZvVJVRDCmelUcNtUJ.json';

// -------------- request data from student --------------
dynamic getStudData(context, request, nrp) {
  final mhsProvider = Provider.of<MhsDataProvider>(context, listen: false);
  dynamic reqData;
  mhsProvider.data.forEach((key, value) {
    if (key == nrp.toString()) {
      reqData = value[request];
    }
  });
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
