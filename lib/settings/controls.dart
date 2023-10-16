import 'package:myits_portal/data/data_mhs.dart';
import 'package:myits_portal/pages/chat_dptsi_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/settings/style.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

// -------------- load json data  --------------

var dataStud = dataMhs;
Map<String, dynamic> dataAnnounce = {};
Map<String, dynamic> dataClass = {};
Map<String, dynamic> dataApplication = {};
Map<String, dynamic> dataAgenda = {};
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

Future<void> loadDataBanner() async {
  final String jsonData =
      await rootBundle.loadString('assets/data/data_banner.json');
  final Map<String, dynamic> jsonMap = json.decode(jsonData);
  final List<dynamic> images = jsonMap['images'];
  dataBanner = List<String>.from(images);
}

// -------------- Widget Mkaer --------------

String getStudData(request, nrp) {
  String reqData = '';
  dataStud.forEach((key, value) {
    if (key == nrp) {
      reqData = value[request].toString();
    }
  });
  return reqData;
}

launchURL(data) async {
  final Uri url = Uri.parse(data.toString());
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

Widget appListMaker(int idx, context) {
  if (dataApplication.containsKey(idx.toString())) {
    var getValue = dataApplication[idx.toString()];
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: const Color.fromARGB(55, 4, 53, 145),
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          await launchURL(getValue['url']);
          debugPrint('${getValue['nama']} ditekan!');
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                getValue['gambar'],
                width: 58,
                height: 58,
              ),
              Text(
                getValue['nama'],
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  } else {
    // Handle case when idx is not a valid key in dataApplication
    return const SizedBox(); // You can return an empty widget or some other placeholder.
  }
}

List<String> getTags(BuildContext context) {
  List<String> appTags = [];
  for (var element in dataApplication.values) {
    if (element.containsKey('tags')) {
      appTags.add(element['tags']);
    }
  }
  appTags = appTags.toSet().toList();
  return appTags;
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

// -------------- name banner handler  --------------

Widget nameCard(nrp, context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome,',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 20),
              ),
              const SizedBox(height: 5),
              Text(getStudData('nama', nrp),
                  style: Theme.of(context).textTheme.titleLarge)
            ]),
        Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getStudData('jurusan', nrp),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                'Semester ${getStudData('semester', nrp)}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
              )
            ])
      ],
    ),
  );
}

Widget loadBanners(data) {
  return InkWell(
    onTap: () {
      debugPrint('Banner ditekan');
    },
    child: SizedBox(
      width: double.infinity,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            data,
            fit: BoxFit.cover,
          )),
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
          color: Theme.of(context).colorScheme.tertiary,
        ),
        Text(
          '© 2023 Institut Teknologi Sepuluh Nopember',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w100,
              fontSize: 8
          ),
        ),
        Text(
          'V 0.39',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w100,
              fontSize: 8
          ),
        ),
      ],
    ),
  );
}
