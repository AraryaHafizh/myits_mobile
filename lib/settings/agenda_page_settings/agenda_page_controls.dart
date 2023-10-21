import 'package:flutter/material.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/settings/style.dart';

// -------------- agenda page skeleton  --------------
Widget showAgenda(context, data) {
  return Expanded(
    child: FutureBuilder<void>(
      future: data,
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (3 / 3.7),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            itemBuilder: ((BuildContext context, index) {
              final data = dataAgenda[(index + 1).toString()];
              return agendaList(context, data);
            }),
          );
        }
      },
    ),
  );
}

// -------------- agenda list  --------------
agendaList(context, data) {
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: cardsContainer.copyWith(
      color: Theme.of(context).colorScheme.secondaryContainer,
    ),
    child: InkWell(
      onTap: () {
        print('${data['title']} ditekan!');
        dialogBox(context, data);
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
                      color:
                          Theme.of(context).navigationBarTheme.indicatorColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    data['date'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 9),
                  )),
              const SizedBox(height: 2),
              Text(data['title'],
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 14),
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
                      .copyWith(fontSize: 10, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// -------------- dialog box handler  --------------
dialogBox(context, data) {
  // print(data);
  return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            height: MediaQuery.of(context).size.height * 0.6,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(data['image']),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data['title'],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data['desc'],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w200),
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
