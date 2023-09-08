import 'package:almanac_of_wisdom/constants/colors.dart';
import 'package:almanac_of_wisdom/constants/fonts.dart';
import 'package:almanac_of_wisdom/models/post_model.dart';
import 'package:flutter/material.dart';

class CustomWidget {
  static Widget postListTile(PostModel postModel) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            postModel.category!,
            style: AppFonts.subtitleFont(),
          ),
          Text(
            postModel.title!,
            style: AppFonts.subHeadingFont(),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 12,
            backgroundColor: AppColors.negativeColor,
          ),
          const SizedBox(width: 6),
          Text(
            postModel.publisherName!,
            style: AppFonts.subtitleFont(fontColor: AppColors.negativeColor),
          ),
          const SizedBox(width: 7),
          const CircleAvatar(
            radius: 2,
            backgroundColor: AppColors.tertiaryColor,
          ),
          const SizedBox(width: 7),
          Text(
            '${postModel.publishDate?.day} ${postModel.publishDate?.month}, ${postModel.publishDate?.year}',
            style: AppFonts.subtitleFont(),
          ),
        ],
      ),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset(
          postModel.imageURL!,
        ),
      ),
    );
  }
}
