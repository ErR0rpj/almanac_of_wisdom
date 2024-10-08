import 'package:almanac_of_wisdom/constants/colors.dart';
import 'package:almanac_of_wisdom/constants/fonts.dart';
import 'package:almanac_of_wisdom/constants/globals.dart';
import 'package:almanac_of_wisdom/models/post_model.dart';
import 'package:almanac_of_wisdom/screens/webpage_screen.dart';
import 'package:almanac_of_wisdom/services/searchify.dart';
import 'package:almanac_of_wisdom/utils/custom_widgets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HomePage extends StatefulWidget {
  const HomePage(this.observer, {super.key});

  final FirebaseAnalyticsObserver observer;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage>
    with SingleTickerProviderStateMixin, RouteAware {
  //Used in animation of text moving in subtitle
  final double _transitionHeight = 20;

  //List containing the items which are visible on screen
  final List<PostModel> _visibleItems = [];

  //Search related variables
  final TextEditingController _searchTextEditingController =
      TextEditingController();
  final ScrollController _listScrollController = ScrollController();
  bool isBasicSearchEmpty = false;
  bool _showProgress = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //For storing the page opening in firebase analytics
    widget.observer.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  //Here 2nd variable determines whether the user is searching within the list or
  //he is querying the whole list for first time.
  Future<void> _fetchPosts(
      {String? searchQuery, bool isSearching = false}) async {
    setState(() {
      _showProgress = true;
    });

    if (searchQuery != null && isSearching == true) {
      isBasicSearchEmpty = Searchify(
        query: searchQuery,
        allItemsList: Globals.allPostsList,
        searchedItemsList: _visibleItems,
      ).basicSearch();
    } else {
      _visibleItems.clear();
      for (int i = 0; i < Globals.allPostsList.length; i++) {
        _visibleItems.add(Globals.allPostsList[i]);
      }
      _visibleItems.sort((b, a) {
        return (a.publishDate).compareTo((b.publishDate));
      });
      await Future.delayed(const Duration(seconds: 1));
    }

    setState(() {
      _showProgress = false;
    });
  }

  @override
  void dispose() {
    _searchTextEditingController.clear();
    widget.observer.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: RefreshIndicator(
          onRefresh: _fetchPosts,
          color: AppColors.primaryColor,
          backgroundColor: AppColors.negativeColor,
          child: SingleChildScrollView(
            controller: _listScrollController,
            child: Container(
              color: AppColors.primaryColor,
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: AppFonts.titleFont(),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Almanac-Of',
                                  style: AppFonts.titleFont(
                                      fontColor: AppColors.tertiaryColor),
                                ),
                                const TextSpan(
                                  text: '-Wisdom',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Build your ',
                                style: AppFonts.subtitleFont(),
                              ),
                              DefaultTextStyle(
                                style: AppFonts.subtitleFont(
                                  fontColor: AppColors.accentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    RotateAnimatedText('Wealth',
                                        transitionHeight: _transitionHeight),
                                    RotateAnimatedText('Happiness',
                                        transitionHeight: _transitionHeight),
                                    RotateAnimatedText('Wisdom',
                                        transitionHeight: _transitionHeight),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Webpage(widget.observer,
                                  webpageURL: Globals.privacyPolicyURL),
                            ),
                          );
                        },
                        child: const Icon(
                          IconlyLight.setting,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const Icon(IconlyLight.search),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            color: Color.fromARGB(224, 226, 226, 231),
                          ),
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.only(
                              left: 16, right: 14, top: 14, bottom: 14),
                          child: TextField(
                            controller: _searchTextEditingController,
                            style: AppFonts.subtitleFont(
                                fontColor: AppColors.negativeColor,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              constraints: BoxConstraints(maxHeight: 28),
                              hintText:
                                  'Try searching "Finshots, Alpha Ideas, etc"',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              _fetchPosts(
                                  searchQuery: value, isSearching: true);

                              _listScrollController.animateTo(
                                _listScrollController.position.minScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                              );
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _searchTextEditingController.text.isEmpty
                            ? false
                            : true,
                        child: InkWell(
                          onTap: () {
                            _searchTextEditingController.text = '';
                            FocusScope.of(context).requestFocus(FocusNode());
                            _fetchPosts();
                          },
                          child: const Icon(IconlyLight.close_square),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Text('Daily Reads', style: AppFonts.headingFont()),
                  const SizedBox(height: 10),
                  _showProgress
                      ? const Center(
                          child: LinearProgressIndicator(
                            color: AppColors.primaryColor,
                            backgroundColor: AppColors.primaryColor,
                          ),
                        )
                      : _visibleItems.isEmpty
                          ? Center(
                              child: Text(
                                'Nothing found!\nTry searching for something else.',
                                style: AppFonts.subtitleFont(
                                    fontColor: AppColors.negativeColor),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _visibleItems.length,
                              itemBuilder: (context, index) {
                                return CustomWidget.postListTile(
                                    widget.observer,
                                    _visibleItems[index],
                                    context);
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  height: 1,
                                  color: Color.fromARGB(255, 245, 245, 249),
                                );
                              },
                            ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icon/aw_logo.png',
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text.rich(
                            TextSpan(text: '© Almanac-Of-', children: [
                              TextSpan(
                                  text: 'Wisdom',
                                  style: TextStyle(
                                    color: AppColors.accentColor,
                                  )),
                            ]),
                            style: TextStyle(
                              color: AppColors.tertiaryColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'v${Globals.packageInfo.version} (${Globals.packageInfo.buildNumber})',
                            style: const TextStyle(
                                color: AppColors.tertiaryColor, fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
