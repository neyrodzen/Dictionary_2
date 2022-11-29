import 'package:flutter/material.dart';
import 'parent_list.dart';

class DictionaryList extends StatefulWidget implements ParentList {
  @override
  State<DictionaryList> createState() => DictionaryListState();

  @override
  Future<Widget> makeSome() {
    throw UnimplementedError();
  }
}

class DictionaryListState extends State<DictionaryList> {
  @override
  Widget build(BuildContext context) {
    return const Text('data');
  }
}
