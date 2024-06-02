abstract class GeminiTalkRepository {
  Future<String> onTextOnly(String text) async {
    return '';
  }

  Future<String> onTextAndImage(String text, String base64) async {
    return '';
  }
}