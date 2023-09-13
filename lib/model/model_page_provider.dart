import 'package:flutter/material.dart';
import 'model_page.dart';

class ModelProvider extends InheritedNotifier {
  const ModelProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(notifier: model,);
  final ModelOfPage model;

  static ModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ModelProvider>();
  }

  static ModelProvider? read(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<ModelProvider>()
        ?.widget as ModelProvider;
  }
}