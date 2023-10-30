import 'package:flutter/material.dart';
import 'package:myits_portal/settings/chat_settings/chat_controls.dart';
import 'package:myits_portal/settings/style.dart';
import 'package:provider/provider.dart';

class OpenChat extends StatefulWidget {
  final int nrp;
  const OpenChat({super.key, required this.nrp});

  @override
  State<OpenChat> createState() => _OpenChatState();
}

class _OpenChatState extends State<OpenChat> {
  TextEditingController question = TextEditingController();

  @override
  void dispose() {
    question.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatbot = Provider.of<ChatbotHandler>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 55, left: 15, right: 15),
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
          qnaWindow(context, widget.nrp),
          const Divider(),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: question,
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
              Tooltip(
                message: 'Clear chat',
                child: IconButton(
                    onPressed: () {
                      chatbot.clearChat();
                    },
                    icon: Icon(Icons.delete_forever,
                        color: Theme.of(context).colorScheme.onPrimary)),
              ),
              Tooltip(
                message: 'Submit',
                child: IconButton(
                    onPressed: () {
                      if (question.text.isNotEmpty) {
                        chatbot.askGPT(context, question.text, widget.nrp);
                        question.clear();
                        // chatbot.updateOutputManual(question.text);
                      } else {
                        alertDialog(context);
                      }
                    },
                    icon: Icon(Icons.send_rounded,
                        color: Theme.of(context).colorScheme.onPrimary)),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

void alertDialog(context) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Nothing to answer...',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 23, fontWeight: FontWeight.w700),
          ),
          content: Text('Question can\'t be empty.',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 13)),
          actions: [
            // TextButton(
            //     onPressed: () {
            //       Navigator.pop(context);
            //       Navigator.pop(context);
            //     },
            //     child: Text('Go Back')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        );
      });
}
