import 'package:flutter/material.dart';

import '../../data_base/data_base.dart';
import '../api_client/api_client.dart';

class SearchTextFieldModel extends ChangeNotifier {
  String key = '';
  String value = '';
  DataBase database = DataBase();

  Future<String> getTranslate() async {
    ApiClient apiClient = ApiClient();
    String translate = await apiClient.getHttp(key) ?? key;
    return translate.isNotEmpty ? translate : key;
  }

  @override
  void notifyListeners() {}
}

class SearchTextFieldModelProvider extends InheritedNotifier {
  const SearchTextFieldModelProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(
          notifier: model,
        );
  final SearchTextFieldModel model;

  static SearchTextFieldModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SearchTextFieldModelProvider>();
  }

  static SearchTextFieldModelProvider? read(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<SearchTextFieldModelProvider>()
        ?.widget as SearchTextFieldModelProvider;
  }
}
