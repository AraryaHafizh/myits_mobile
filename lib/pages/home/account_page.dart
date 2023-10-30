import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/pages/edit_profile_page.dart';
import 'package:myits_portal/settings/provider_controls.dart';
import 'package:myits_portal/settings/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:myits_portal/settings/theme_controls.dart';

class AccountPage extends StatefulWidget {
  final int nrp;

  const AccountPage({super.key, required this.nrp});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool languageVal = true;
  bool notifVal = true;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: bodyPage(),
    );
  }

  @override
  void initState() {
    super.initState();
    refetch();
  }

  void refetch() {
    final databaseRef =
        FirebaseDatabase.instance.ref().child('data/-NhZvIHt6AKiTb-zQDnn');
    databaseRef.onValue.listen((event) {
      loadData();
    });
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = false;
    });

    final mhsProvider = Provider.of<MhsDataProvider>(context, listen: false);
    await mhsProvider.fetchDataFromAPI();

    setState(() {
      isLoading = true;
    });
  }

  Widget bodyPage() {
    final mhsHandler = Provider.of<MhsDataProvider>(context, listen: false);
    String username = mhsHandler.getStudData('nama', widget.nrp);
    String jurusan = mhsHandler.getStudData('jurusan', widget.nrp);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      child: Column(
        children: [
          // account info and edit button
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  height: 135,
                  decoration: BoxDecoration(
                      color:
                          Theme.of(context).navigationBarTheme.indicatorColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(18))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                          radius: 50,
                          backgroundColor: itsBlue,
                          child: Text(
                            username[0],
                            style: jakarta.copyWith(fontSize: 66, color: white),
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(username,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 24)),
                          const SizedBox(height: 5),
                          Text(jurusan,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(nrp: widget.nrp),
                      ),
                    );
                    debugPrint('edit profil ditekan!');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: itsBlue,
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 45)),
                  child: Text(
                    'Edit Profile',
                    style: jakarta.copyWith(fontSize: 14, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 55),
          // app options
          SizedBox(
            width: MediaQuery.of(context).size.width - 85,
            child: Wrap(runSpacing: 2, children: [
              // darkMode(),
              languageMode(),
              notification(),
              logOut(),
            ]),
          ),
          const Spacer(),
          credit(true, context),
        ],
      ),
    );
  }

  // -------------- dark mode  --------------

  // Widget darkMode() {
  //   final themeSelector = Provider.of<ThemeSelector>(context);
  //   return ListTile(
  //     leading: Ink(
  //       height: 35,
  //       width: 35,
  //       decoration: BoxDecoration(
  //         color: Theme.of(context).navigationBarTheme.indicatorColor,
  //         shape: BoxShape.circle,
  //       ),
  //       child: Icon(
  //         Icons.dark_mode,
  //         color: Theme.of(context).colorScheme.primary,
  //         size: 24,
  //       ),
  //     ),
  //     title: Text(
  //       'Dark Mode',
  //       style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 14),
  //     ),
  //     trailing: Switch(
  //       value: themeSelector.isDarkMode,
  //       activeColor: Theme.of(context).colorScheme.primary,
  //       inactiveThumbColor: Theme.of(context).colorScheme.onPrimary,
  //       onChanged: (bool value) {
  //         setState(() {
  //           themeSelector.isDarkMode = value;
  //           themeSelector.setThemePref(value);
  //         });
  //       },
  //       thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
  //         (Set<MaterialState> states) {
  //           if (states.contains(MaterialState.selected)) {
  //             return const Icon(
  //               Icons.dark_mode,
  //               color: Colors.white,
  //             );
  //           }
  //           return const Icon(Icons.sunny, color: Colors.white);
  //         },
  //       ),
  //     ),
  //   );
  // }

  // -------------- language mode  --------------

  Widget languageMode() {
    return ListTile(
        leading: Ink(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Theme.of(context).navigationBarTheme.indicatorColor,
              shape: BoxShape.circle),
          child: Icon(
            Icons.translate,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
        title: Text('Language Mode',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w600)),
        trailing: Switch(
          value: languageVal,
          activeColor: Theme.of(context).colorScheme.primary,
          inactiveThumbColor: Theme.of(context).colorScheme.onPrimary,
          onChanged: (bool value) {
            setState(() {
              languageVal = false;
            });
            Future.delayed(const Duration(milliseconds: 300), () {
              wipAlertDialog(context);
              setState(() {
                languageVal = true;
              });
            });
          },
          activeThumbImage: const AssetImage('assets/icons/en.png'),
          inactiveThumbImage: const AssetImage('assets/icons/id.png'),
        ));
  }

  // -------------- notification --------------

  Widget notification() {
    return ListTile(
        leading: Ink(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Theme.of(context).navigationBarTheme.indicatorColor,
              shape: BoxShape.circle),
          child: Icon(
            Icons.notifications_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
        title: Text('Notifications',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w600)),
        trailing: Switch(
          value: notifVal,
          activeColor: Theme.of(context).colorScheme.primary,
          inactiveThumbColor: Theme.of(context).colorScheme.onPrimary,
          onChanged: (bool value) {
            setState(() {
              notifVal = false;
            });
            Future.delayed(const Duration(milliseconds: 300), () {
              wipAlertDialog(context);
              setState(() {
                notifVal = true;
              });
            });
          },
          thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return const Icon(
                  Icons.notifications_on,
                  color: Colors.white,
                );
              }
              return const Icon(Icons.notifications_off, color: Colors.white);
            },
          ),
        ));
  }

  // -------------- log out --------------

  Widget logOut() {
    return InkWell(
      splashColor: Colors.red.shade200,
      highlightColor: Colors.red.shade100,
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        bool goingToExit = await exitDialog();
        if (goingToExit) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('nrp');
          await prefs.remove('islogin');
          await prefs.remove('isDarkMode');
          await prefs.remove('isEnglish');
          await prefs.remove('isNotified');
          Navigator.pushReplacementNamed(context, '/login');
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      },
      child: ListTile(
        leading: Ink(
          height: 35,
          width: 35,
          decoration: const BoxDecoration(
              color: Color.fromARGB(85, 244, 67, 54), shape: BoxShape.circle),
          child: const Icon(
            Icons.logout_outlined, // Ganti dengan ikon yang Anda inginkan
            color: Colors.red, // Warna ikon
            size: 20, // Ukuran ikon
          ),
        ),
        title: Text('Log Out',
            style: jakarta.copyWith(
                fontSize: 17, fontWeight: FontWeight.w600, color: Colors.red)),
      ),
    );
  }

  // -------------- log out handler  --------------

  Future<bool> exitDialog() async {
    return await showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: Text('Are you soure you want to Log out from myITS SSO?',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 17, fontWeight: FontWeight.w600)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Ok'),
                ),
              ],
            )));
  }
}
