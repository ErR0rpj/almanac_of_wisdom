import 'dart:convert';

import 'package:almanac_of_wisdom/core/utils/typedef.dart';
import 'package:almanac_of_wisdom/src/domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.title,
    required super.category,
    required super.imageURL,
    required super.searchKeywords,
    required super.publisherId,
    super.externalURL,
    super.saveCount = 0,
    super.views = 0,
    super.sharesCount = 0,
    super.totalTimeSpent = 0,
    super.averageTimeSpent = 0,
    required super.publishDate,
  });

  ///This is used to change the variable values of a model. It copies the
  ///data which is not changed.
  PostModel copyWith({
    int? saveCount,
    int? views,
    int? sharesCount,
    int? totalTimeSpent,
    int? averageTimeSpent,
  }) {
    return PostModel(
      id: id,
      title: title,
      category: category,
      imageURL: imageURL,
      searchKeywords: searchKeywords,
      publisherId: publisherId,
      externalURL: externalURL,
      saveCount: saveCount ?? this.saveCount,
      views: views ?? this.views,
      sharesCount: sharesCount ?? this.sharesCount,
      totalTimeSpent: totalTimeSpent ?? this.totalTimeSpent,
      averageTimeSpent: averageTimeSpent ?? this.averageTimeSpent,
      publishDate: publishDate,
    );
  }

  ///This gives post model from the json input.
  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(jsonDecode(source) as ModelMap);

  ///Post model from a map<String, dynamic>.
  PostModel.fromMap(ModelMap map)
      : this(
          id: map['id'] as String,
          title: map['title'] as String,
          category: map['category'] as String,
          imageURL: map['imageURL'] as String,
          searchKeywords: map['searchKeywords'] as String,
          publisherId: map['publisherId'] as String,
          externalURL: map['externalURL'] as String,
          saveCount: map['saveCount'] as int,
          views: map['views'] as int,
          sharesCount: map['sharesCount'] as int,
          totalTimeSpent: map['totalTimeSpent'] as int,
          averageTimeSpent: map['averageTimeSpent'] as int,
          publishDate: map['publishDate'] as DateTime,
        );
}
