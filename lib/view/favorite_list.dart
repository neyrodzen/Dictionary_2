import 'package:flutter/material.dart';

import '../data_base/data_base.dart';
import 'parent_list.dart';

class FavoritesList extends StatelessWidget implements ParentList {
  FavoritesList({Key? key}) : super(key: key);
  final DataBase dataBase = DataBase();

  Future<void> inLearn(String key, String value) async {
    await dataBase.putLearn(key, value);
    await dataBase.deleteFavorite(key);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Future<Widget> makeSome() async {
    var list = <Widget>[];
    final Map<dynamic, String> map = await dataBase.getListFavorite();

    map.forEach((key, value)  {
      list.add(Dismissible(
        
        background: Container(
          color: Colors.green,
          child: const Icon(Icons.done),
        ),
        key:  UniqueKey(),
        onDismissed: (DismissDirection direction) {
          inLearn('$key', value);
        },
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
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
                    '$key',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(value, style: const TextStyle(fontSize: 20)),
                ),
                //
              ],
            ),
            const Divider(
              color: Color.fromARGB(255, 35, 35, 35),
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
          ],
        ),
      ));
    });
    return SingleChildScrollView(child: Column(children: list));
  }
}
