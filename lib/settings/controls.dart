import 'package:dio/dio.dart';
import 'package:myits_portal/pages/chat_dptsi_page.dart';
import 'package:myits_portal/settings/provider_controls.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/settings/style.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

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

// -------------- launch URL --------------
launchURL(data) async {
  final Uri url = Uri.parse(data.toString());
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

// -------------- message button  --------------
msgButton(context, nrp) {
  return FloatingActionButton(
    backgroundColor: itsBlue,
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OpenChat(nrp: nrp),
        ),
      );
    },
    child: const Icon(
      Icons.chat,
      color: Colors.white,
    ),
  );
}

// -------------- show WIP dialog --------------
void wipAlertDialog(context) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Work In Progress',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 23, fontWeight: FontWeight.w700),
          ),
          content: Text(
              'We\'re currently working on this feature. Please hang tight and stay tuned for the exciting updates!.',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 13)),
          actions: [
            // TextButton(
            //     onPressed: () {
            //       Navigator.pop(context);
            //       Navigator.pop(context);
            //     },
            //     child: Text('Go Back')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        );
      });
}

// -------------- encrypt password --------------
String encryptPassword(String password) {
  final bytes = utf8.encode(password);
  final hash = sha256.convert(bytes);
  return hash.toString();
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
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 8)
              : jakarta.copyWith(
                  fontWeight: FontWeight.w100,
                  fontSize: 8,
                  color: Colors.white),
        ),
        const SizedBox(height: 3),
        Text(
          'V 0.86',
          style: isLight
              ? Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 8)
              : jakarta.copyWith(
                  fontWeight: FontWeight.w100,
                  fontSize: 8,
                  color: Colors.white),
        ),
      ],
    ),
  );
}
