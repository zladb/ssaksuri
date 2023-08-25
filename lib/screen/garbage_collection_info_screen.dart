import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ssaksuri/component/week_info.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../component/day_info.dart';
import '../const/basic_text.dart';
import '../const/colors.dart';
import 'kakao_search_screen.dart';
import 'naver_map_screen.dart';

class GarbageCollectionInfoScreen extends StatelessWidget {
  const GarbageCollectionInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Hive.box('info');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '쓰레기 배출 요일 안내',
            style: ts,
          ),
          backgroundColor: darkColor,
          elevation: 0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  print('shopping cart button is clicked');
                }),
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  print('search button is clicked');
                }),
          ],
        ),
        backgroundColor: darkColor,
        body: Container(
          margin: EdgeInsets.only(top: 50),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: Hive.box('info').listenable(),
                  builder: (BuildContext context, Box<dynamic> value,
                      Widget? child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('우리집 주소', style: ts.copyWith(color: Colors.black)),
                        Text('${value.get('road_address')}',
                            style: ts.copyWith(fontSize: 30, color: Colors.black)),
                      ],
                    );
                  },
                ),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: WeekInfo(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/paper.png',
                      height: 70,
                      width: 70,
                    ),
                    Image.asset(
                      'assets/img/glass-bottle.png',
                      height: 70,
                      width: 70,
                    ),
                    Image.asset(
                      'assets/img/plastic.png',
                      height: 70,
                      width: 70,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  height: 280,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text('쓰레기 수거 동선',
                          style:
                              ts.copyWith(fontSize: 25, color: Colors.white)),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width - 55,
                        height: 230,
                        child: NaverMapApp(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text('20:30 수거 예정',
                    style: ts.copyWith(fontSize: 30, color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
