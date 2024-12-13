import 'dart:convert';
import 'package:http/http.dart' as http;
import 'apikeyfetch.dart';

Future<(dynamic, dynamic)> generateAudioResult(String model, String content) async { //file audio
  String apiKey= await returnApiKey();

  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/chat/completions'),
    headers: {
      'Content-Type':'application/json',
      'Authorization': 'Bearer $apiKey',
    },

    body: jsonEncode({
      "model" : model,
      "modalities": ["text", "audio"],
      "audio":{"voice":"alloy", "format":"wav"},
      "messages":[
        {
          "role":"user",
          "content":"Hello World!"
        },
      ]
    })
  );

  try{
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var audio = data['choices'][0]['message']['audio']['data'];

      var transcript = data['choices'][0]['message']['audio']['transcript'];
      return (audio, transcript);
      } else {
      throw Exception('API call failed : ${response.statusCode}');
    } 
  }catch(error){
    return ('0', error);
  }
}