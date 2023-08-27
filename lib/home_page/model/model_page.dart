
import 'package:flutter/cupertino.dart';
import '../view/dictionary_list.dart';
import '../view/favorite_list.dart';
import '../view/search_list.dart';
import '../view/parent_list.dart';

class ModelOfPage extends ChangeNotifier {
  ModelOfPage(this.indexBottomBar);

  int indexBottomBar;

  ParentList factoryList() {
        notifyListeners();

    switch (indexBottomBar) {
      case 0:
       // notifyListeners();
        return const SearchList();
      case 1:
        // notifyListeners();
        return FavoritesList();
      case 2:
        // notifyListeners();
        return const DictionaryList();
      default:
        // notifyListeners();
        return const ErrorList();
    }
  }
}