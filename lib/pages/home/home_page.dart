import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/settings/fav_app_controls.dart';
import 'package:myits_portal/pages/home/account_page.dart';
import 'package:myits_portal/pages/home/agenda_page.dart';
import 'package:myits_portal/pages/home/announcement_page.dart';
import 'package:myits_portal/pages/login/login_page.dart';
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
  late Future<void> loadApp;
  late Future<void> loadBanner;
  late Future<void> loadMhs;

  @override
  void initState() {
    super.initState();
    loadClass = loadDataClass();
    loadApp = loadDataApp();
    loadBanner = loadDataBanner();
    loadMhs = loadDataMhs();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 510,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          // backgroundColor: Theme.of(context).colorScheme.background,
          appBar: appBarHandler(),
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

  // -------------- appbar handler  --------------

  appBarHandler() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: false,
      title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 9),
          child: Row(
            children: [
              Image.asset(
                'assets/images/myits_w.png',
                width: 65,
                height: 65,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ],
          )),
    );
  }

  // -------------- home screen  --------------

  Widget homePage(int nrp) {
    // final isFav = Provider.of<TappedState>(context);
    return Container(
        margin: const EdgeInsets.only(top: 25),
        child: FutureBuilder(
            future: Future.wait([loadClass, loadApp, loadBanner, loadMhs]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error ${snapshot.error}'));
              } else {
                return Column(
                  children: [
                    // show banner -----
                    Center(
                      child: SizedBox(
                        // width: 375,
                        width: MediaQuery.of(context).size.width - 35,
                        child: CarouselSlider(
                            items: [
                              nameCard(nrp, context),
                              ...dataBanner
                                  .map((data) => loadBanners(data))
                                  .toList(),
                            ],
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              autoPlay: true,
                              autoPlayCurve: Curves.easeOutQuint,
                              autoPlayAnimationDuration:
                                  const Duration(seconds: 2),
                              viewportFraction: 1,
                              height: 120,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // container for today class and app drawer -----
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Today Classes',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18)),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // show today class -----
                              SizedBox(
                                height: 204,
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: dataClass.length,
                                    itemBuilder: (BuildContext context, index) {
                                      final data =
                                          dataClass[(index + 1).toString()];
                                      return classList(data);
                                    }),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Quick Apps',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18)),
                                    const Spacer(),
                                    InkWell(
                                        onTap: () {
                                          debugPrint('tomnol ditekan');
                                          botSheetEdit(nrp, context)
                                              .then((value) {
                                            userNRP = nrp;
                                          });
                                          // print(getStudData('favApp', nrp)
                                          //     .toString());
                                        },
                                        child: Text('Edit >',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w900)))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              // show app drawer -----
                              SizedBox(
                                  height: (MediaQuery.of(context).size.height -
                                      658),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: (3 / 4),
                                        // childAspectRatio: (320 / 500),
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.0,
                                        mainAxisSpacing: 5.0,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: getFavData(nrp).length + 1,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        if (index == getFavData(nrp).length) {
                                          return openAll();
                                        } else {
                                          return appListMaker(
                                              getFavData(nrp)[index], context);
                                        }
                                      },
                                    ),
                                  )),
                            ],
                          )),
                    )
                  ],
                );
              }
            }));
  }

  // -------------- apps handler --------------

  // open all merupakan shortcut untuk membuka appDrawer()
  Widget openAll() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: const Color.fromARGB(55, 4, 53, 145),
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          botSheet();
          debugPrint('All Apps ditekan!');
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/appLogos/allApps.png',
                width: 58,
                height: 58,
              ),
              Text(
                'All Apps',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // menampilkan bottomsheet
  Future botSheet() {
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
                  return appByTag(tag);
                }).toList(),
              ),
            ),
          );
        }));
  }

  // menampilkan seluruh daftar aplikasi berdasarkan tags
  Widget appByTag(tags) {
    List<String> appKeys = dataApplication.keys.where((key) {
      return dataApplication[key]['tags'] == tags;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tags,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w900, fontSize: 16),
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
            itemCount: appKeys.length,
            itemBuilder: (BuildContext context, index) {
              int idx = int.parse(appKeys[index]);
              // debugPrint(idx.toString());
              return appListMaker(idx, context);
            },
          ),
        ),
      ],
    );
  }

  // -------------- today class handler  --------------

  Widget classList(data) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(data['time'],
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text('WIB', style: Theme.of(context).textTheme.bodySmall)
                ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
              color: Theme.of(context).colorScheme.primaryContainer,
            ))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${data['class']}',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(data['room'],
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(data['lecture'],
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ]),
          )
        ],
      ),
    );
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
