import 'package:flutter/material.dart';
import 'package:myits_portal/logic/widgets.dart';
import 'package:myits_portal/logic/home/home_logic.dart';
import 'package:myits_portal/logic/style.dart';
import 'package:myits_portal/ui/home/account_page.dart';
import 'package:myits_portal/ui/home/agenda_page.dart';
import 'package:myits_portal/ui/home/announcement_page.dart';
import 'package:myits_portal/ui/home/home_page.dart';

bool homeLoading = false;

class Home extends StatefulWidget {
  final int nrp;
  const Home({super.key, required this.nrp});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    initFetch(context, setState);
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeLoading
          ? Container(
              color: itsBlueStatic,
              child: Center(
                child: SizedBox(
                  width: 78,
                  height: 78,
                  child: Image.asset('assets/images/its.png'),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: appBarHandler(),
              body: <Widget>[
                HomePage(nrp: widget.nrp),
                const AgendaPage(),
                const Announcement(),
                AccountPage(nrp: widget.nrp),
              ][currentPageIndex],
              bottomNavigationBar: navBar(),
              floatingActionButton: msgButton(context, widget.nrp),
            ),
    );
  }

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
