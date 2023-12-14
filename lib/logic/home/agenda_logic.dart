import 'package:myits_portal/logic/provider_handler.dart';
import 'package:myits_portal/logic/url_collection.dart';
import 'package:myits_portal/ui/home/agenda_page.dart';
import 'package:provider/provider.dart';

void refetchAgenda(context, setState) async {
  setState(() {
    agendaPageLoading = true;
  });
  agendaRef.onValue.listen((event) {
    loadData(context, setState);
  });
  setState(() {
    agendaPageLoading = false;
  });
}

Future<void> loadData(context, setState) async {
  final agendaProvider = Provider.of<AgendaProvider>(context, listen: false);
  await agendaProvider.fetchDataFromAPI();
}
