import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ssaksuri/screen/home_screen.dart';

import '../const/colors.dart';
import '../mainpage.dart';

class KakaoLoginScreen extends StatelessWidget {
  void _get_user_info() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        color: darkColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/img/cute_bear.png',
              height: 200,
              width: 200,
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              child: Text('싹쓰리'),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                print(await KakaoSdk.origin);
                if (await isKakaoTalkInstalled()) {
                  try {
                    await UserApi.instance.loginWithKakaoTalk();
                    print('카카오톡으로 로그인 성공');
                    _get_user_info();
                  } catch (error) {
                    print('카카오톡으로 로그인 실패 $error');
                    // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공');
                      _get_user_info();
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  }
                } else {
                  try {
                    await UserApi.instance.loginWithKakaoAccount();
                    print('카카오계정으로 로그인 성공');
                    _get_user_info();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        builder: (context) => const MainPage()), (route) => false);
                  } catch (error) {
                    print('카카오계정으로 로그인 실패 $error');
                  }
                }
              },
              child: Image.asset("assets/img/kakao_login_medium_wide.png"),
            ),
          ],
        ),
      ),
    );
  }
}
