import 'package:dictionary_with_not/data_base/data_base.dart';
import 'package:flutter/material.dart';

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
        color: Colors.red,
      );
    } else {
      favoriteIcon = const Icon(
        Icons.favorite_border,
        color: Colors.black,
      );
    }
    return flag;
  }

 Future<void> onPressed() async {
    if (favoriteIcon.color == Colors.red) {
      favoriteIcon = const Icon(
        Icons.favorite_border,
        color: Colors.black,
      );
     await  dataBase.deleteFavorite(widget.text);
    } else {
      favoriteIcon = const Icon(
        Icons.favorite,
        color: Colors.red,
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
          return const Text('err');
        } else {
          return const Text('Error');
        }
      },
    );
  }
}
