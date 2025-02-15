import 'package:envied/envied.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

@Envied(path:"assets/config/.env")
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY')
  static String get apiKey {
    try {
      return dotenv.env['OPEN_AI_API_KEY'] ?? 'dummy_key';     
    } 
    catch (e) {
      return '$e';
    }
  }
}