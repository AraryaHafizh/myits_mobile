import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/settings/announcement_page_settings/announcement_page_controls.dart';
import 'package:myits_portal/settings/provider_controls.dart';
import 'package:provider/provider.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: announcePage());
  }

  @override
  void initState() {
    super.initState();
    refetch();
  }

  void refetch() {
    final databaseRef =
        FirebaseDatabase.instance.ref().child('data/-NhZvyqd1OrSpeNRxwb-');
    databaseRef.onValue.listen((event) {
      loadData();
    });
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = false;
    });

    final announceProvider =
        Provider.of<AnnounceDataProvider>(context, listen: false);
    await announceProvider.fetchDataFromAPI();

    setState(() {
      isLoading = true;
    });
  }

  Widget announcePage() {
    if (isLoading) {
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 35,
          margin: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text('Announcements',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 20),
              showAnnouncement(context),
            ],
          ),
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
