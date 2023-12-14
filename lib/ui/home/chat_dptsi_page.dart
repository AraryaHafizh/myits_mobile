import 'package:flutter/material.dart';
import 'package:myits_portal/logic/home/chat_logic.dart';
import 'package:myits_portal/logic/provider_handler.dart';
import 'package:myits_portal/logic/style.dart';
import 'package:provider/provider.dart';

bool chatLoading = false;
late bool gptStatus;

class ChatBot extends StatefulWidget {
  final int nrp;
  const ChatBot({super.key, required this.nrp});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  TextEditingController question = TextEditingController();

  @override
  void dispose() {
    question.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    refetchGPT(context, setState);
  }

  @override
  Widget build(BuildContext context) {
    if (chatLoading) {
      return Container(
          color: Theme.of(context).colorScheme.background,
          child: const Center(child: CircularProgressIndicator()));
    } else {
      final chatbot = Provider.of<ChatbotProvider>(context, listen: false);
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
                        'CHATBOT ITS',
                        style: jakarta.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        gptStatus ? 'Online' : 'offline',
                        style: jakarta.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            color: gptStatus ? Colors.green : Colors.red),
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
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      if (question.text.isNotEmpty && gptStatus != false) {
                        chatbot.askGPT(context, question.text, widget.nrp);
                        question.clear();
                        // chatbot.updateOutputManual(question.text);
                      } else {
                        alertDialog(context, gptStatus);
                      }
                    },
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
                        if (question.text.isNotEmpty && gptStatus != false) {
                          chatbot.askGPT(context, question.text, widget.nrp);
                          question.clear();
                          // chatbot.updateOutputManual(question.text);
                        } else {
                          alertDialog(context, gptStatus);
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
}

void alertDialog(context, status) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            status ? 'Nothing to answer...' : 'Uh Oh...',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 23, fontWeight: FontWeight.w700),
          ),
          content: Text(
              status
                  ? 'Question can\'t be empty.'
                  : 'Look\'s like the chatbot is offline. Please try again later.',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 13)),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        );
      });
}
