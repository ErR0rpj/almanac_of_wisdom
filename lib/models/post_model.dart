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
  String? externalLink;

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
  String? publisherProfileImage;
  //Document ID of next recommended chapter/topic. Related to this
  String? nextRecommendedPost;
  //Recommended Posts
  List<String>? recommendedPost;

  PostModel({
    required this.postId,
    this.title,
    this.category,
    this.imageURL,
    this.searchKeywords,
    this.externalLink,
    this.saveCount = 0,
    this.views = 0,
    this.sharesCount = 0,
    this.totalTimeSpent = 0,
    this.averageTimeSpent = 0,
    this.publisherName,
    this.publisherId,
    this.publishDate,
    this.publisherProfileImage,
    this.nextRecommendedPost,
    this.recommendedPost,
  }) {
    //TODO: Set default image in the UI end
    //TODO: if image is null then assign a default according to the category
  }
}
