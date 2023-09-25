// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:push_word/data_base/data_base.dart';

class LanguageChoiceModel {
  String lang;
  String trans;
  LanguageChoiceModel({
    required this.lang,
    required this.trans,
  });
}

class LanguageChoiceModelProvider extends ChangeNotifier {
  // String languages = await DataBase().getNativeLanguageCode();
  String translate = 'en';
  LanguageChoiceModel languageChoiceModel =
      LanguageChoiceModel(lang: 'en', trans: 'ru');
  void replaceLanguage() {
    String lang = languageChoiceModel.lang;
    languageChoiceModel.lang = languageChoiceModel.trans;
    languageChoiceModel.trans = lang;
    notifyListeners();
  }

  Future<void> setLanguage() async {
    if (languageChoiceModel.trans != 'en') {
      languageChoiceModel.trans = await DataBase().getNativeLanguageCode();
    } else {
      languageChoiceModel.lang = await DataBase().getNativeLanguageCode();
    }
    
    notifyListeners();
  }
}
