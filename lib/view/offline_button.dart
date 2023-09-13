
import 'package:flutter/material.dart';

import '../data_base/data_base.dart';

class OfflineListButton extends StatefulWidget {
  const OfflineListButton(this.text, this.translate, {super.key});
  final String text;
  final String translate;

  @override
  State<OfflineListButton> createState() => _OfflineListButtonState();
}

class _OfflineListButtonState extends State<OfflineListButton> {
  DataBase dataBase = DataBase();
  late Icon favoriteIcon;
  late Future<bool> _futureBuild;

  @override
  void initState() {
    super.initState();
    _futureBuild = initFlag();
  }

  Future<bool> initFlag() async {
    bool flag;
    flag = await dataBase.containsFavorite(widget.text);
    if (flag == true) {
      favoriteIcon = const Icon(
        Icons.favorite,
        color: Color.fromARGB(165, 244, 67, 54),
      );
    } else {
      favoriteIcon = const Icon(
        Icons.favorite_border,
        color: Color.fromARGB(165, 244, 67, 54),
      );
    }
    return flag;
  }

 Future<void> onPressed() async {
    if (favoriteIcon.icon == Icons.favorite) {
      favoriteIcon = const Icon(
        Icons.favorite_border,
        color: Color.fromARGB(165, 244, 67, 54),
      );
     await  dataBase.deleteFavorite(widget.text);
    } else {
      favoriteIcon = const Icon(
        Icons.favorite,
        color: Color.fromARGB(165, 244, 67, 54),
      );
     await dataBase.putFavorite(widget.text, widget.translate);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _futureBuild,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return IconButton(onPressed: onPressed, icon: favoriteIcon);
        } else if (snapshot.hasError) {
          return const Text('Ошибка');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
