import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:daum_postcode_search/daum_postcode_search.dart';

import 'package:flutter/material.dart';

import '../screen/kakao/kakao_postcod_screen.dart';



class AddressUtils {
  // 도로명 주소로부터 경도 위도를 받아오고, db에 저장하는 함수.
  static Future<void> getAndSaveLatLogfromRoadAddress(
      {required String roadAddress}) async {
    String address = roadAddress;
    print("주소 출력 \n ${address}");
    String gpsUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=AIzaSyAji6aWPEUHHeeqh2B5mLXqXPrM2QE58qU';
    final responseGps = await http.get(Uri.parse(gpsUrl));
    if (responseGps != null) {
      print("위도경도 출력");
      //print(jsonDecode(responseGps.body)['results'][0]['geometry']['location']);
      double lat = jsonDecode(responseGps.body)['results'][0]['geometry']
          ['location']['lat'];
      print(lat);
      double lng = jsonDecode(responseGps.body)['results'][0]['geometry']
          ['location']['lng'];
      print(lng);

      final user = Hive.box('info');
      user.put('lat', lat);
      user.put('lng', lng);
    } else {
      print("google map response값이 null입니다");
    }
  }

  // 주소 검색 메소드 -> 검색후, 도로명 주소, 우편번호, 경도, 위도를 db에 저장.
  static void searchMyAddress(context) {
    DataModel? _dataModel;
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const KakaoPostcodScreen();
        },
      ),
    ).then(
      (value) {
        if (value != null) {
          _dataModel = value;

          final user = Hive.box('info');
          // 도로명주소, 우편번호 db 저장.
          user.put('road_address', _dataModel!.roadAddress);
          user.put('zone_code', _dataModel!.zonecode);
          AddressUtils.getAndSaveLatLogfromRoadAddress(
              roadAddress: _dataModel!.roadAddress);
        }
      },
    );
  }
}
