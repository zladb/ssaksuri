import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class AddressUtils {
  // 도로명 주소로부터 경도 위도를 받아오고, db에 저장하는 함수.
  static Future<void> getAndSaveLatLogfromRoadAddress({required String roadAddress}) async {
    String address = roadAddress;
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
}
