import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_word/home_page/model/language_choice_model.dart';
import 'parent_list.dart';
import '../model/search_textfield_model.dart';

class SearchList extends StatefulWidget implements ParentList {
  const SearchList({Key? key}) : super(key: key);
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
    color: Color.fromARGB(165, 244, 67, 54),
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
    if (!context.mounted) return;
    flag = await SearchTextFieldModelProvider.watch(context)
            ?.model
            .database
            .containsFavorite(enter) ??
        false;
    flag == true
        ? favoritButton = const Icon(
            Icons.favorite,
            color: Color.fromARGB(165, 244, 67, 54),
          )
        : favoritButton = const Icon(
            Icons.favorite_border,
            color: Color.fromARGB(165, 244, 67, 54),
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
      if (!context.mounted) return;
      // await SearchTextFieldModelProvider.read(context)
      //     ?.model
      //     .database
      //     .putLearn(textcontroller.text, text);
    } else {
      await SearchTextFieldModelProvider.read(context)
          ?.model
          .database
          .deleteFavorite(textcontroller.text);
      if (!context.mounted) return;
      // await SearchTextFieldModelProvider.read(context)
      //     ?.model
      //     .database
      //     .deleteLearn(textcontroller.text);
    }
    if (!context.mounted) return;
    flag = await SearchTextFieldModelProvider.watch(context)
            ?.model
            .database
            .containsFavorite(textcontroller.text) ??
        false;
    flag == true
        ? favoritButton = const Icon(
            Icons.favorite,
            color: Color.fromARGB(165, 244, 67, 54),
          )
        : favoritButton = const Icon(
            Icons.favorite_border,
            color: Color.fromARGB(165, 244, 67, 54),
          );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String lang =
        Provider.of<LanguageChoiceModelProvider>(context, listen: true)
            .languageChoiceModel
            .lang;
    String trans =
        Provider.of<LanguageChoiceModelProvider>(context, listen: true)
            .languageChoiceModel
            .trans;
    SearchTextFieldModelProvider.read(context)?.model.lang = lang;
    SearchTextFieldModelProvider.read(context)?.model.trans = trans;

    return Consumer<LanguageChoiceModelProvider>(
      builder: (context, value, child) => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
                child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 40, maxWidth: 120),
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Center(child: Text(lang))),
                    Expanded(
                      child: IconButton(
                          onPressed: () async {
                            Provider.of<LanguageChoiceModelProvider>(context,
                                    listen: false)
                                .replaceLanguage();
                          },
                          icon: const Icon(
                            Icons.compare_arrows,
                          )),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(child: Center(child: Text(trans))),
                  ],
                ),
              ),
            )),
            const SizedBox(
              height: 40,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 380, maxWidth: 380),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //  border: Border.all(color: Colors.blue),
                  // boxShadow: const [
                  //   BoxShadow(
                  //     offset: Offset(2, 2),
                  //     blurRadius: 0.5,
                  //     color: Colors.blue
                  //   ),
                  // ],
                  color: const Color.fromARGB(82, 124, 124, 133),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      TextField(
                        controller: textcontroller,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Поиск',
                        ),
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
                          IconButton(
                              onPressed: pressFavorit, icon: favoritButton)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
