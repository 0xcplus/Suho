import 'dart:async';
import 'package:dart_openai/dart_openai.dart';

import 'openai_mode.dart';

//ChatGPT 함수
final requestMessages = [OpenAIChatCompletionChoiceMessageModel(
  content: [
    OpenAIChatCompletionChoiceMessageContentItemModel.text(
      'helpful assistant',
    ),
  ],
  role: OpenAIChatMessageRole.assistant,
)];

Future<void> fetchStreamedResponse(String inputMessage, String chatModel, StreamController<String> streamController) async {
  final userMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        inputMessage,
      ),
    ],
    role: OpenAIChatMessageRole.user,
  ); requestMessages.add(userMessage);

  String result = '';

  try{
    final chatStream = OpenAI.instance.chat.createStream(
      model: findChatVersion(chatModel),
      messages: requestMessages
    );

    await for (var streamChatCompletion in chatStream) {
      if (streamChatCompletion.choices.isNotEmpty){
        final content = streamChatCompletion.choices.first.delta.content;
        if (content != null && content.isNotEmpty) {
          for (var item in content) {
            if(item != null){
              final text = item.text??'';
              result += text;
              streamController.add(result);
            }
          }
        }
      }
    }
  } catch(e) {
    streamController.add('오류 발생 : $e');
  } finally {
    streamController.close();
  }

  final systemMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        result,
      ),
    ],
    role: OpenAIChatMessageRole.assistant,
  ); requestMessages.add(systemMessage);
}