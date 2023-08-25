import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ssaksuri/component/week_info.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../const/basic_text.dart';
import '../../const/colors.dart';
import '../naver/naver_map_screen.dart';


class BizCompanyListScreen extends StatelessWidget {
  final String category;
  const BizCompanyListScreen({
    required this.category,
    super.key});

  @override
  Widget build(BuildContext context) {

    final user = Hive.box('info');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '수거 가능 업체 리스트',
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
          margin: EdgeInsets.only(top: 20),
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
                Text('${category}', style: ts.copyWith(fontSize: 30, color: Colors.black)),
                SizedBox(height: 10),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
