import 'package:flutter/material.dart';

import '../component/request_bottom_sheet.dart';
import '../const/basic_text.dart';
import '../const/colors.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: primaryColor,
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  height: MediaQuery.of(context).size.height/3.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
