import 'package:almanac_of_wisdom/models/post_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Globals {
  static String privacyPolicyURL =
      "https://stavancoj.wixsite.com/almanac-of-wisdom/privacy-policy";

  static PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

       //Set user settings when app is started.
  static Future<void> setGlobals() async {
    final info = await PackageInfo.fromPlatform();
    packageInfo = info;
  }

   static List<PostModel> allPostsList = [
    PostModel(
      postId: 'alpha-ideas-main',
      title: 'Investment Blog for the Indian Markets',
      category: 'Markets',
      imageURL:
          'https://archive.org/download/alphaideaas/alphaideaas.jpg',
      externalURL:
          'https://alphaideas.in/',
      publisherName: 'Alpha Ideas',
      publisherId: 'alpha-ideas',
      publisherProfileImageURL:
          "https://archive.org/download/alpha-ideas/alpha-ideas.jpg",
      publishDate: DateTime.now(),
    ),
    PostModel(
      postId: 'alpha-ideas-book-reviews',
      title: 'Book Reviews by Alpha Ideas',
      category: 'Business',
      imageURL:
          'https://archive.org/download/alphaideaas/alphaideaas.jpg',
      externalURL:
          'https://alphaideas.in/book-reviews/',
      publisherName: 'Alpha Ideas',
      publisherId: 'alpha-ideas',
      publisherProfileImageURL:
          "https://archive.org/download/alpha-ideas/alpha-ideas.jpg",
      publishDate: DateTime.now().subtract(const Duration(days: 90)),
    ),
     PostModel(
      postId: 'finshots-daily',
      title: 'Finshots Daily',
      category: 'Finance',
      imageURL:
          'https://archive.org/download/unnamed_20240924/unnamed.webp',
      externalURL:
          'https://finshots.in/archive/',
      publisherName: 'Finshots',
      publisherId: 'finshots',
      publisherProfileImageURL:
          "https://finception.in/static/images/finshots.png",
      publishDate: DateTime.now(),
    ),
    PostModel(
      postId: 'finshots-money',
      title: 'Finshots Money: Your Personal Finance Guide',
      category: 'Personal Finance',
      imageURL:
          'https://archive.org/download/chasing-the-fire-MM4-1-/chasing-the-fire-MM4-1-.jpg',
      externalURL:
          'https://finshots.in/tag/money/',
      publisherName: 'Finshots',
      publisherId: 'finshots',
      publisherProfileImageURL:
          "https://finception.in/static/images/finshots.png",
       publishDate: DateTime.now().subtract(const Duration(days: 30)),
    ),
    PostModel(
      postId: 'finshots-infographics',
      title: 'Finshots Infographics',
      category: 'Finance',
      imageURL:
          'https://d3jlwjv6gmyigl.cloudfront.net/images/2020/09/UPI-Growth.png',
      externalURL:
          'https://finshots.in/infographic/',
      publisherName: 'Finshots',
      publisherId: 'finshots',
      publisherProfileImageURL:
          "https://finception.in/static/images/finshots.png",
      publishDate:DateTime.now().subtract(const Duration(days: 10)),
    ),
    PostModel(
      postId: 'zerodha-z-connect',
      title: 'Z-Connect: All About Zerodha',
      category: 'Various',
      imageURL:
          'https://zerodha.com/z-connect/wp-content/uploads/2024/02/thumb.png',
      externalURL:
          'https://zerodha.com/z-connect/subtext',
      publisherName: 'Zerodha',
      publisherId: 'zerodha',
      publisherProfileImageURL:
          "https://ia801906.us.archive.org/31/items/zerodha_202409/zerodha.jpg",
      publishDate: DateTime.now().subtract(const Duration(days:7)),
    ),
     PostModel(
      postId: 'the-daily-brief-zerodha',
      title: 'The Daily Brief: Indian and Global Markets',
      category: 'Markets',
      imageURL:
          'https://is1-ssl.mzstatic.com/image/thumb/Podcasts211/v4/2a/00/10/2a001007-fb3e-95a1-d902-a02da41c1766/mza_14800515352391780617.jpg/1200x630wp.png',
      externalURL:
          'https://thedailybriefing.substack.com/',
      publisherName: 'Zerodha',
      publisherId: 'zerodha',
      publisherProfileImageURL:
          "https://ia801906.us.archive.org/31/items/zerodha_202409/zerodha.jpg",
      publishDate: DateTime.now(),
    ),
     PostModel(
      postId: 'substack-nithin-kamath',
      title: "Nithin Kamath's Substack",
      category: 'Various',
      imageURL:
          'https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com%2Fpublic%2Fimages%2F4ed5e4ce-356b-49dd-b5ce-f5a7f37514f4_719x384.png',
      externalURL:
          'https://substack.com/@nithinkamath',
      publisherName: 'Nithin Kamath',
      publisherId: 'nithin-kamath',
      publisherProfileImageURL:
          "https://substackcdn.com/image/fetch/w_176,h_176,c_fill,f_webp,q_auto:good,fl_progressive:steep,g_auto/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F00a7e24f-36dd-4358-9595-bb0f0f56e696_400x400.jpeg",
      publishDate: DateTime.now().subtract(const Duration(days:10)),
    ),

    ];
   }
