import 'package:flutter/material.dart';
import '../index/setting.dart';

Map<String, dynamic> _chatSet(
  String target, String modelVersion, 
  String asset, {String information = 'ChatGPT Model'}
  ){
  return {
    'target':target,
    'modelVersion':modelVersion,
    'image':Image.asset(
      asset,
      width:radiusChatImage*1.4,
      height: radiusChatImage*1.4,
      fit:BoxFit.cover
      ),
    'information':information,
  };
}

//Chat 모드 설정
List chatMode = [
  _chatSet(
    'GPT', 'gpt-4o-audio-preview',
    'assets/images/logo.png', information: 'English Audio Model'),

  _chatSet('initGPT', 'gpt-4o-mini','assets/images/logo.png'),
  _chatSet('reasonGPT', 'o1-preview', 'assets/images/o1logo.png', information: 'Model for Reasoning'),
  _chatSet('miniGPT', 'o1-mini', 'assets/images/o1logo.png', information: 'Mini Model for Reasoning'),
  _chatSet('exampleGPT', 'ft:gpt-3.5-turbo-1106:personal::8QsZhzJG', 'assets/images/logo.png', information: 'My First Fine-Tuning Model'),
];

//추출 함수
String findChatVersion(String target){
  return findChatMode(target)['modelVersion'];
}

Image findChatImage(String target) {
  return findChatMode(target)['image'];
}

Map<String, dynamic> findChatMode(String target){
  return chatMode.firstWhere(
    (chat) => chat['target'] == target,
    orElse: () => null,
  );
}