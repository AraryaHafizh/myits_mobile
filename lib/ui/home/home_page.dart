import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/logic/widgets.dart';
import 'package:myits_portal/logic/home/home_logic.dart';
import 'package:myits_portal/logic/provider_handler.dart';
import 'package:myits_portal/logic/style.dart';
import 'package:myits_portal/ui/home/quick_app_page.dart';
import 'package:provider/provider.dart';

bool homePageLoading = false;

class HomePage extends StatefulWidget {
  final int nrp;

  const HomePage({super.key, required this.nrp});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: homePage(widget.nrp));
  }

  @override
  void initState() {
    super.initState();
    refetchHomePage(context, setState);
  }

  Widget homePage(int nrp) {
    if (homePageLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container(
          margin: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              bannerHandler(context, nrp),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width - 35,
                  decoration: cardsContainer.copyWith(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              showClass(context),
                              showQuickApps(context, nrp)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ));
    }
  }
}

Widget bannerHandler(context, int nrp) {
  final bannerProvider = Provider.of<BannerProvider>(context, listen: false);
  return Center(
    child: SizedBox(
      // width: 375,
      width: MediaQuery.of(context).size.width - 35,
      child: CarouselSlider(
          items: [
            nameBanner(context, nrp),
            ...bannerProvider.data.map((data) => loadBanners(data)).toList(),
          ],
          options: CarouselOptions(
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            autoPlay: true,
            autoPlayCurve: Curves.easeOutQuint,
            autoPlayAnimationDuration: const Duration(seconds: 2),
            viewportFraction: 1,
            height: 120,
          )),
    ),
  );
}

Widget nameBanner(context, int nrp) {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  return Container(
    decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome,',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              Text(userProvider.getStudData('nama', nrp),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w700))
            ]),
        Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userProvider.getStudData('jurusan', nrp),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                'Semester ${userProvider.getStudData('semester', nrp)}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.normal),
              )
            ])
      ],
    ),
  );
}

Widget loadBanners(data) {
  return SizedBox(
    width: double.infinity,
    child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          data,
          fit: BoxFit.cover,
        )),
  );
}

Widget showClass(context) {
  final classProvider = Provider.of<UserClassProvider>(context, listen: false);
  return Column(
    children: [
      Row(
        children: [
          Text('Today\'s Courses',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w800, fontSize: 18)),
        ],
      ),
      const SizedBox(height: 10),
      // show today class -----
      SizedBox(
        height: 204,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: classProvider.data.length,
            itemBuilder: (BuildContext context, index) {
              final data = classProvider.data[(index)];
              return classListBuilder(context, data);
            }),
      ),
    ],
  );
}

Widget classListBuilder(context, data) {
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w900)),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w800)),
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

Widget showQuickApps(context, int nrp) {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Text(bannerData.toString()),
            Text('Quick Apps',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w800, fontSize: 18)),
            const Spacer(),
            editQuickApps(context, nrp)
          ],
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                // childAspectRatio: (3 / 4.7),
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: userProvider.getStudData('favApp', nrp).length + 1,
              itemBuilder: (BuildContext context, index) {
                if (index == userProvider.getStudData('favApp', nrp).length) {
                  return allAppBuilder(context);
                } else {
                  return favAppBuilder(
                      context, userProvider.getStudData('favApp', nrp)[index]);
                }
              },
            ),
          )),
    ],
  );
}

Widget allAppBuilder(context) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      splashColor: const Color.fromARGB(55, 4, 53, 145),
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        showAllApps(context);
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
              'assets/images/allApps.png',
              width: 58,
              height: 58,
            ),
            Text(
              'All Apps',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 11),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget favAppBuilder(context, int idx) {
  final appHandler = Provider.of<AppProvider>(context);
  var getValue = appHandler.data[idx];
  return Material(
    color: Colors.transparent,
    child: InkWell(
      splashColor: const Color.fromARGB(55, 4, 53, 145),
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        await launchURL(getValue['url']);
      },
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              getValue['gambar'],
              width: 41,
              height: 41,
            ),
            const SizedBox(height: 10),
            Text(
              getValue['nama'],
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
