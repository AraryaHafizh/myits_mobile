import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/settings/agenda_page_settings/agenda_page_controls.dart';
import 'package:myits_portal/settings/provider_controls.dart';
import 'package:provider/provider.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AgendaPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: agendaPage());
  }

  @override
  void initState() {
    super.initState();
    refetch();
  }

  void refetch() {
    final databaseRef =
        FirebaseDatabase.instance.ref().child('data/-NhZw49cbFF1L7zJIE5B');
    databaseRef.onValue.listen((event) {
      loadData();
    });
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = false;
    });
    final agendaProvider =
        Provider.of<AgendaDataProvider>(context, listen: false);
    agendaProvider.fetchDataFromAPI();
    setState(() {
      isLoading = true;
    });
  }

  Widget agendaPage() {
    if (isLoading) {
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 35,
          margin: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text('Agenda',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 20),
              showAgenda(context)
            ],
          ),
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
