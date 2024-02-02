import 'dart:io';
import 'package:almanac_of_wisdom/constants/colors.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:iconly/iconly.dart';

class Webpage extends StatefulWidget {
  final String webpageURL;
  final FirebaseAnalyticsObserver observer;

  const Webpage(this.observer, {super.key, required this.webpageURL});

  @override
  State<Webpage> createState() => _WebpageState();
}

class _WebpageState extends State<Webpage>
    with SingleTickerProviderStateMixin, RouteAware {
  final GlobalKey _webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewSettings options = InAppWebViewSettings(
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: false,
    useHybridComposition: false,
  );

  late PullToRefreshController pullToRefreshController;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: AppColors.negativeColor,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //For storing the page opening in firebase analytics
    widget.observer.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    widget.observer.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            IconlyLight.arrow_left_2,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    key: _webViewKey,
                    initialUrlRequest:
                        URLRequest(url: WebUri(widget.webpageURL)),
                    initialSettings: options,
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    onPermissionRequest: (controller, origin) async {
                      //Asks for permission to open URL in app
                      return PermissionResponse(
                          action: PermissionResponseAction.GRANT);
                    },
                    // onLoadStart: ,
                    onLoadStop: (controller, url) async {
                      pullToRefreshController.endRefreshing();
                    },
                    onReceivedError: (controller, url, code) {
                      pullToRefreshController.endRefreshing();
                    },
                    onProgressChanged: (controller, progress) {
                      if (progress == 100) {
                        pullToRefreshController.endRefreshing();
                      }
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      debugPrint(consoleMessage.message);
                    },
                  ),
                  progress < 1.0
                      ? LinearProgressIndicator(
                          value: progress,
                          color: AppColors.primaryColor,
                          backgroundColor: AppColors.negativeColor,
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
