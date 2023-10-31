import 'package:dart_ping/dart_ping.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/settings/provider_controls.dart';
import 'package:myits_portal/settings/style.dart';
import 'package:provider/provider.dart';

int userNRP = 0;
const String apiKey = '';
bool isLoading = false;

class ChatbotHandler extends ChangeNotifier {
  String gptOutput = '';
  String userInput = '';
  List<dynamic> chatHistory = [];

  String get output => gptOutput;
  String get input => userInput;
  List<dynamic> get history => chatHistory;

  void updateLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void updateOutput(data) {
    gptOutput = data;
    notifyListeners();
  }

  void updateInput(data) {
    userInput = data;
    notifyListeners();
  }

  void updateHistory() {
    chatHistory.add([input, output]);
    notifyListeners();
  }

  void clearChat() {
    chatHistory.clear();
    notifyListeners();
  }

  // void updateOutputManual(data) {
  //   updateLoadingState();
  //   Future.delayed(Duration(seconds: 2), () {
  //     updateInput(data);
  //     updateOutput(data);
  //     updateHistory();
  //     updateLoadingState();
  //     notifyListeners();
  //   });
  // }

  void askGPT(context, data, nrp) async {
    updateInput(data);
    await submit(context, data, nrp);
    print(history);
  }
}

Future<bool> checkGPTStatus() async {
  final ping = Ping('api.openai.com', count: 2);
  final result = await ping.stream.first;
  if (result.response != null) {
    print('truu');
    return true;
  } else {
    print('false');
    return false;
  }
}

Future<void> submit(context, question, nrp) async {
  final mhsHandler = Provider.of<MhsDataProvider>(context, listen: false);
  String username = mhsHandler.getStudData('nama', nrp);
  final chatbot = Provider.of<ChatbotHandler>(context, listen: false);
  final agendaProvider =
      Provider.of<AgendaDataProvider>(context, listen: false);
  final announcementProvider =
      Provider.of<AnnounceDataProvider>(context, listen: false);
  chatbot.updateLoadingState();

  try {
    final response =
        await dio.post('https://api.openai.com/v1/chat/completions',
            data: {
              'model': 'gpt-3.5-turbo',
              'messages': [
                {
                  'role': 'system',
                  'content':
                      'Anda adalah seorang customer service pada universitas ITS Surabaya. tolong coba jawab pertanyaan meskipun jawaban itu mungkin outdated, saya ingin anda menjawb dengan susunan: pembukaan-isi-penutup. untuk pembukaan berikan sapaan kepada mahasiswa dengan nama $username. untuk penutup tolong berikan \'Kampus ITS Sukolilo - Surabaya\nEmail: humas@its.ac.id\nPhone: 031-5994251-54, 5947274, 5945472\nFax: 031-5923465, 5947845.\'. Gunakan data berikut sebagai referensi tambahan: ${agendaProvider.data} dan ${announcementProvider.data}. Jika user bertanya terkait agenda sebutkan title, desc, dan date saja. Jika user bertanya terkait announcement sebutkan title dan subtitle saja. Jika user bertanya mengenai informasi seputar ITS jangan lupa diakhir jawaban berikan contact center dengan data berikut'
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
    debugPrint('Error $e');
  } finally {
    chatbot.updateLoadingState();
  }
}

Widget qnaWindow(context, nrp) {
  userNRP = nrp;
  final chatbot = Provider.of<ChatbotHandler>(context);
  final mhsHandler = Provider.of<MhsDataProvider>(context, listen: false);
  final username = mhsHandler.getStudData('nama', nrp);
  final data = chatbot.history;

  return Expanded(
    child: isLoading
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
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(25),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(25),
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
              style: TextStyle(
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
