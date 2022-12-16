
import 'package:hive/hive.dart';

class DataBase {
  bool isFavorit = false;
  static int count = 0;
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

  Future<Map<dynamic,String>> getListFavorite() async {

    var boxFavorite = await Hive.openBox<String>('FavoriteBox');
    var map = boxFavorite.toMap();
   
    await boxFavorite.close();
    return map ;
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

  Future<Map<String, String>> getListLearn(int index) async {
    final boxLearn = await Hive.openBox<String>('LearnBox');
    final key = boxLearn.keyAt(index);
    final value = boxLearn.getAt(index);
    final Map<String, String> map;
    if (key != null) {
      map = {'$key': '$value'};
    } else {
      map = {' ': ' '};
    }
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
