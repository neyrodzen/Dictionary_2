import 'package:dictionary_with_not/home_page/view/dict_list_item.dart';
import 'package:flutter/material.dart';
import 'parent_list.dart';
import 'package:dictionary_with_not/word_list.dart' as word;


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
    return ListView.builder(
      itemCount: word.list.length,
      itemBuilder: (_, int index) {
      return DictionaryListItem(index);
    });
  }
}
