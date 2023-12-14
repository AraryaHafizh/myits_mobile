import 'package:myits_portal/logic/provider_handler.dart';
import 'package:myits_portal/logic/url_collection.dart';
import 'package:myits_portal/ui/home/home.dart';
import 'package:myits_portal/ui/home/home_page.dart';
import 'package:provider/provider.dart';

void refetchHomePage(context, setState) {
  userRef.onValue.listen((event) {
    loadData(context, setState);
  });
}

Future<void> loadData(context, setState) async {
  setState(() {
    homePageLoading = true;
  });

  final userProvider = Provider.of<UserProvider>(context, listen: false);
  await userProvider.fetchDataFromAPI();

  setState(() {
    homePageLoading = false;
  });
}

Future<void> initFetch(context, setState) async {
  setState(() {
    homeLoading = true;
  });
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final appProvider = Provider.of<AppProvider>(context, listen: false);
  final classProvider = Provider.of<UserClassProvider>(context, listen: false);
  final announcementProvider =
      Provider.of<AnnouncementProvider>(context, listen: false);
  final agendaProvider = Provider.of<AgendaProvider>(context, listen: false);
  final bannerProvider = Provider.of<BannerProvider>(context, listen: false);

  await userProvider.fetchDataFromAPI();
  await appProvider.fetchDataFromAPI();
  await classProvider.fetchDataFromAPI();
  await announcementProvider.fetchDataFromAPI();
  await agendaProvider.fetchDataFromAPI();
  await bannerProvider.fetchDataFromAPI();

  setState(() {
    homeLoading = false;
  });
}
