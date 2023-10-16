import 'package:flutter/material.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/settings/style.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    loadData = loadDataAnnounce();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: announcePage());
  }

  Widget announcePage() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 35,
        margin: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Announcements',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<void>(
                future: loadData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: dataAnnounce.length,
                      itemBuilder: ((BuildContext context, index) {
                        final data = dataAnnounce[(index + 1).toString()];
                        return announcementList(data);
                      }),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget announcementList(data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      height: 110,
      decoration: cardsContainer.copyWith(
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: InkWell(
        onTap: () {
          dialogBox(data);
          debugPrint('announcement ${data['title']} ditekan');
        },
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['title'],
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  data['subtitle'],
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Positioned(
              bottom: 5,
              right: 1,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSecondary,
                      width: 1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  data['tags'],
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  dialogBox(data) {
    return showDialog(
        context: context,
        builder: ((context) {
          final hasLink = data['url'] != null && data['url'].isNotEmpty;
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(
              data['title'],
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 18),
            ),
            content: SizedBox(
              child: Text(data['subtitle'],
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Close',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 12),
                ),
              ),
              if (hasLink)
                TextButton(
                  onPressed: () async {
                    await launchURL(data['url']);
                  },
                  child: Text(
                    data['buttonText'],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 12),
                  ),
                ),
            ],
          );
        }));
  }
}
