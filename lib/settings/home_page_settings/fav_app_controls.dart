import 'package:flutter/material.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/settings/style.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

int userNRP = 0;
List favApp = getFavData(userNRP);
// final databaseRef = FirebaseDatabase.instance.ref('$mhsURL/$userNRP');
final databaseRef = FirebaseDatabase.instance.ref().child('data');

List getFavData(nrp) {
  List data = getStudData('favApp', nrp);
  // print(data);
  return data;
}

class FavAppHandler extends ChangeNotifier {
  List copyFav = [];
  int get favLen => copyFav.length;

  bool isFav(idx) {
    return copyFav.contains(idx);
  }

  void toggleTap(idx) {
    if (isFav(idx)) {
      copyFav.remove(idx);
    } else {
      copyFav.add(idx);
    }
    notifyListeners();
  }

  void eraseOne(idx) {
    copyFav.remove(idx);
    notifyListeners();
  }
}

void pushNewFav(List newFav) {
  // databaseRef.child('data/favApp').set(newFav);
  // databaseRef
  //     .child(userNRP.toString())
  //     .child("data")
  //     .update({"favApp": newFav});
}

Widget openEditFavApp(BuildContext context, nrp) {
  return InkWell(
      onTap: () {
        debugPrint('tomnol ditekan');
        botSheetEdit(context, nrp).then((value) {
          userNRP = nrp;
        });
        print(userNRP);
        // botSheetEdit(context, nrp);
      },
      child: Text('Edit',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w900)));
}

// menampilkan bottomsheet
Future botSheetEdit(context, nrp) {
  final favAppHandler = Provider.of<FavAppHandler>(context, listen: false);
  double screenHeight = MediaQuery.of(context).size.height;
  double desiredHeight = 0.83 * screenHeight;
  userNRP = nrp;
  favAppHandler.copyFav = [...getFavData(nrp)];
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
                itemCount: appData.length,
                itemBuilder: (context, index) {
                  final data = appData[(index)];
                  // return Text(data.toString());
                  return renderAppListEdit(data, index, context);
                },
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<FavAppHandler>(
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
                      print(favAppHandler.copyFav);
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

Widget renderAppListEdit(data, idx, context) {
  final favAppHandler = Provider.of<FavAppHandler>(context);
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
