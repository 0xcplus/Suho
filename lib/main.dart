//flutter & dart
import 'package:flutter/material.dart';

//openai
import 'package:dart_openai/dart_openai.dart';

//etc.
import 'openai/apikeyfetch.dart';
import 'index/setting.dart';
import 'page/astart.dart';

void main() async {
  OpenAI.apiKey = await returnApiKey();
  runApp(const MyApp());
}
//package.json 관련 오류 해결해야할 듯.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suho',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 70, 70, 70),
          brightness: Brightness.light, // 라이트 모드
        ).copyWith(
          primary: const Color.fromARGB(255, 71, 71, 71), // 주 테마 색상
          onPrimary: Colors.white, // 주 테마 색상의 대비 텍스트
          secondary: const Color.fromARGB(255, 100, 241, 171), // 보조 색상
          onSecondary: const Color.fromARGB(255, 242, 242, 242), // 보조 색상의 대비 텍스트
          surface: const Color.fromARGB(255, 238, 238, 238), // 표면 색상 (카드, 모달 등)
          onSurface: Colors.black, // 표면 색상에 쓰일 텍스트 색상
          error: const Color.fromARGB(255, 231, 141, 135), // 에러 색상
          onError: Colors.white, // 에러 색상의 대비 텍스트
        ),
        useMaterial3: false, // Material 3 스타일 사용

        // 기본 텍스트 스타일
        textTheme: TextTheme(
          bodyLarge: initTextStyle(),
        ),
      ),

      home: const BeginPage(title: 'SUHO'),
    );
  }
}