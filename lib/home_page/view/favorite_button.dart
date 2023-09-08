
// import 'package:flutter/material.dart';

// import '../../data_base/data_base.dart';

// class FavoriteButton extends StatefulWidget {
//   const FavoriteButton(this.text,this.translate, {super.key});
//   final String text;
//   final String translate;
//   @override
//   State<FavoriteButton> createState() => _FavoriteButtonState();
// }

// class _FavoriteButtonState extends State<FavoriteButton> {
//   DataBase dataBase = DataBase();

//   Icon favoiteIcon = const Icon(
//     Icons.favorite,
//     color: Color.fromARGB(100, 244, 67, 54),
//   );
//   void onPressed() {
//     if (favoiteIcon.color == Colors.red) {
//       favoiteIcon = const Icon(Icons.favorite_border, color: Colors.black);
//     dataBase.deleteFavorite(widget.text);
//     } else {
//       favoiteIcon = const Icon(
//         Icons.favorite,
//         color: Color.fromARGB(100, 244, 67, 54),
//       );
//        dataBase.putFavorite(widget.text, widget.translate);
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(onPressed: onPressed, icon: favoiteIcon);
//   }
// }
