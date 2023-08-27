import 'package:flutter/material.dart';

abstract class ParentList {
  Future<Widget> makeSome();
}

class OfflineList extends StatelessWidget implements ParentList {
  
    const OfflineList ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Text('List');
  }
  
  @override
  Future<Widget> makeSome() {
    throw UnimplementedError();
  }
}

class ErrorList extends StatelessWidget implements ParentList {
    const ErrorList ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Text('Error ');
  }
  
  @override
  Future<Widget> makeSome() {
    throw UnimplementedError();
  }
}