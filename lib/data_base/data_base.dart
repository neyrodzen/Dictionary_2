import 'package:hive/hive.dart';
import 'package:push_word/languages.dart';

class DataBase {
  bool isFavorit = false;
  static int count = 0;

  Future<void> initialNativeLanguage() async {
    var lang = await Hive.openBox<String>('LanguageBox');
    bool flag = lang.containsKey('language');
    if (!flag) {
      lang.put('language', 'ru');
    }
    // await lang.close();
  }

  Future<String> getNativeLanguage() async {
    var lang = await Hive.openBox<String>('LanguageBox');
    String code = lang.get('language') ?? 'ru';
    var map = MapLanguages.mapLanguages;
    String value = map[code] ?? 'ru';
    //  await lang.close();
    return value;
  }

  Future<String> getNativeLanguageCode() async {
    var lang = await Hive.openBox<String>('LanguageBox');
    String value = lang.get('language') ?? 'ru';
    //  await lang.close();
    return value;
  }

  Future<void> putNativeLanguage(String language) async {
    var lang = await Hive.openBox<String>('LanguageBox');
    lang.put('language', language);
    // await lang.close();
  }

  Future<void> initialSpin() async {
    var spin = await Hive.openBox<int>('SpinBox');
    bool flag = spin.containsKey('spin');
    if (!flag) {
      spin.put('spin', 100);
    }
    //  await spin.close();
  }

  Future<void> putSpin(int reward) async {
    var spin = await Hive.openBox<int>('SpinBox');
    int value = spin.get('spin') ?? 0;
    spin.put('spin', value + reward);
    // await spin.close();
  }

  Future<int> getSpin() async {
    var spin = await Hive.openBox<int>('SpinBox');
    int value = spin.get('spin') ?? 0;
    // await spin.close();
    return value;
  }

  Future<void> deleteSpin() async {
    var spin = await Hive.openBox<int>('SpinBox');
    int value = spin.get('spin') ?? 0;
    spin.put('spin', value - 1);
    // await spin.close();
  }

  Future<void> putFavorite(String key, String value) async {
    var boxFavorite = await Hive.openBox<String>('FavoriteBox');
    await boxFavorite.put(key, value);
    await boxFavorite.close();
  }

  Future<void> deleteFavorite(String key) async {
    var boxFavorite = await Hive.openBox<String>('FavoriteBox');
    await boxFavorite.delete(key);
    await boxFavorite.close();
  }

  Future<bool> containsFavorite(String key) async {
    var boxFavorite = await Hive.openBox<String>('FavoriteBox');
    bool flag = boxFavorite.containsKey(key);
    if (key == ' ') {
      await boxFavorite.close();
    }
    return flag;
  }

  Future<Map<dynamic, String>> getListFavorite() async {
    var boxFavorite = await Hive.openBox<String>('FavoriteBox');
    var map = boxFavorite.toMap();

    await boxFavorite.close();
    return map;
  }

  Future<void> putLearn(String key, String value) async {
    var boxLearn = await Hive.openBox<String>('LearnBox');
    await boxLearn.put(key, value);
    await boxLearn.close();
  }

  Future<void> deleteLearn(String key) async {
    var boxLearn = await Hive.openBox<String>('LearnBox');
    await boxLearn.delete(key);
    await boxLearn.close();
  }

  Future<bool> containsLearn(String key) async {
    var boxLearn = await Hive.openBox<String>('LearnBox');
    bool flag = boxLearn.containsKey(key);
    await boxLearn.close();
    return flag;
  }

  Future<Map<dynamic, String>> getListLearn() async {
    final boxLearn = await Hive.openBox<String>('LearnBox');
    var map = boxLearn.toMap();

    await boxLearn.close();
    return map;
  }

  Future<int> getLenghtLearnBox() async {
    final boxLearn = await Hive.openBox<String>('LearnBox');
    return boxLearn.length;
  }

  Future<Map<String, String>> getNextWords() async {
    final boxLearn = await Hive.openBox<String>('FavoriteBox');
    final String key = boxLearn.keyAt(count) as String;
    final String value = boxLearn.getAt(count) ?? 'Список пуст';
    Map<String, String> map = {key: value};
    return map;
  }
}
