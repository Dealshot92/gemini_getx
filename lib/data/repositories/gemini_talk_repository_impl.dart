
import '../../core/services/log_service.dart';
import '../../domain/repositories/gemini_talk_repository.dart';
import '../datasources/remote/http_service.dart';

class GeminiTalkRepositoryImpl extends GeminiTalkRepository {
  @override
  Future<String> onTextOnly(String text) async {
    var response = await Network.POST(Network.API_GEMINI_TALK, Network.paramsTextOnly(text));
    var geminiTalk = Network.parseGeminiTalk(response!);
    var result = geminiTalk.candidates[0].content.parts[0].text;
    LogService.i(result);
    return result;
  }

  @override
  Future<String> onTextAndImage(String text, String base64) async {
    LogService.i(base64);
    var response = await Network.POST(Network.API_GEMINI_TALK, Network.paramsTextAndImage(text, base64));
    var geminiTalk = Network.parseGeminiTalk(response!);
    var result = geminiTalk.candidates[0].content.parts[0].text;
    LogService.i(result);
    return result;
  }
}