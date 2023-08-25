// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:ssaksuri/utils/adress_utils.dart';
//
// import '../const/colors.dart';
// import '../mainpage.dart';
//
// class InitializeAddress extends StatelessWidget {
//   const InitializeAddress({super.key});
//
//   Future<Box> openHive() async {
//     return await Hive.openBox('info');
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     Box fuckk;
//     print('여기');
//     openHive().then((value) => fuckk = value);
//     print('${fuckk.values}');
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: darkColor,
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Image.asset(
//                 'assets/img/cute_bear.png',
//                 height: 150,
//                 width: 150,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   AddressUtils.searchMyAddress(context);
//                   AddressUtils.getAndSaveLatLogfromRoadAddress(
//                       roadAddress: user.get('road_address'));
//                 },
//                 child: Text('내 주소 설정하기!'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (user.get('road_address') == null) {
//                     showDialog<void>(
//                       //다이얼로그 위젯 소환
//                       context: context,
//                       barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text('알림'),
//                           content: SingleChildScrollView(
//                             child: ListBody(
//                               //List Body를 기준으로 Text 설정
//                               children: <Widget>[
//                                 Text('주소를 먼저 설정해주세요.'),
//                               ],
//                             ),
//                           ),
//                           actions: [
//                             TextButton(
//                               child: Text('확인'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   } else {
//                     Navigator.of(context).pushAndRemoveUntil(
//                         MaterialPageRoute(
//                             builder: (context) => const MainPage()),
//                         (route) => false);
//                   }
//                 },
//                 child: Text('홈으로 가기!'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
