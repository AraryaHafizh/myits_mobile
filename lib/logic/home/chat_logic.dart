import 'package:dart_ping/dart_ping.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/logic/widgets.dart';
import 'package:myits_portal/logic/provider_handler.dart';
import 'package:myits_portal/logic/style.dart';
import 'package:myits_portal/ui/home/chat_dptsi_page.dart';
import 'package:provider/provider.dart';

int userNRP = 0;
const String apiKey = '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';
bool waitGPTAnswer = false;

String contactCenter =
    'nstitut Teknologi Sepuluh Nopember\nKampus ITS Sukolilo, Surabaya 60111\nTelp : 031-5994251-54, 5947274, 5945472 (Hunting)\nFax : 031-5923465, 5947845\nEmail : humas@its.ac.id';

Future<void> refetchGPT(context, setState) async {
  setState(() {
    chatLoading = true;
  });

  await checkGPTStatus().then((status) {
    setState(() {
      gptStatus = status;
    });
  });

  setState(() {
    chatLoading = false;
  });
}

Future<bool> checkGPTStatus() async {
  final ping = Ping('api.openai.com', count: 2);
  final result = await ping.stream.first;
  if (result.response != null) {
    return true;
  } else {
    return false;
  }
}

Future<void> submit(context, question, nrp) async {
  final userHandler = Provider.of<UserProvider>(context, listen: false);
  final chatbot = Provider.of<ChatbotProvider>(context, listen: false);
  final announcementProvider =
      Provider.of<AnnouncementProvider>(context, listen: false);
  final agendaProvider = Provider.of<AgendaProvider>(context, listen: false);
  String username = userHandler.getStudData('nama', nrp);
  userHandler.loadData4GPT(nrp);
  agendaProvider.dataForGPT();
  announcementProvider.dataForGPT();
  chatbot.updateLoadingState();
  print('agenda: ${userHandler.dataGPT}');

  try {
    final response =
        await dio.post('https://api.openai.com/v1/chat/completions',
            data: {
              'model': 'gpt-3.5-turbo',
              'messages': [
                {
                  'role': 'system',
                  'content':
                      'Anda adalah customer service pada universitas ITS Surabaya. berikan sapaan kepada $username saat menjawab pertanyaan pertama. gunakan $contactCenter sebagai data contact center ITS, dan berikut data user yang bertanya ${userHandler.dataGPT}.'
                  // Gunakan data berikut sebagai referensi tambahan, data agenda: ${agendaProvider.dataGPT}, data announcement:${announcementProvider.dataGPT}.
                },
                {'role': 'user', 'content': chatbot.input},
              ],
              'temperature': 0.75,
            },
            options: Options(headers: {
              'Authorization': 'Bearer $apiKey',
              'Content-Type': 'application/json',
              'Content-Length': '<calculated when request is sent>'
            }));
    if (response.statusCode == 200) {
      final data = response.data;
      chatbot.updateOutput(data['choices'][0]['message']['content']);
      chatbot.updateHistory();
    } else {
      throw Exception('Failed to load response');
    }
  } catch (e) {
    if (e is DioException && e.response != null) {
      debugPrint('Response Data: ${e.response!.data}');
    } else {
      debugPrint('Error $e');
    }
  } finally {
    chatbot.updateLoadingState();
  }
  // chatbot.updateLoadingState();
}

Widget qnaWindow(context, nrp) {
  userNRP = nrp;
  final chatbot = Provider.of<ChatbotProvider>(context);
  final userHandler = Provider.of<UserProvider>(context, listen: false);
  final username = userHandler.getStudData('nama', nrp);
  final data = chatbot.history;

  return Expanded(
    child: waitGPTAnswer
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final items = data[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    textBubble(items[0], itsBlueStatic, 'right',
                        name: username),
                    const SizedBox(height: 15),
                    textBubble(items[1], itsBlueStatic, 'left'),
                    const SizedBox(height: 15)
                  ],
                ),
              );
            },
          ),
  );
}

Widget textBubble(data, color, align, {name}) {
  return Align(
    alignment: align == 'left' ? Alignment.topLeft : Alignment.topRight,
    child: Container(
      // width: MediaQuery.of(context).size.width - 15,
      decoration: BoxDecoration(
        color: color,
        borderRadius: align == 'left'
            ? const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(25),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(15),
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: align == 'left'
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Text(
              align == 'left' ? 'ITS bot' : name,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data,
              style: TextStyle(
                color: white,
                fontSize: 17,
              ),
              textAlign: align == 'left' ? TextAlign.left : TextAlign.right,
            ),
          ],
        ),
      ),
    ),
  );
}
