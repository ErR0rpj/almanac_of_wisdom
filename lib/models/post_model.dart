class PostModel {
  //TBD how to create this uniquely.
  final String postId;
  //Title of the post. Shown in feed
  String? title;
  //Categories: Wealth, Judgement, Happiness, self-enlightenment, philosophy, others
  String? category;
  //Image which is shown on feed.
  String? imageURL;

  //Link from where we can read the full article or most parts of it.
  String? externalLink;
  //This is mainly used to see if the position of the content is intact. Meaning
  //When the content of the post is loaded, we are not sure where to put which
  //part of the content. So, position is given inside the content to determine it.
  //Along with position, the ID of the content also resembles the postion. But
  //if the position vairable is changed, the id cannot be changed. So, the below
  //variable determines that. If its true means content id and position are same
  //otherwise, they might be different.
  bool isContentPositionIntact = true;
  int contentCount = 0;

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
  //Document ID of next recommended chapter/topic. Related to this
  String? nextRecommendedPost;
  //Recommended Posts
  List<String>? recommendedPost;

  PostModel({
    required this.postId,
    this.title,
    this.category,
    this.imageURL,
    this.externalLink,
    this.isContentPositionIntact = true,
    this.contentCount = 0,
    this.saveCount = 0,
    this.views = 0,
    this.sharesCount = 0,
    this.totalTimeSpent = 0,
    this.averageTimeSpent = 0,
    this.publisherName,
    this.publisherId,
    this.publishDate,
    this.nextRecommendedPost,
    this.recommendedPost,
  });
}
