import 'dart:convert';

import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../utils/adress_utils.dart';
import 'kakao_postcod_screen.dart';

class SearchPostcodeScreen extends StatefulWidget {
  const SearchPostcodeScreen({super.key});

  @override
  State<SearchPostcodeScreen> createState() => _SearchPostcodeScreenState();
}

class _SearchPostcodeScreenState extends State<SearchPostcodeScreen> {
  DataModel? _dataModel;

  @override
  Widget build(BuildContext context) {
    final user = Hive.box('info');
    int id = user.get('id');

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  if (_dataModel != null) ...[
                    _text("Road Address", _dataModel!.roadAddress),
                    _text("Zonecode", _dataModel!.zonecode),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: GestureDetector(
                onTap: () {
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
                        setState(
                          () {
                            _dataModel = value;
                            // 도로명주소, 우편번호 db 저장.
                            user.put('road_address', _dataModel!.roadAddress);
                            user.put('zone_code', _dataModel!.zonecode);
                            AddressUtils.getAndSaveLatLogfromRoadAddress(roadAddress: _dataModel!.roadAddress);
                          },
                        );
                      };
                    },
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        "쓰레기 버리는 위치 설정하기",
                        style: TextStyle(
                            color: Color.fromRGBO(41, 41, 41, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _text(String title, String expain) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.31,
              child: Center(
                  child: Text(
                title,
                style: const TextStyle(
                    fontSize: 12, color: Color.fromRGBO(195, 195, 195, 1)),
              ))),
          Flexible(
            child: Text(
              expain,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

Future<NLatLng> loadLatLng(String address) async {
  // 좌표로 주소 구하기
  String gpsUrl = 'https://maps.googleapis.com/maps/api/geocode/json?address=' +
      address +
      '&key=AIzaSyAji6aWPEUHHeeqh2B5mLXqXPrM2QE58qU';

  final responseGps = await http.get(Uri.parse(gpsUrl));

  double lat =
      jsonDecode(responseGps.body)['results'][0]['geometry']['location'][0];
  double lng =
      jsonDecode(responseGps.body)['results'][0]['geometry']['location'][1];
  print("위도 확인");
  print(lat);
  return NLatLng(lat, lng);
}
