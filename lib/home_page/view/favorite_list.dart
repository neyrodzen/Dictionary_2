import 'package:flutter/material.dart';

import '../../data_base/data_base.dart';
import 'parent_list.dart';

class FavoritesList extends StatelessWidget implements ParentList {
  final DataBase dataBase = DataBase();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
  @override
  Future<Widget> makeSome() async{
  final List<Widget> list = await dataBase.getListFavorite();
    return Column(children: list);
  }
}