import 'dart:math';
import 'package:almanac_of_wisdom/constants/colors.dart';
import 'package:almanac_of_wisdom/constants/fonts.dart';
import 'package:almanac_of_wisdom/models/post_model.dart';
import 'package:almanac_of_wisdom/screens/webpage_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomWidget {
  static Widget _placeholderImageForProfilePicture(String letter) {
    return Text(
      letter,
      style: GoogleFonts.lato(
        color: AppColors.primaryColor,
      ),
    );
  }

  //Used in home page list
  static Widget postListTile(FirebaseAnalyticsObserver observer,
      PostModel postModel, BuildContext context) {

    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                Webpage(observer, webpageURL: postModel.externalURL!),
          ),
        );
      },
      contentPadding: const EdgeInsets.all(10),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            postModel.category,
            style: AppFonts.subtitleFont(),
          ),
          Text(
            postModel.title,
            style: AppFonts.subHeadingFont(),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: AppColors.negativeColor,
            child: postModel.publisherProfileImageURL == null
                ? _placeholderImageForProfilePicture(postModel.publisherName[0])
                : ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: postModel.publisherProfileImageURL!,
                      placeholder: (context, url) {
                        return _placeholderImageForProfilePicture(
                            postModel.publisherName[0]);
                      },
                      errorWidget: (context, url, dynamic) {

                        return _placeholderImageForProfilePicture(
                            postModel.publisherName[0]);
                      },
                    ),
                  ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              postModel.publisherName,
              style: AppFonts.subtitleFont(fontColor: AppColors.negativeColor),
            ),
          ),
          const SizedBox(width: 7),
          const CircleAvatar(
            radius: 2,
            backgroundColor: AppColors.tertiaryColor,
          ),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              '${postModel.publishDate.day} ${DateFormat('MMM').format(postModel.publishDate)}, ${postModel.publishDate.year}',
              style: AppFonts.subtitleFont(),
            ),
          ),
        ],
      ),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: postModel.imageURL!,
          fit: BoxFit.cover,
          height: 150,
          width: 100,
          errorWidget: (context, url, error) {
            return postModel.imageErrorWidget != null
                ? postModel.imageErrorWidget!
                : Image.asset(
                    'images/${Random().nextInt(8)}.jpg',
                    fit: BoxFit.cover,
                    height: 90,
                    width: 90,
                  );
          },
        ),
      ),
    );
  }
}
