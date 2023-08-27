
import 'package:push_word/home_page/view/favorite_list.dart';
import 'package:push_word/home_page/view/search_list.dart';
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
  Widget listWidget = const SearchList();

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
          ModelProvider.watch(context)?.model.factoryList() ?? const ErrorList();
      if (index == 1) {
        var listfavorit = await FavoritesList().makeSome();
        listWidget = listfavorit;
      } else if (index == 0) {
        listWidget = list as Widget;
      }
        else if (index == 2) {
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
          title: const Row(
            children:  [
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
          color: Theme.of(context).brightness == Brightness.light ? Colors.white : Theme.of(context).primaryColor,
          child: SearchTextFieldModelProvider(model: modelSearch, child: listWidget),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
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
            label: 'Offline',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        onTap: onTapBottom,
        currentIndex: indexItem,
      ),
    );
  }
}
