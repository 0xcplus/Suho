import 'package:flutter/material.dart';

import '../index/setting.dart';

import 'package:suho/openai/openai_audio.dart';
import 'package:suho/function/playwav.dart';

import 'package:suho/function/decode.dart';

class StartEvent extends StatefulWidget {
  const StartEvent({super.key});

  @override
  State<StartEvent> createState() => _StartEventState();
}

class _StartEventState extends State<StartEvent>{
  final TextEditingController _controller = TextEditingController();
  late AudioPlayerUtil _audioPlayerUtil;
  bool _isPlaying = false;

  @override
  void initState(){
    super.initState();
    _audioPlayerUtil = AudioPlayerUtil();
  }

  @override
  void dispose(){
    _controller.dispose();
    _audioPlayerUtil.dispose();
    super.dispose();
  }

  void _onButtonPressed() {
    /*final (dynamic audio, dynamic transcript) = 
    await generateAudioResult('gpt-4o-audio-preview', 'hello world!');

    print('\n====detail====\n');
    print(audio);
    print(transcript);*/

    if (_isPlaying) {
        _audioPlayerUtil.pause();
      } else {
        _audioPlayerUtil.loadAudiofromBase64(exampleDecodeData); // decode.dart
        _audioPlayerUtil.play();
      }
      
    setState(() {
      _isPlaying = !_isPlaying;
    });

    _audioPlayerUtil.onPlaybackComplete = (){
      setState(() {
        _isPlaying = false;
      });
    };

    print("it's done!");
  }
  
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text('This is the First page!')
        ),

      ElevatedButton(
        onPressed: () {
          _onButtonPressed();
          },
          
          child: Text(_isPlaying ? "Pause" : "Play"),
        ),
      ]
    );
  }
}