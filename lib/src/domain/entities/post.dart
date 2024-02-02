import 'package:equatable/equatable.dart';

///This entity is for post which are shown.
class Post extends Equatable {
  const Post({
    required this.id,
    required this.title,
    required this.category,
    required this.imageURL,
    required this.searchKeywords,
    required this.publisherId,
    this.externalURL,
    required this.saveCount,
    required this.views,
    required this.sharesCount,
    required this.totalTimeSpent,
    required this.averageTimeSpent,
    required this.publishDate,
  });

  //TBD how to create this uniquely.
  final String id;
  //Title of the post. Shown in feed
  final String title;
  //Categories: Wealth, Judgement, Happiness, self-enlightenment, philosophy, others
  final String category;
  //Image which is shown on feed.
  final String? imageURL;
  //TODO: Create search key words
  final String searchKeywords;
  //The user id of the publisher
  final String publisherId;
  //Link from where we can read the full article or most parts of it.
  final String? externalURL;

  //The number of users who saved this post
  final int saveCount;
  //Total number of clicks on this content
  final int views;
  //Total number of shares of this content
  final int sharesCount;
  //Total time spent by all users. To think how to measure
  final int totalTimeSpent;
  //Average time spent by users on this post.
  final int averageTimeSpent;
  //The date on which post was pusblished
  final DateTime publishDate;

  ///This overrides the == operator with equatable package.
  ///It checks the id for both the object and if they are same
  ///the objects are considered same.
  @override
  List<Object?> get props => [id];
}
