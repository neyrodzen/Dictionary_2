// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class LanguageChoiceModel {
  String lang ;
  String trans ;
  LanguageChoiceModel({
    required this.lang,
    required this.trans,
  });
}

class LanguageChoiceModelProvider extends ChangeNotifier {
  LanguageChoiceModel languageChoiceModel = LanguageChoiceModel(lang: 'en', trans: 'ru');
  void replaceLanguage() {
    String lang = languageChoiceModel.lang;
    languageChoiceModel.lang = languageChoiceModel.trans;
    languageChoiceModel.trans = lang;
    notifyListeners();
  }
}
