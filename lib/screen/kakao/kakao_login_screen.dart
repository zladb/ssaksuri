import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ssaksuri/screen/home_screen.dart';
import 'package:ssaksuri/screen/initialize_address.dart';

import '../../const/colors.dart';
import '../../mainpage.dart';
import '../../model/kakao_login_fn.dart';
import '../../model/request_item_model.dart';


class KakaoLoginScreen extends StatelessWidget {
  User? user;

  void userDbRegister() async {
    get_user_info().then(
      (user) async {
        if (user != null) {
          this.user = user;
          // 회원번호로 box를 연다.
          await Hive.openBox<ItemModel>('${user?.id}');
          await Hive.openBox('info');
          final box = Hive.box('info');
          box.put('id', user.id);
          box.put('nickname', user.kakaoAccount!.profile!.nickname);
          box.put('mileage', 0);
          box.put('lat', 35.8836825);
          box.put('lng', 128.5941278);
          box.put('road_address', '대구광역시 북구 호암로 51');
          box.put('zone_code', '41585');
          print('keys : ${box.keys.toList()}');
          print('values : ${box.values.toList()}');
        }
      },
    );
  }

  void userDbRegisterDummy() async {
          // // 회원번호로 box를 연다.
          // await Hive.openBox<ItemModel>('123');
          // await Hive.openBox('info');
          // final box = Hive.box('info');
          // box.put('id', 123);
          // box.put('nickname', '익명의 카멜레온');
          // box.put('mileage', 0);
          // print('keys : ${box.keys.toList()}');
          // print('values : ${box.values.toList()}');
  }

  void _goToHomeScreen(context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainPage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            const DefaultTextStyle(
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              child: Text('싹쓰리'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                print(await KakaoSdk.origin);
                if (await isKakaoTalkInstalled()) {
                  try {
                    await UserApi.instance.loginWithKakaoTalk();
                    print('카카오톡으로 로그인 성공');
                    get_user_info();
                    userDbRegister();
                    // userDbRegisterDummy();
                    _goToHomeScreen(context);
                  } catch (error) {
                    print('카카오톡으로 로그인 실패 $error');
                    userDbRegisterDummy();
                    _goToHomeScreen(context);
                    // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공');
                      get_user_info();
                      userDbRegister();
                      // userDbRegisterDummy();
                      _goToHomeScreen(context);
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                      userDbRegisterDummy();
                      _goToHomeScreen(context);
                    }
                  }
                } else {
                  try {
                    await UserApi.instance.loginWithKakaoAccount();
                    print('카카오계정으로 로그인 성공');
                    get_user_info();
                    userDbRegister();
                    // userDbRegisterDummy();
                    _goToHomeScreen(context);
                  } catch (error) {
                    print('카카오계정으로 로그인 실패 $error');
                    userDbRegisterDummy();
                    _goToHomeScreen(context);
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

  // int _reverseOrder(k1, k2) {
  //   if (k1 is int) {
  //     if (k2 is int) {
  //       if (k1 > k2) {
  //         return -1;
  //       } else if (k1 < k2) {
  //         return 1;
  //       } else {
  //         return 0;
  //       }
  //     } else {
  //       return -1;
  //     }
  //   }
  // }
}
