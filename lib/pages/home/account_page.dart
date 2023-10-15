import 'package:flutter/material.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/pages/profile_setting_page.dart';
import 'package:myits_portal/settings/language_controls.dart';
import 'package:myits_portal/settings/notification_controls.dart';
import 'package:myits_portal/settings/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myits_portal/settings/theme_controls.dart';

class AccountPage extends StatefulWidget {
  final int nrp;

  const AccountPage({super.key, required this.nrp});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    final languageSelector =
        Provider.of<LanguageSelector>(context, listen: false);
    // final themeSelector = Provider.of<ThemeSelector>(context, listen: false);
    final notificationSelector =
        Provider.of<NotificationSelector>(context, listen: false);
    // themeSelector.initTheme();
    languageSelector.initLanguage();
    notificationSelector.initNotifier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBG,
      body: accPage(),
    );
  }

  // -------------- account page handler  --------------

  Widget accPage() {
    String username = getStudData('nama', widget.nrp);
    String jurusan = getStudData('jurusan', widget.nrp);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  height: 135,
                  decoration: BoxDecoration(
                      color: itsBlueShade,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(18))),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 30),
                        child: CircleAvatar(
                            radius: 50,
                            backgroundColor: itsBlue,
                            child: Text(
                              username[0],
                              style:
                                  jakarta.copyWith(fontSize: 66, color: white),
                            )),
                      ),
                      const SizedBox(width: 25),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(username,
                              style:
                                  jakarta.copyWith(color: black, fontSize: 25)),
                          const SizedBox(height: 3),
                          Text(jurusan,
                              style: jakarta.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  color: black)),
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
          SizedBox(
            width: MediaQuery.of(context).size.width - 85,
            child: Wrap(runSpacing: 2, children: [
              darkMode(),
              languageMode(),
              notification(),
              logOut(),
            ]),
          ),
          const Spacer(),
          credit(true),
        ],
      ),
    );
  }

  // -------------- dark mode  --------------

  Widget darkMode() {
    // final themeSelector = Provider.of<ThemeSelector>(context);
    return ListTile(
      leading: Ink(
        height: 35,
        width: 35,
        decoration: const BoxDecoration(
          color: Color.fromARGB(85, 4, 53, 145),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.dark_mode,
          color: itsBlue,
          size: 24,
        ),
      ),
      title: Text(
        'Dark Mode',
        style: jakarta.copyWith(fontWeight: FontWeight.w600, color: black),
      ),
      trailing: Switch(
        // value: themeSelector.isDarkMode,
        value: isDarkMode,
        activeColor: itsBlue,
        onChanged: (bool value) {
          setState(() {
            isDarkMode = value;
            // themeSelector.setThemePref(value);
            // themeSelector.themeChanger(value);
            // Simpan preferensi tema ke SharedPreferences di sini.
          });
        },
        thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return const Icon(
                Icons.dark_mode,
                color: Colors.white,
              );
            }
            return const Icon(Icons.sunny, color: Colors.white);
          },
        ),
      ),
    );
  }

  // -------------- language mode  --------------

  Widget languageMode() {
    final languageSelector = Provider.of<LanguageSelector>(context);
    return ListTile(
        leading: Ink(
          height: 35,
          width: 35,
          decoration: const BoxDecoration(
              color: Color.fromARGB(85, 4, 53, 145), shape: BoxShape.circle),
          child: Icon(
            Icons.translate,
            color: itsBlue,
            size: 20,
          ),
        ),
        title: Text('Language Mode',
            style: jakarta.copyWith(
                fontSize: 14, fontWeight: FontWeight.w600, color: black)),
        trailing: Switch(
          value: languageSelector.isEnglish,
          activeColor: itsBlue,
          onChanged: (bool value) {
            setState(() {
              languageSelector.isEnglish = value;
              languageSelector.setLanguagePref(value);
            });
          },
          activeThumbImage: const AssetImage('assets/icons/en.png'),
          inactiveThumbImage: const AssetImage('assets/icons/id.png'),
        ));
  }

  // -------------- notification --------------

  Widget notification() {
    final notificationSelector = Provider.of<NotificationSelector>(context);
    return ListTile(
        leading: Ink(
          height: 35,
          width: 35,
          decoration: const BoxDecoration(
              color: Color.fromARGB(85, 4, 53, 145), shape: BoxShape.circle),
          child: Icon(
            Icons.notifications_rounded,
            color: itsBlue,
            size: 20,
          ),
        ),
        title: Text('Notifications',
            style: jakarta.copyWith(
                fontSize: 14, fontWeight: FontWeight.w600, color: black)),
        trailing: Switch(
          value: notificationSelector.isNotified,
          activeColor: itsBlue,
          onChanged: (bool value) {
            setState(() {
              notificationSelector.isNotified = value;
              notificationSelector.setNotifierPref(value);
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
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.red)),
      ),
    );
  }

  // -------------- log out handler  --------------

  Future<bool> exitDialog() async {
    return await showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: Text('Are you soure you want to Log out from myITS SSO?',
                  style: jakarta.copyWith(fontSize: 16)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    'Cancel',
                    style: jakarta.copyWith(fontSize: 14, color: itsBlue),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    'Ok',
                    style: jakarta.copyWith(fontSize: 14, color: itsBlue),
                  ),
                ),
              ],
            )));
  }
}
