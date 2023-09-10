import 'package:almanac_of_wisdom/constants/colors.dart';
import 'package:almanac_of_wisdom/constants/fonts.dart';
import 'package:almanac_of_wisdom/constants/globals.dart';
import 'package:almanac_of_wisdom/models/post_model.dart';
import 'package:almanac_of_wisdom/services/searchify.dart';
import 'package:almanac_of_wisdom/utils/custom_widgets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  //Used in animation of text moving in subtitle
  final double _transitionHeight = 20;

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

  //Here 2nd variable determines whether the user is searching within the list or
  //he is querying the whole list for first time.
  void _fetchPosts({String? searchQuery, bool isSearching = false}) async {
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
    }

    setState(() {
      _showProgress = false;
    });
  }

  @override
  void dispose() {
    _searchTextEditingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          controller: _listScrollController,
          child: Container(
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
                                  RotateAnimatedText('Judgement',
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
                          color: Color.fromARGB(222, 245, 245, 249),
                        ),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.only(
                            left: 16, right: 14, top: 18, bottom: 10),
                        child: TextField(
                          controller: _searchTextEditingController,
                          style: AppFonts.subtitleFont(
                              fontColor: AppColors.negativeColor,
                              fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            constraints: BoxConstraints(maxHeight: 28),
                            hintText: 'Try searching "How to build wealth"',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _fetchPosts(searchQuery: value, isSearching: true);

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
                Text('For You', style: AppFonts.headingFont()),
                const SizedBox(height: 10),
                _showProgress
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.secondaryColor),
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
                                  _visibleItems[index], context);
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 1,
                                color: Color.fromARGB(255, 245, 245, 249),
                              );
                            },
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
