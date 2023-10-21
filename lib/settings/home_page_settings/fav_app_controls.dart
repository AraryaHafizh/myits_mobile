import 'package:flutter/material.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/settings/style.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
int userNRP = 0;

Widget editFavApp(context, nrp) {
  return InkWell(
      onTap: () {
        debugPrint('tomnol ditekan');
        botSheetEdit(context, nrp).then((value) {
          userNRP = nrp;
        });
        // print(getStudData('favApp', nrp)
        //     .toString());
      },
      child: Text('Edit',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w900)));
}

// Future<void> loadFavApp() async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setStringList('favApp', favApp.map((e) => e.toString()).toList());
// }
List favApp = getFavData(userNRP);
// List favApp = [];

class TappedState extends ChangeNotifier {
  List favAppTemp = List<int>.from(favApp);
  // List favAppTemp = [];

  int get favLen => favAppTemp.length;

  bool isFav(idx) {
    return favAppTemp.contains(idx);
  }

  // List<int> getFav() {
  //   return favAppTemp;
  // }

  void toggleTap(idx) {
    if (isFav(idx)) {
      favAppTemp.remove(idx);
    } else {
      favAppTemp.add(idx);
    }
    notifyListeners();
  }

  void eraseOne(idx) {
    favAppTemp.remove(idx);
    notifyListeners();
  }

  void resetFav() {
    // print('temp $favAppTemp');
    // print('ori $favApp');
    favAppTemp = List<int>.from(favApp);
    // print('temp $favAppTemp');
    // print('ori $favApp');
    notifyListeners();
  }

  // void saveFav() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   favApp = List<int>.from(favAppTemp);
  //   prefs.setStringList('favApp', favApp.map((app) => app.toString()).toList());
  //   notifyListeners();
  // }
}

List getFavData(nrp) {
  List data = getStudData('favApp', nrp);
  // print(data);
  return data;
}

// menampilkan bottomsheet
Future botSheetEdit(context, nrp) async {
  double screenHeight = MediaQuery.of(context).size.height;
  double desiredHeight = 0.83 * screenHeight;
  // final tappedState = Provider.of<TappedState>(context, listen: false);
  // return Text(getFavData(nrp).toString());
  userNRP = nrp;
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
                itemCount: dataApplication.length,
                itemBuilder: (context, index) {
                  final data = dataApplication[(index + 1).toString()];
                  return appListEdit(data, index + 1, context);
                  // print(userNRP);
                  // return Text(favAppTemp.toString());
                },
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<TappedState>(
                    builder: (context, tappedState, child) {
                      return Text('${tappedState.favLen} Selected');
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // tappedState.resetFav();
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
                      // tappedState.saveFav();
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

Widget appListEdit(data, idx, context) {
  final tappedState = Provider.of<TappedState>(context, listen: false);
  final isFav = Provider.of<TappedState>(context).isFav(idx);
  final maxLen = tappedState.favLen < 8;
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
        color: isFav ? itsBlue.withAlpha(100) : Colors.transparent,
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        if (maxLen) {
          tappedState.toggleTap(idx);
          // print('${data['nama']} tertekan');
        } else {
          tappedState.eraseOne(idx);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            Image.asset(data['gambar'], height: 35),
            Text(data['nama']),
          ],
        ),
      ),
    ),
  );
}
