import 'package:translator/translator.dart';

class ApiClient {
  Future<String?> getHttp(String word) async {
    String translate = ' ';

    if (word.isNotEmpty) {
      final translator = GoogleTranslator();
      var trans = await translator.translate(word, to: 'ru');
      translate = trans.text;
    }
    return translate;
  }
}
