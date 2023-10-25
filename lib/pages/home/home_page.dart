import 'package:flutter/material.dart';
import 'package:myits_portal/pages/sessions_exp_page.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/pages/home/account_page.dart';
import 'package:myits_portal/pages/home/agenda_page.dart';
import 'package:myits_portal/pages/home/announcement_page.dart';
import 'package:myits_portal/settings/home_page_settings/home_page_controls.dart';
import 'package:myits_portal/settings/provider_controls.dart';
import 'package:myits_portal/settings/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final mhsProvider = Provider.of<MhsDataProvider>(context, listen: false);
    final appProvider = Provider.of<AppDataProvider>(context, listen: false);
    final classProvider =
        Provider.of<ClassDataProvider>(context, listen: false);
    final announceProvider =
        Provider.of<AnnounceDataProvider>(context, listen: false);
    final agendaProvider =
        Provider.of<AgendaDataProvider>(context, listen: false);
    final bannerProvider =
        Provider.of<BannerDataProvider>(context, listen: false);
    final futures = [
      mhsProvider.fetchDataFromAPI(),
      appProvider.fetchDataFromAPI(),
      classProvider.fetchDataFromAPI(),
      announceProvider.fetchDataFromAPI(),
      agendaProvider.fetchDataFromAPI(),
      bannerProvider.fetchDataFromAPI(),
    ];

    try {
      await Future.wait(futures);
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 510,
        child: Scaffold(
          body: FutureBuilder<bool>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getBool('islogin') ?? false),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print('error: ${snapshot.error}');
                return Text('');
              } else if (isLoading) {
                return Container(
                  color: itsBlueStatic,
                  child: Center(
                    child: Image.asset('assets/images/its.png', width: 83),
                  ),
                );
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
                          print('error: ${snapshot.error}');
                          return Text('');
                        } else {
                          final nrp = nrpSnapshot.data!;

                          return Scaffold(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            appBar: appBarHandler(context),
                            body: <Widget>[
                              homePage(nrp),
                              const AgendaPage(),
                              const Announcement(),
                              AccountPage(
                                nrp: nrp,
                              ),
                            ][currentPageIndex],
                            bottomNavigationBar: navBar(),
                            floatingActionButton: msgButton(context),
                          );
                        }
                      });
                } else {
                  return SessionExp();
                }
              }
            },
          ),
        ),
      ),
    );
  }

  // -------------- home screen  --------------
  Widget homePage(int nrp) {
    return Container(
        margin: const EdgeInsets.only(top: 25),
        child: Column(
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
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
        ));
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
