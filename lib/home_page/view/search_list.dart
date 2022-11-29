import 'package:flutter/material.dart';
import 'parent_list.dart';
import '../model/search_textfield_model.dart';

class SearchList extends StatefulWidget implements ParentList {
  @override
  State<SearchList> createState() => _SearchListState();

  @override
  Future<Widget> makeSome() {
    throw UnimplementedError();
  }
}

class _SearchListState extends State<SearchList> {
  TextEditingController textcontroller = TextEditingController();
  Widget favoritButton = const Icon(
    Icons.favorite_border,
    color: Colors.red,
  );
  bool flag = false;
  String text = ' ';

  @override
  void initState() {
    textcontroller.addListener(onTapSearch);
    super.initState();
  }

  Future<void> onTapSearch() async {
    String enter = textcontroller.text;
   // if (enter.isNotEmpty) {
      SearchTextFieldModelProvider.read(context)?.model.key = enter;
      text = await SearchTextFieldModelProvider.read(context)
              ?.model
              .getTranslate() ??
          'error';
      flag = await SearchTextFieldModelProvider.watch(context)
              ?.model
              .database
              .containsFavorite(enter) ??
          false;
      flag == true
          ? favoritButton = const Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : favoritButton = const Icon(
              Icons.favorite_border,
              color: Colors.red,
            );
      setState(() {});
  //  }
  }

  Future<void> pressFavorit() async {
    if (flag == false) {
      await SearchTextFieldModelProvider.read(context)
          ?.model
          .database
          .putFavorite(textcontroller.text, text);
      await SearchTextFieldModelProvider.read(context)
          ?.model
          .database
          .putLearn(textcontroller.text, text);
    } else {
      await SearchTextFieldModelProvider.read(context)
          ?.model
          .database
          .deleteFavorite(textcontroller.text);
      await SearchTextFieldModelProvider.read(context)
          ?.model
          .database
          .deleteLearn(textcontroller.text);
    }
    flag = await SearchTextFieldModelProvider.watch(context)
            ?.model
            .database
            .containsFavorite(textcontroller.text) ??
        false;
    flag == true
        ? favoritButton = const Icon(
            Icons.favorite,
            color: Colors.red,
          )
        : favoritButton = const Icon(
            Icons.favorite_border,
            color: Colors.red,
          );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 100,
            ),
          ],
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 350, maxWidth: 350),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 0.5,
                ),
              ],
              color: const Color.fromARGB(255, 230, 230, 230),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    controller: textcontroller,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          text,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      IconButton(onPressed: pressFavorit, icon: favoritButton)
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
