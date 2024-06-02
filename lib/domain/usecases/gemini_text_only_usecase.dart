
import '../repositories/gemini_talk_repository.dart';

class GeminiTextOnlyUseCase {
  final GeminiTalkRepository repository;

  GeminiTextOnlyUseCase(this.repository);

  Future<String> call(String text) async {
    return await repository.onTextOnly(text);
  }


}