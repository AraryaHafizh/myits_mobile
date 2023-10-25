import 'package:flutter/material.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/settings/provider_controls.dart';
import 'package:myits_portal/settings/style.dart';
import 'package:provider/provider.dart';

// -------------- announcement page skeleton  --------------
Widget showAnnouncement(context) {
  final announcementProvider = Provider.of<AnnounceDataProvider>(context);
  return Expanded(
      child: ListView.builder(
    padding: EdgeInsets.zero,
    itemCount: announcementProvider.data.length,
    itemBuilder: ((BuildContext context, index) {
      final data = announcementProvider.data[(index)];
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
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
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
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                data['subtitle'],
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 13),
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
                    .copyWith(fontSize: 10, fontWeight: FontWeight.w600),
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
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          content: SizedBox(
            child: Text(data['subtitle'],
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 13)),
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
