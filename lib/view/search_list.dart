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
  late BannerAd banner;
  var isBannerAlreadyCreated = false;

  BannerAdSize _getAdSize() {
    final screenWidth = MediaQuery.of(context).size.width.round();
    return BannerAdSize.sticky(width: screenWidth - 20);
  }

  _createBanner() {
    return BannerAd(
        adUnitId: 'R-M-3186506-4', // or 'demo-banner-yandex'
        adSize: _getAdSize(),
        adRequest: const AdRequest(),
        onAdLoaded: () {
        },
        onAdFailedToLoad: (error) {
        },
        onAdClicked: () {
        },
        onLeftApplication: () {
        },
        onReturnedToApplication: () {
        },
        onImpression: (impressionData) {
        });
  }

  _loadAd() async {
    banner = _createBanner();
    setState(() {
      isBannerAlreadyCreated = true;
    });
  }

  @override
  void initState() {
    textcontroller.addListener(() {
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
    banner.destroy();
    super.dispose();
  }

  void dismissKeyboard() {
    focusNode.unfocus();
  }

  Future<void> initLanguage() async {
    Provider.of<LanguageChoiceModelProvider>(context, listen: true)
        .setLanguage();
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
    } else {
      await SearchTextFieldModelProvider.read(context)
          ?.model
          .database
          .deleteFavorite(textcontroller.text);
      if (!context.mounted) return;
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
    if (!isBannerAlreadyCreated) {
      _loadAd();
    }

    initLanguage();
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
                onPressed: () async {
                  Provider.of<LanguageChoiceModelProvider>(context,
                          listen: false)
                      .replaceLanguage();
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child:
                            Center(child: Text(lang == 'zh-cn' ? 'cn' : lang))),
                    const Icon(
                      Icons.compare_arrows,
                    ),
                    Expanded(
                        child: Center(
                            child: Text(trans == 'zh-cn' ? 'cn ' : trans))),
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
                        onTap: () {},
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
