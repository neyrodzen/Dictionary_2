import 'package:push_word/home_page/view/offline_button.dart';
import 'package:flutter/material.dart';
import 'package:push_word/word_list.dart' as word;

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
                height: 50,
              ),
              Expanded(
                  flex: 1,
                  child: Container(),
                ),
              Expanded(
                  flex: 4,
                child: Text(
                  word.list[index]['ru'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),

              ),
              const Expanded(
                  flex: 1,
                  child: SizedBox(
                width: 20,
              )),
              Expanded(
                  flex: 4,
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
              indent: 10,
              endIndent: 10,
          ),
          
        ],
      ),
    );
  }
}
