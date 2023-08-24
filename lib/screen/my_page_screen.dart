import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ssaksuri/const/colors.dart';

import '../const/basic_text.dart';
import '../model/request_item_model.dart';

class MyPageScreen extends StatelessWidget {
  MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '마이페이지',
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              renderProfile(context),
              SizedBox(height: 10),
              renderMileage(context),
              SizedBox(height: 10),
              Divider(thickness: 1, height: 1, color: lightColor),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' 수거 요청 내역',
                    style: ts,
                    textAlign: TextAlign.left,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.chevron_right,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              renderSeparated(),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderProfile(context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Image.asset(
                'assets/img/ok.png',
                fit: BoxFit.fill,
                height: 55,
                width: 55,
              ), // Text(key['title']),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(style: ts, '안녕하세요,'),
                  Text(style: ts, '유진님!'),
                  SizedBox(height: 3),
                  Text(style: ts.copyWith(fontSize: 13), '우리집 주소 - 대구 서구 비산동'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderMileage(context) {
    final user = Hive.box('info');
    int id = user.get('id');
    final data_box = Hive.box<ItemModel>('$id');
    print('keys : ${data_box.keys.toList()}');
    print('values : ${data_box.values.toList()}');

    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '보유 마일리지',
                    style: ts,
                  ),
                  Text(
                    '16,650 M',
                    style: ts,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.chevron_right,
                size: 40.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderSeparated() {
    return Expanded(
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {},
              leading: FlutterLogo(size: 72.0),
              title: Text('대형 쓰레기'),
              subtitle: Text('수거일: 2023-08-26\n마일리지: 500 적립'),
              trailing: Icon(
                Icons.check,
                size: 30,
                color: Colors.green,
              ),
              isThreeLine: true,

              //dense: true,
            ),
          );
          // return Container(
          //   height: 100,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.all(Radius.circular(15)),
          //   ),
          //   child: Text('$index'),
          // );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }
}
