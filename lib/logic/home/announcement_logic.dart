import 'package:myits_portal/logic/provider_handler.dart';
import 'package:myits_portal/logic/url_collection.dart';
import 'package:myits_portal/ui/home/announcement_page.dart';
import 'package:provider/provider.dart';

void refetchAnnouncement(context, setState) {
  setState(() {
    announcementPageLoading = true;
  });

  announcementRef.onValue.listen((event) {
    loadData(context, setState);
  });
  setState(() {
    announcementPageLoading = false;
  });
}

Future<void> loadData(context, setState) async {
  final announcementProvider =
      Provider.of<AnnouncementProvider>(context, listen: false);
  await announcementProvider.fetchDataFromAPI();
}
