import 'dart:convert';
import 'dart:typed_data';
import 'package:just_audio/just_audio.dart';

class AudioPlayerUtil {
  final AudioPlayer _audioPlayer = AudioPlayer();
  void Function()? onPlaybackComplete;

  Future<void> loadAudiofromBase64(String base64Data) async {
    try {
      Uint8List audioBytes = base64Decode(base64Data);

      await _audioPlayer.setAudioSource(BytesAudioSource(audioBytes));
      print("Audio loaded.");
    } catch (error){
      print("Auido Load failed. : $error");
    }
  }

  Future<void> play() async{
    try{
      await _audioPlayer.play();
      _audioPlayer.processingStateStream.listen((state){
        if(state == ProcessingState.completed){
          if (onPlaybackComplete != null){
            onPlaybackComplete!();
          }
        }
      });
    } catch (error){
      print("Audio Play failed : $error");
    }
  }

  Future<void> pause() async{
    try{
      await _audioPlayer.pause();
    } catch (error){
      print("Audio Pause failed : $error");
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

//base64 인코딩 데이터 처리
class BytesAudioSource extends StreamAudioSource {
  final Uint8List audioBytes;
  BytesAudioSource(this.audioBytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async{
    final actualStart = start ?? 0;
    final actualEnd = end ?? audioBytes.length;

    return StreamAudioResponse(
      sourceLength: audioBytes.length,
      contentLength: actualEnd - actualStart,
      offset: actualStart,
      stream: Stream.value(audioBytes.sublist(actualStart, actualEnd)),
      contentType: 'audio/wav', //데이터형
    );
  }
}