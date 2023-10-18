import 'package:flutter/material.dart';
import 'package:myits_portal/settings/style.dart';

class OpenChat extends StatelessWidget {
  const OpenChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(top: 55, left: 15, right: 15, bottom: 12),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/its_main.png',
                  height: 40,
                  width: 40,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DPTSI ITS',
                      style: jakarta.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Online',
                      style: jakarta.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w100,
                          color: Colors.green),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton.filledTonal(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close_rounded,
                        color: Theme.of(context).colorScheme.onPrimary))
              ],
            ),
          ),
          const Divider(),
          const Spacer(),
          const Divider(),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.attach_file,
                    color: Colors.blue,
                  )),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Ask a question...',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send_rounded,
                      color: Theme.of(context).colorScheme.onPrimary)),
            ],
          )
        ],
      ),
    );
  }
}
