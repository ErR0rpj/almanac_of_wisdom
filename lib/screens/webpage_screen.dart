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
    javaScriptEnabled: true,
    mediaPlaybackRequiresUserGesture: false,
    useHybridComposition: false,
  );

  late PullToRefreshController pullToRefreshController;
  double progress = 0;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: AppColors.negativeColor,
      ),
      onRefresh: () async {
        _hasError = false;
        webViewController?.reload();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.observer.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    widget.observer.unsubscribe(this);
    webViewController?.dispose();
    pullToRefreshController.dispose();
    super.dispose();
  }

  Future<bool> _handleBackPressed() async {
    if (webViewController != null) {
      bool canGoBack = await webViewController!.canGoBack();
      if (canGoBack) {
        webViewController!.goBack();
        return false;
      }
    }
    return true;
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline,
              size: 64, color: AppColors.negativeColor),
          const SizedBox(height: 16),
          const Text(
            'Failed to load webpage',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _hasError = false;
              });
              webViewController?.reload();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final shouldPop = await _handleBackPressed();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
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
                    if (!_hasError)
                      InAppWebView(
                        key: _webViewKey,
                        initialUrlRequest: URLRequest(
                            url: WebUri.uri(Uri.parse(widget.webpageURL))),
                        initialSettings: options,
                        pullToRefreshController: pullToRefreshController,
                        onWebViewCreated: (controller) {
                          webViewController = controller;
                        },
                        onPermissionRequest: (controller, origin) async {
                          return PermissionResponse(
                              action: PermissionResponseAction.GRANT);
                        },
                        onLoadStop: (controller, url) async {
                          pullToRefreshController.endRefreshing();
                        },
                        onReceivedError: (controller, url, code) {
                          pullToRefreshController.endRefreshing();
                          setState(() {
                            _hasError = true;
                          });
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
                    if (_hasError) _buildErrorWidget(),
                    if (!_hasError && progress < 1.0)
                      LinearProgressIndicator(
                        value: progress,
                        color: AppColors.primaryColor,
                        backgroundColor: AppColors.negativeColor,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
