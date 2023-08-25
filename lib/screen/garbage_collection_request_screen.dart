import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ssaksuri/container/category_card.dart';

import '../component/request_bottom_sheet.dart';
import '../const/basic_text.dart';
import '../const/colors.dart';
import 'naver_map_screen.dart';

class GarbageCollectionRequestScreen extends StatelessWidget {
  const GarbageCollectionRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '우리집 쓰레기 수거 요청',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '일반 쓰레기',
                      style: ts.copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          backgroundColor: Colors.transparent,
                          context: context,
                          isScrollControlled:
                              true, // bottom sheet의 높이를 화면의 반보다 더 높에 하고 싶을 때 설정.
                          builder: (_) {
                            // return RequestBottomSheet();
                            return RequestBottomSheet(
                              category: '이게머지',
                              item_label: '일반 쓰레기!',
                            );
                          },
                        );
                      },
                      child: renderGeneralRequestBtn(context),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // 맵이 들어갈 컨테이너
                    Text(
                      '쓰레기 수거 위치',
                      style: ts.copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      child: NaverMapApp(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      CategoryCard(
                        category: '재활용쓰레기',
                        isTop: true,
                        isRecycle: true,
                      ),
                      Text(
                        '모아서 배출하고 마일리지를 적립 받으세요!',
                        style: ts.copyWith(
                          color: primaryColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container renderGeneralRequestBtn(context) {
    return Container(
      height: 110,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(
          width: 1,
          color: primaryColor,
        ),
      ),
      child: Icon(Icons.add, color: primaryColor,size: 40,),
    );
  }
}
