import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/settings/home_page_settings/fav_app_controls.dart';
import 'package:myits_portal/settings/provider_controls.dart';
import 'package:provider/provider.dart';

// -------------- appbar handler  --------------
appBarHandler(context) {
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

// -------------- banner handler --------------
Widget bannerHandler(context, int nrp) {
  final bannerProvider =
      Provider.of<BannerDataProvider>(context, listen: false);
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
  final mhsHandler = Provider.of<MhsDataProvider>(context, listen: false);
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
              Text(mhsHandler.getStudData('nama', nrp),
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
                mhsHandler.getStudData('jurusan', nrp),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                'Semester ${mhsHandler.getStudData('semester', nrp)}',
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

// -------------- carousel (WIP) --------------
// Widget homeCarousel(context) {
//   return CarouselSlider(
//       items: [todayClass(context), reminder(context)],
//       options: CarouselOptions(
//         viewportFraction: 1,
//         height: 255,
//       ));
// }

// -------------- class list --------------
Widget todayClass(context) {
  final classProvider = Provider.of<ClassDataProvider>(context, listen: false);
  return Column(
    children: [
      Row(
        children: [
          Text('Today Classes',
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
              return classList(context, data);
            }),
      ),
    ],
  );
}

Widget classList(context, data) {
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

// -------------- reminder (WIP) --------------
// Widget reminder(context) {
//   return Padding(
//     padding: const EdgeInsets.only(right: 10),
//     child: Column(
//       children: [
//         Row(
//           children: [
//             Text('Reminder',
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodySmall!
//                     .copyWith(fontWeight: FontWeight.w900, fontSize: 18)),
//             const Spacer(),
//             InkWell(
//                 onTap: () {
//                   debugPrint('tertekan');
//                 },
//                 child: Text('See all',
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodySmall!
//                         .copyWith(fontWeight: FontWeight.w900)))
//           ],
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 204,
//           child: ListView.builder(
//               padding: EdgeInsets.zero,
//               shrinkWrap: true,
//               itemCount: 1,
//               itemBuilder: (BuildContext context, index) {
//                 // return classList(data, context);
//               }),
//         ),
//       ],
//     ),
//   );
// }

// -------------- app shelf --------------
Widget appShelf(context, int nrp) {
  final mhsHandler = Provider.of<MhsDataProvider>(context, listen: false);
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
            openEditFavApp(context, nrp)
          ],
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
          height: (MediaQuery.of(context).size.height - 658),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (3 / 4.7),
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: mhsHandler.getStudData('favApp', nrp).length + 1,
              itemBuilder: (BuildContext context, index) {
                if (index == mhsHandler.getStudData('favApp', nrp).length) {
                  return openAll(context);
                } else {
                  return renderApp(
                      context, mhsHandler.getStudData('favApp', nrp)[index]);
                }
              },
            ),
          )),
    ],
  );
}

Widget openAll(context) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      splashColor: const Color.fromARGB(55, 4, 53, 145),
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        botSheet(context);
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

Future botSheet(context) {
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
                // return Text(tag);
                return appByTag(context, tag);
              }).toList(),
            ),
          ),
        );
      }));
}

List<String> getTags(context) {
  final appHandler = Provider.of<AppDataProvider>(context, listen: false);
  List<String> appTags = [];
  for (var items in appHandler.data) {
    if (items['tags'] == 'Aset, Arsip dan Perkantoran') {
      appTags.add('Aset, Arsip dan Perkantoran');
    } else {
      appTags.add(items['tags']);
    }
  }
  appTags = appTags.toSet().toList();
  // print(appTags);
  return appTags;
}

Widget appByTag(context, String tags) {
  final appHandler = Provider.of<AppDataProvider>(context, listen: false);
  List<int> appIdx = [];
  for (var items in appHandler.data) {
    if (items['tags'] == tags) {
      appIdx.add(appHandler.data.indexOf(items));
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        tags,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.w800, fontSize: 19),
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
          itemCount: appIdx.length,
          itemBuilder: (BuildContext context, index) {
            return renderApp(context, appIdx[index]);
          },
        ),
      ),
    ],
  );
}

Widget renderApp(context, int idx) {
  final appHandler = Provider.of<AppDataProvider>(context);
  var getValue = appHandler.data[idx];
  return Material(
    color: Colors.transparent,
    child: InkWell(
      splashColor: const Color.fromARGB(55, 4, 53, 145),
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        await launchURL(getValue['url']);
        debugPrint('${getValue['nama']} ditekan!');
      },
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 5),
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
