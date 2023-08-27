import 'package:translator/translator.dart';

class ApiClient {
  Future<String?> getHttp(String word) async {
    String translate = ' ';
if (word.length<2)  {
      translate = ' ';
    }
    else
    {
     // Future.delayed(const Duration(milliseconds: 1000));
      final translator = GoogleTranslator();
      var trans = await translator.translate(word, from: 'en', to: 'ru');
      translate = trans.text;
    } 
    return translate;
  }
}
