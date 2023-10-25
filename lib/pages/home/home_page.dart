import 'package:flutter/material.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/pages/home/account_page.dart';
import 'package:myits_portal/pages/home/agenda_page.dart';
import 'package:myits_portal/pages/home/announcement_page.dart';
import 'package:myits_portal/pages/login/login_page.dart';
import 'package:myits_portal/settings/home_page_settings/home_page_controls.dart';
import 'package:myits_portal/settings/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  late Future<void> loadClass;

  Future<void> getBannerData() async {
    final bannerResponse = await dio.get(
        bannerURL);
    if (bannerResponse.statusCode == 200) {
      setState(() {
        bannerData = bannerResponse.data;
      });
    } else {
      debugPrint('Gagal mengambil data dari API');
    }
  }

  Future<void> getAppData() async {
    final appResponse = await dio.get(
        appURL);
    if (appResponse.statusCode == 200) {
      setState(() {
        appData = appResponse.data;
      });
    } else {
      debugPrint('Gagal mengambil data dari API');
    }
  }

  Future<void> getMhsData() async {
    final mhsResponse = await dio.get(
        mhsURL);
    if (mhsResponse.statusCode == 200) {
      setState(() {
        mhsData = mhsResponse.data;
      });
    } else {
      debugPrint('Gagal mengambil data dari API');
    }
  }

  Future<void> getAnnouncementData() async {
    final announcementResponse = await dio.get(
        announcementURL);
    if (announcementResponse.statusCode == 200) {
      setState(() {
        announcementData = announcementResponse.data;
      });
    } else {
      debugPrint('Gagal mengambil data dari API');
    }
  }

  Future<void> getAgendaData() async {
    final agendaResponse = await dio.get(
        agendaURL);
    if (agendaResponse.statusCode == 200) {
      setState(() {
        agendaData = agendaResponse.data;
      });
    } else {
      debugPrint('Gagal mengambil data dari API');
    }
  }

  @override
  void initState() {
    super.initState();
    loadClass = loadDataClass();
    // loadBanner = loadDataBanner();
    getBannerData();
    getAppData();
    getMhsData();
    getAnnouncementData();
    getAgendaData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 510,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          // backgroundColor: Theme.of(context).colorScheme.background,
          appBar: appBarHandler(context),
          body: FutureBuilder<bool>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getBool('islogin') ?? false),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final isLogin = snapshot.data ?? false;
                if (isLogin) {
                  return FutureBuilder<int>(
                      future: SharedPreferences.getInstance()
                          .then((prefs) => prefs.getInt('nrp')!),
                      builder: (context, nrpSnapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError ||
                            nrpSnapshot.data == null) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Error: ${nrpSnapshot.error}'),
                            ],
                          );
                        } else {
                          final nrp = nrpSnapshot.data!;

                          // return Text(nrp.toString());
                          return <Widget>[
                            homePage(nrp),
                            const AgendaPage(),
                            const Announcement(),
                            AccountPage(
                              nrp: nrp,
                            ),
                          ][currentPageIndex];
                        }
                      });
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Your session is expired.'),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) =>
                                    const LoginPage(), // Arahkan ke LoginPage
                              ));
                            },
                            child: const Text('Login'))
                      ],
                    ),
                  );
                }
              }
            },
          ),
          bottomNavigationBar: navBar(),
          floatingActionButton: msgButton(context),
        ),
      ),
    );
  }

  // -------------- home screen  --------------
  Widget homePage(int nrp) {
    return Container(
        margin: const EdgeInsets.only(top: 25),
        child: FutureBuilder(
            future: Future.wait([loadClass]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error ${snapshot.error}'));
              } else {
                return Column(
                  children: [
                    // show banner -----
                    bannerHandler(context, nrp),
                    const SizedBox(height: 20),
                    // Container housing today class and app launcher -----
                    Container(
                      width: MediaQuery.of(context).size.width - 35,
                      height: MediaQuery.of(context).size.height - 325,
                      decoration: cardsContainer.copyWith(
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: Column(
                            children: [
                              todayClass(context),
                              // homeCarousel(context),
                              const SizedBox(height: 5),
                              appShelf(context, nrp),
                            ],
                          )),
                    )
                  ],
                );
              }
            }));
  }

  // -------------- bottom navbar handler  --------------
  Widget navBar() {
    return NavigationBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      indicatorColor: Theme.of(context).navigationBarTheme.indicatorColor,
      shadowColor: Theme.of(context).navigationBarTheme.indicatorColor,
      selectedIndex: currentPageIndex,
      destinations: <Widget>[
        NavigationDestination(
          selectedIcon:
              Icon(Icons.school, color: Theme.of(context).iconTheme.color),
          icon: Icon(
            Icons.school_outlined,
            color: Theme.of(context).iconTheme.color,
          ),
          label: 'home',
        ),
        NavigationDestination(
          selectedIcon:
              Icon(Icons.view_agenda, color: Theme.of(context).iconTheme.color),
          icon: Icon(
            Icons.view_agenda_outlined,
            color: Theme.of(context).iconTheme.color,
          ),
          label: 'Agenda',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.notifications,
              color: Theme.of(context).iconTheme.color),
          icon: Icon(
            Icons.notifications_none,
            color: Theme.of(context).iconTheme.color,
          ),
          label: 'announcements',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.account_circle_rounded,
              color: Theme.of(context).iconTheme.color),
          icon: Icon(
            Icons.account_circle_outlined,
            color: Theme.of(context).iconTheme.color,
          ),
          label: 'account',
        ),
      ],
    );
  }
}
