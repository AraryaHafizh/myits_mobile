import 'package:flutter/material.dart';
import 'package:myits_portal/settings/agenda_page_settings/agenda_page_controls.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/settings/style.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AgendaPage> {
  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    loadData = loadDataAgenda();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: agendaPage());
  }

  Widget agendaPage() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 35,
        margin: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child:
                  Text('Agenda', style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 20),
            showAgenda(context, loadData)
          ],
        ),
      ),
    );
  }
}
