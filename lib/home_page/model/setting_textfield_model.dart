import 'package:flutter/material.dart';

class SettingTextFieldModel extends ChangeNotifier {
  int value = 0;

  @override
  void notifyListeners() {}
}

class SettingTextFieldModelProvider extends InheritedNotifier {
  const SettingTextFieldModelProvider(BuildContext context,{
    super.key,
    required this.model,
    required super.child,
  }) : super(
          notifier: model,
        );
  final SettingTextFieldModel model;

  static SettingTextFieldModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SettingTextFieldModelProvider>();
  }

  static SettingTextFieldModelProvider? read(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<SettingTextFieldModelProvider>()
        ?.widget as SettingTextFieldModelProvider;
  }
}
