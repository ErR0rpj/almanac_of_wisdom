//THis is the search algorithm
//TODO: Optimise this
import 'package:almanac_of_wisdom/models/post_model.dart';
import 'package:almanac_of_wisdom/services/string_manipulation.dart';
import 'package:flutter/material.dart';
import 'package:sortedmap/sortedmap.dart';

class Searchify {
  final SortedMap _map = SortedMap(const Ordering.byValue());

  String query = '';
  List<PostModel> allItemsList;
  List<PostModel> searchedItemsList;

  Searchify({
    this.query = '',
    required this.allItemsList,
    required this.searchedItemsList,
  });

  void _wordWiseSearch() {
    searchedItemsList.clear();
    query = query.toLowerCase().trim();

    //This condition is added because if query was equal to '' then no songs were shown previously.
    if (query == '') {
      for (int i = 0; i < allItemsList.length; i++) {
        searchedItemsList.add(allItemsList[i]);
      }
    } else {
      List<String> words = query.split(' ');

      for (int i = 0; i < allItemsList.length; i++) {
        int songScore = 0;
        String searchKeywords = StringManipulation.removeWhiteSpaces(
            allItemsList[i].searchKeywords);

        if (_map.containsKey(i)) {
          songScore = _map[i];
        }

        for (int j = 0; j < words.length; j++) {
          String word = words[j].trim();
          if (word.isNotEmpty && searchKeywords.contains(word)) {
            songScore = songScore + 1;
          }
        }

        if (songScore > 0) {
          _map[i] = songScore;
        }
      }

      _map.forEach((key, value) {
        int keyInt = int.parse(key.toString());
        debugPrint('${allItemsList[keyInt].title} added');
        searchedItemsList.insert(0, allItemsList[keyInt]);
        debugPrint('${searchedItemsList[0].title} added at position 0');
      });
    }
  }

  bool basicSearch() {
    bool isBasicSearchEmpty = true;
    searchedItemsList.clear();
    query = query.toLowerCase();
    String tempquery = StringManipulation.removeWhiteSpaces(query);

    //This condition is added because if query was equal to '' then no songs were shown.
    if (query == '' || tempquery == '') {
      isBasicSearchEmpty = false;
      for (int i = 0; i < allItemsList.length; i++) {
        searchedItemsList.add(allItemsList[i]);
      }
    } else {
      int noOfWords = query.split(' ').length;
      for (int i = 0; i < allItemsList.length; i++) {
        if (allItemsList[i].searchKeywords.contains(query)) {
          isBasicSearchEmpty = false;
          _map[i] = noOfWords * 2;
        }
      }
      _wordWiseSearch();
    }

    return isBasicSearchEmpty;
  }
}
