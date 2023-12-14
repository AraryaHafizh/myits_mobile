import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/logic/widgets.dart';
import 'package:myits_portal/logic/home/agenda_logic.dart';
import 'package:myits_portal/logic/provider_handler.dart';
import 'package:myits_portal/logic/style.dart';
import 'package:provider/provider.dart';

bool agendaPageLoading = false;

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: agendaPage());
  }

  @override
  void initState() {
    super.initState();
    refetchAgenda(context, setState);
  }

  Widget agendaPage() {
    final agendaProvider = Provider.of<AgendaProvider>(context, listen: false);
    if (agendaPageLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
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
              Expanded(
                  child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: agendaProvider.data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (3 / 3.7),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemBuilder: ((BuildContext context, index) {
                  final data = agendaProvider.data[(index)];
                  return agendaListBuilder(context, data);
                }),
              ))
            ],
          ),
        ),
      );
    }
  }
}

agendaListBuilder(context, data) {
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: cardsContainer.copyWith(
      color: Theme.of(context).colorScheme.secondaryContainer,
    ),
    child: InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        dialogBox(context, data);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                data['thumbnail'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              decoration: BoxDecoration(
                  color: Theme.of(context).navigationBarTheme.indicatorColor,
                  borderRadius: BorderRadius.circular(6)),
              child: Text(
                data['date'],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 9, fontWeight: FontWeight.w900),
              )),
          const SizedBox(height: 2),
          Text(data['title'],
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 14),
              overflow: TextOverflow.ellipsis),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 1, bottom: 3),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSecondary,
                      width: 1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  data['tags'],
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 10, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

dialogBox(context, data) {
  return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  data['image'] is List
                      ? SizedBox(
                          // height: 220,
                          width: MediaQuery.of(context).size.width - 25,
                          child: CarouselSlider.builder(
                            itemCount: data['image'].length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewIndex) =>
                                ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                data['image'][itemIndex],
                                fit: BoxFit.cover,
                              ),
                            ),
                            options: CarouselOptions(
                                enableInfiniteScroll: false,
                                viewportFraction: 1,
                                height: 350),
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(data['image']),
                        ),
                  const SizedBox(height: 10),
                  Text(
                    data['title'],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data['desc'],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await launchURL(data['source']);
                        },
                        child: const Text(
                          'More Information',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }));
}
