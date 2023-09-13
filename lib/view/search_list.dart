import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_word/model/language_choice_model.dart';
import 'parent_list.dart';
import '../model/search_textfield_model.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import 'dart:async';

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
  late FocusNode focusNode;
  bool flag = false;
  String text = ' ';
  Timer _debounce = Timer(const Duration(milliseconds: 500), () {});

  @override
  void initState() {
    textcontroller.addListener((){
 if (_debounce.isActive) _debounce.cancel();
    {
      _debounce = Timer(const Duration(milliseconds: 1000), onTapSearch);
    }
    });
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    _debounce.cancel();
    super.dispose();
  }

  void dismissKeyboard() {
    focusNode.unfocus();
  }

  Future<void> onTapSearch() async {
   
    String enter = textcontroller.text;
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

  final banner = BannerAd(
    adUnitId: 'R-M-2953427-3',
    adSize: const AdSize.sticky(width: 400),
    adRequest: const AdRequest(),
    onAdLoaded: () {
      /* Do something */
    },
    onAdFailedToLoad: (error) {
      /* Do something */
    },
  );

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
                            setState(() {});
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
                  //  border: Border.all(color: Color.fromARGB(21, 0, 0, 0),width: 5),
                  boxShadow: const [
                    BoxShadow(
                        //  offset: Offset(2, 2),
                        blurRadius: 10,
                        color: Color.fromARGB(79, 64, 64, 64)),
                  ],
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      TextField(
                        controller: textcontroller,
                        onTap: () {
                         // Future.delayed(const Duration(seconds: 1), () {});
                        },
                        onTapOutside: (event) {
                          dismissKeyboard();
                          onTapSearch();
                        },
                        onEditingComplete: () {
                          dismissKeyboard();
                          onTapSearch();
                        },
                        focusNode: focusNode,
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
            ),
            const SizedBox(height: 50),
            AdWidget(bannerAd: banner),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
