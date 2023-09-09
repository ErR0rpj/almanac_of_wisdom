import 'package:almanac_of_wisdom/constants/colors.dart';
import 'package:almanac_of_wisdom/constants/fonts.dart';
import 'package:almanac_of_wisdom/models/post_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomWidget {
  //Used in home page list
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
          CircleAvatar(
            radius: 12,
            backgroundColor: AppColors.negativeColor,
            child: postModel.publisherProfileImageURL == null
                ? Text(
                    postModel.publisherName![0],
                    style: GoogleFonts.lato(
                      color: AppColors.primaryColor,
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: postModel.publisherProfileImageURL!),
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
            '${postModel.publishDate?.day} ${DateFormat('MMM').format(postModel.publishDate!)}, ${postModel.publishDate?.year}',
            style: AppFonts.subtitleFont(),
          ),
        ],
      ),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          postModel.imageURL!,
          fit: BoxFit.cover,
          height: 200,
          width: 100,
        ),
      ),
    );
  }
}
