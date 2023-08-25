import 'dart:async';
import 'dart:developer' show log;
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:ssaksuri/const/colors.dart';

import 'kakao_search_screen.dart';

// void main() async {
//   await _initialize();
//   runApp(const NaverMapApp());
// }
//
// Future<void> _initialize() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await NaverMapSdk.instance.initialize(
//       clientId: '<client ID>',
//       onAuthFailed: (ex) => log("********* 네이버맵 인증오류 : $ex *********"));
// }

class NaverMapApp extends StatelessWidget {
  final double lat =0.0;
  final double lng=0.0;
  final NLatLng destination;
  // final int? testId;
  //
  // const NaverMapApp({super.key, this.testId});
  const NaverMapApp({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    //TODO : localDB에있는 lat, lng 꺼내오기
    NLatLng destination = NLatLng(lat, lng);

    final marker = NMarker(id: '1', position: destination, iconTintColor: primaryColor);
    return Scaffold(
      body: NaverMap(
        options: NaverMapViewOptions(
          initialCameraPosition: NCameraPosition(
              target: destination,
              zoom: 17,
              bearing: 0,
              tilt: 0
          ),
          mapType: NMapType.navi,
          activeLayerGroups: [
            NLayerGroup.building,
            NLayerGroup.transit
          ], // default : [NLayerGroup.building]
          minZoom: 10, // default is 0
          maxZoom: 20, // default is 21
          extent: NLatLngBounds(
            southWest: NLatLng(31.43, 122.37),
            northEast: NLatLng(44.35, 132.0),
          ),
        ),
        forceGesture: false,
        onMapReady: (NaverMapController controller) {
          controller.addOverlay(marker);
        },
        onMapTapped: (point, latLng) {},
        onSymbolTapped: (symbol) {},
        onCameraChange: (position, reason) {},
        onCameraIdle: () {},
        onSelectedIndoorChanged: (indoor) {},
      ),
    );
  }
}