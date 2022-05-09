import 'package:flutter/material.dart';

import 'src/win_webview.dart';

/* -------------- GW ---------------- */
class GrtechWebsiteGW extends StatefulWidget {
  const GrtechWebsiteGW({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State createState() {
    var winWebView = WinWebView();
    winWebView.siteurl = 'https://ezy.kr';
    return winWebView;
  }
}
