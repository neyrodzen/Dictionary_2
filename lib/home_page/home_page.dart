import 'package:dictionary_with_not/home_page/view/search_list.dart';
import 'package:flutter/material.dart';

import 'model/model_page_provider.dart';
import 'view/parent_list.dart';
import 'model/search_textfield_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexItem = 0;
  Widget listWidget = SearchList();

  @override
  Widget build(BuildContext context) {
    SearchTextFieldModel modelSearch = SearchTextFieldModel();
    

    void ontapSettings() {
      Navigator.of(context).pushNamed('/settings_page');
      setState(() {});
    }

    Future<void> onTapBottom(int index) async {
      indexItem = index;
      ModelProvider.watch(context)?.model.indexBottomBar = index;
      ParentList list =
          ModelProvider.watch(context)?.model.factoryList() ?? ErrorList();
      if (index == 1) {
        var listfavorit = await list.makeSome();
        listWidget = listfavorit;
      } else if (index == 0) {
        listWidget = list as Widget;
      }
      setState(() {});
    }

    return Scaffold(
      // floatingActionButton:,
      appBar: AppBar(
          actions: [
            ElevatedButton(
              onPressed: ontapSettings,
              child: const Icon(Icons.settings),
            )
          ],
          title: Row(
            children: const [
              Expanded(
                child: Text(
                  '   ',
                ),
              ),
            ],
          )),
      body: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: double.infinity,
          minWidth: double.infinity,
        ),
        child: ColoredBox(
          color: Colors.white70,
          child: SingleChildScrollView(
            child:
                SearchTextFieldModelProvider(model: modelSearch, child: listWidget),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List ',
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 108, 30, 244),
        selectedItemColor: Colors.white70,
        onTap: onTapBottom,
        currentIndex: indexItem,
      ),
    );
  }
}
