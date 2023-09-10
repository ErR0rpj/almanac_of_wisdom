import 'dart:math';

import 'package:flutter/material.dart';

class PostModel {
  //TBD how to create this uniquely.
  final String postId;
  //Title of the post. Shown in feed
  String? title;
  //Categories: Wealth, Judgement, Happiness, self-enlightenment, philosophy, others
  String? category;
  //Image which is shown on feed.
  String? imageURL;
  //TOOD: Create search key words
  String? searchKeywords;

  //Link from where we can read the full article or most parts of it.
  String? externalURL;

  //The number of users who saved this post
  int saveCount = 0;
  //Total number of clicks on this content
  int views = 0;
  //Total number of shares of this content
  int sharesCount = 0;
  //Total time spent by all users. To think how to measure
  int totalTimeSpent = 0;
  //Average time spent by users on this post.
  int averageTimeSpent = 0;

  //Author/Publisher name
  String? publisherName;
  //The user id of the publisher
  String? publisherId;
  //The date on which post was pusblished
  DateTime? publishDate;
  //Profile image for publisher
  String? publisherProfileImageURL;
  //Document ID of next recommended chapter/topic. Related to this
  String? nextRecommendedPost;
  //Recommended Posts
  List<String>? recommendedPost;

  //Local vairables
  //Used for placeholder image of this post
  late Widget imageErrorWidget;

  PostModel({
    required this.postId,
    this.title,
    this.category,
    this.imageURL,
    this.searchKeywords,
    this.externalURL,
    this.saveCount = 0,
    this.views = 0,
    this.sharesCount = 0,
    this.totalTimeSpent = 0,
    this.averageTimeSpent = 0,
    this.publisherName,
    this.publisherId,
    this.publishDate,
    this.publisherProfileImageURL,
    this.nextRecommendedPost,
    this.recommendedPost,
  }) {
    //TODO: Set default image in the UI end
    //TODO: if image is null then assign a default according to the category
    assignImageErrorWidget();
  }

  //Assigns a random asset image which is shown in case of error.
  void assignImageErrorWidget() async {
    imageErrorWidget = Image.asset(
      'images/${Random().nextInt(8)}.jpg',
      fit: BoxFit.cover,
      height: 90,
      width: 90,
    );
  }
}
