import 'package:translator/translator.dart';

class ApiClient {
  Future<String?> getHttp(String word, String lang, String trans) async {
    String translate = ' ';
if (word.length<2)  {
      translate = ' ';
    }
    else
    {
     // Future.delayed(const Duration(milliseconds: 1000));
      final translator = GoogleTranslator();
      var transl = await translator.translate(word, from: lang, to: trans);
      translate = transl.text;
    } 
    return translate;
  }
}
