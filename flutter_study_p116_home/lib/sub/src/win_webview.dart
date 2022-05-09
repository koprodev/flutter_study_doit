import 'package:flutter/material.dart';
import 'dart:async';

import 'package:webview_windows/webview_windows.dart';

class WinWebView extends State {
  final _controller = WebviewController();
  String siteurl = 'https://ezy.kr';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    await _controller.initialize();
    await _controller.setBackgroundColor(Colors.transparent);
    await _controller.loadUrl(siteurl);

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                  child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        children: [
                          Webview(
                            _controller,
                          ),
                          StreamBuilder<LoadingState>(
                              stream: _controller.loadingState,
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data == LoadingState.loading) {
                                  return const LinearProgressIndicator();
                                } else {
                                  return const SizedBox();
                                }
                              }),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
