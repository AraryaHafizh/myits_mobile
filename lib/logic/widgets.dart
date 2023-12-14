import 'package:dio/dio.dart';
import 'package:myits_portal/ui/home/chat_dptsi_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/logic/style.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

final dio = Dio();

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
          builder: (context) => ChatBot(nrp: nrp),
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
          'V 1.0.0',
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
