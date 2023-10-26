import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/settings/home_page_settings/home_page_controls.dart';
import 'package:myits_portal/settings/provider_controls.dart';
import 'package:myits_portal/settings/style.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final int nrp;

  const HomePage({super.key, required this.nrp});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: homePage(widget.nrp));
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

  Widget homePage(int nrp) {
    if (isLoading) {
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
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
