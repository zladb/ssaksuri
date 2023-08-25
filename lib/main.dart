import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ssaksuri/model/request_item_model.dart';
import 'package:ssaksuri/screen/home_screen.dart';
import 'package:ssaksuri/screen/kakao/kakao_login_screen.dart';

import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'mainpage.dart';

void main() async {
  KakaoSdk.init(nativeAppKey: '4cbec56571e3eee55285c024d79d5894');

  // Hive init
  await Hive.initFlutter();

  // ItemModel 어댑터 등록
  Hive.registerAdapter<ItemModel>(ItemModelAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: 'p3gvx5azub',
      onAuthFailed: (ex) {
        print("********* 네이버맵 인증오류 : $ex *********");
      });

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
