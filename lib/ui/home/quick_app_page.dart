import 'package:flutter/material.dart';
import 'package:myits_portal/logic/provider_handler.dart';
import 'package:myits_portal/logic/style.dart';
import 'package:myits_portal/ui/home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

int userNRP = 0;
final databaseRef = FirebaseDatabase.instance.ref().child('data/user/$userNRP');

void pushNewFav(List newFav) {
  databaseRef.update({'favApp': newFav});
}

Widget editQuickApps(BuildContext context, nrp) {
  return InkWell(
      onTap: () {
        showEditAppUI(context, nrp);
      },
      child: Text('Edit',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w600)));
}

Future showEditAppUI(context, nrp) {
  double screenHeight = MediaQuery.of(context).size.height;
  double desiredHeight = 0.83 * screenHeight;
  final favAppHandler = Provider.of<EditFavAppProvider>(context, listen: false);
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final appHandler = Provider.of<AppProvider>(context, listen: false);

  userNRP = nrp;
  favAppHandler.copyFav = [...userProvider.getStudData('favApp', nrp)];
  return showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.background,
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: ((context) {
        // return Text('aaaa');
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          width: MediaQuery.of(context).size.width - 25,
          height: desiredHeight,
          child: Column(
            children: [
              Text(
                'Choose 8 favorite apps.',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: ListView.builder(
                itemCount: appHandler.data.length,
                itemBuilder: (context, index) {
                  final data = appHandler.data[(index)];
                  return appListBuilder(data, index, context);
                },
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<EditFavAppProvider>(
                    builder: (context, favAppHandler, child) {
                      return Text('${favAppHandler.favLen} Selected');
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      pushNewFav(favAppHandler.copyFav);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Save',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }));

  // .whenComplete(() => colorChangingState.clearFav());
}

Widget appListBuilder(data, idx, context) {
  final favAppHandler = Provider.of<EditFavAppProvider>(context);
  bool isSelected = favAppHandler.isFav(idx);
  final maxLen = favAppHandler.favLen < 8;
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
        color: isSelected ? itsBlue.withAlpha(100) : Colors.transparent,
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        if (maxLen) {
          favAppHandler.toggleTap(idx);
        } else {
          favAppHandler.eraseOne(idx);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            Image.network(data['gambar'], height: 35),
            const SizedBox(width: 15),
            Text(data['nama']),
          ],
        ),
      ),
    ),
  );
}

List<String> getTags(context) {
  final appHandler = Provider.of<AppProvider>(context, listen: false);
  List<String> appTags = [];
  for (var items in appHandler.data) {
    if (items['tags'] == 'Aset, Arsip dan Perkantoran') {
      appTags.add('Aset, Arsip dan Perkantoran');
    } else {
      appTags.add(items['tags']);
    }
  }
  appTags = appTags.toSet().toList();
  return appTags;
}

Widget appByTag(context, String tags) {
  final appHandler = Provider.of<AppProvider>(context, listen: false);
  List<int> appIdx = [];
  for (var items in appHandler.data) {
    if (items['tags'] == tags) {
      appIdx.add(appHandler.data.indexOf(items));
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        tags,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.w800, fontSize: 19),
      ),
      const SizedBox(height: 10),
      Container(
        margin: const EdgeInsets.only(top: 5, bottom: 15),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: appIdx.length,
          itemBuilder: (BuildContext context, index) {
            return favAppBuilder(context, appIdx[index]);
          },
        ),
      ),
    ],
  );
}

Future showAllApps(context) {
  double screenHeight = MediaQuery.of(context).size.height;
  double desiredHeight = 0.83 * screenHeight;
  return showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.background,
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: ((context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          width: MediaQuery.of(context).size.width - 25,
          height: desiredHeight,
          child: SingleChildScrollView(
            child: Column(
              children: getTags(context).map((tag) {
                // return Text(tag);
                return appByTag(context, tag);
              }).toList(),
            ),
          ),
        );
      }));
}
