import 'package:flutter/material.dart';
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
    return Scaffold(backgroundColor: defaultBG, body: agendaPage());
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
              child: Text(
                'Agenda',
                style: jakarta.copyWith(fontSize: 25, color: black),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<void>(
                future: loadData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: dataAgenda.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (3 / 3.7),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: ((BuildContext context, index) {
                        final data = dataAgenda[(index + 1).toString()];
                        return agendaList(data);
                      }),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  agendaList(data) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: cardsContainer.copyWith(color: white),
      child: InkWell(
        onTap: () {
          print('${data['title']} ditekan!');
          dialogBox(data);
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                data['thumbnail'],
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    decoration: BoxDecoration(
                        color: itsBlueShadeStatic,
                        borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      data['date'],
                      style:
                          jakarta.copyWith(fontSize: 9, color: itsBlueStatic),
                    )),
                const SizedBox(height: 2),
                Text(data['title'],
                    style: jakarta.copyWith(fontSize: 14, color: black),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 5),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: black, width: 1),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    data['tags'],
                    style: jakarta.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                      color: black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  dialogBox(data) {
    // print(data);
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: defaultBG,
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(data['image']),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data['title'],
                      style: jakarta.copyWith(fontSize: 18, color: black),
                    ),
                    Text(
                      data['desc'],
                      style: jakartaSub.copyWith(color: black38),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Close',
                            style: jakarta.copyWith(fontSize: 12, color: black),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await launchURL(data['source']);
                          },
                          child: Text(
                            'More Information',
                            style: jakarta.copyWith(fontSize: 12, color: black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // actions: [

            // ],
          );
        }));
  }
}
