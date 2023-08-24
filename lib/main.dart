import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ssaksuri/screen/home_screen.dart';
import 'package:ssaksuri/screen/kakao_login_screen.dart';

import 'mainpage.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '4cbec56571e3eee55285c024d79d5894');

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'KimjungchulGothic',
      ),
      // home: MainPage(),
      home: KakaoLoginScreen(),
    ),
  );
}
