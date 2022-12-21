import 'package:dictionary_with_not/home_page/view/offline_button.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_with_not/word_list.dart' as word;

class DictionaryListItem extends StatelessWidget {
  const DictionaryListItem(this.index, {super.key});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 8,
                height: 40,
              ),
              Expanded(
                child: Text(
                  word.list[index]['ru'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const Expanded(
                  child: SizedBox(
                width: 20,
              )),
              Expanded(
                child: Text(word.list[index]['en'] as String,
                    style: const TextStyle(
                      fontSize: 20,
                    )),
              ),
              OfflineListButton(
                word.list[index]['ru'] as String,
                word.list[index]['en'] as String,
              )
            ],
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
            endIndent: 8,
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
