import 'package:flutter/material.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/settings/style.dart';

// -------------- announcement page skeleton  --------------
Widget showAnnouncement(context) {
  return Expanded(
      child: ListView.builder(
    padding: EdgeInsets.zero,
    itemCount: announcementData.length,
    itemBuilder: ((BuildContext context, index) {
      final data = announcementData[(index)];
      return announcementList(context, data);
    }),
  ));
}

// -------------- announcement list  --------------
Widget announcementList(context, data) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
    height: 110,
    decoration: cardsContainer.copyWith(
      color: Theme.of(context).colorScheme.secondaryContainer,
    ),
    child: InkWell(
      onTap: () {
        dialogBox(context, data);
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
                    color: Theme.of(context).colorScheme.onSecondary, width: 1),
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

// -------------- dialog box handler --------------
dialogBox(context, data) {
  return showDialog(
      context: context,
      builder: ((context) {
        final hasLink = data['url'] != null && data['url'].isNotEmpty;
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            data['title'],
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
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
              child: const Text('Close'),
            ),
            if (hasLink)
              TextButton(
                onPressed: () async {
                  await launchURL(data['url']);
                },
                child: Text(data['buttonText']),
              ),
          ],
        );
      }));
}
