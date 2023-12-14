import 'package:myits_portal/logic/provider_handler.dart';
import 'package:myits_portal/logic/url_collection.dart';
import 'package:myits_portal/ui/home/account_page.dart';
import 'package:provider/provider.dart';

void refetchAcc(context, setState) {
  userRef.onValue.listen((event) {
    loadData(context, setState);
  });
}

Future<void> loadData(context, setState) async {
  setState(() {
    accountPageLoading = false;
  });

  final userProvider = Provider.of<UserProvider>(context, listen: false);
  await userProvider.fetchDataFromAPI();

  setState(() {
    accountPageLoading = true;
  });
}
