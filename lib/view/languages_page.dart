import 'package:flutter/material.dart';
import 'package:push_word/data_base/data_base.dart';
import 'package:push_word/languages.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({Key? key}) : super(key: key);

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  final mapLanguages = MapLanguages.mapLanguages;
  var list = <Widget>[];
  @override
  Widget build(BuildContext context) {
    DataBase dataBase = DataBase();
    mapLanguages.forEach((key, value) {
      list.add(Column(
        children: [
          GestureDetector(
          onTap: (){
              dataBase.putNativeLanguage(key);
             Navigator.of(context).pop();},
            child: Row(
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
                    value,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(key, style: const TextStyle(fontSize: 20)),
                ),
                //
              ],
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 35, 35, 35),
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
        ],
      ));
    });
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Text(''),
              )
            ],
            title: const Center(
              child: Text(
                '',
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: list,
          ),
        ));
  }
}
