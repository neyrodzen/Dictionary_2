import 'package:flutter/material.dart';

import '../../data_base/data_base.dart';
import 'favorite_button.dart';
import 'parent_list.dart';

class FavoritesList extends StatelessWidget implements ParentList {
  final DataBase dataBase = DataBase();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
  @override
  Future<Widget> makeSome() async{
     var list = <Widget>[];
  final Map<dynamic,String>map = await dataBase.getListFavorite();

     map.forEach((key, value)async {
      list.add (Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            children: [
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
              FavoriteButton(key,value)
             // 
            ],
          ),
          
          
          const Divider(
            color: Colors.black,
            thickness: 1,
            indent: 10,
            endIndent: 10,
            ),
        ],
      ));
    });
    return SingleChildScrollView(child: Column(children: list));

 
  }
}