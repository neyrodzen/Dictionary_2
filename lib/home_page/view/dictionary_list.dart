
import 'package:flutter/material.dart';
import 'dict_list_item.dart';
import 'parent_list.dart';
import 'package:push_word/word_list.dart'as word;


class DictionaryList extends StatefulWidget implements ParentList {
   const DictionaryList ({Key? key}) : super(key: key);
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
