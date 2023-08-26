import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ssaksuri/const/colors.dart';
import 'package:ssaksuri/utils/data_utils.dart';

import '../../const/basic_text.dart';
import '../../model/request_item_model.dart';
import '../../utils/adress_utils.dart';



class MyBizPageScreen extends StatelessWidget {
  MyBizPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Hive.box('info');
    int id = user.get('id');
    String nickName = user.get('nickname');
    int mileage = user.get('mileage');
    String road_address = user.get('road_address');
    String zone_code = user.get('zone_code');
    print(road_address);
    print(zone_code);
    // final data_box = Hive.box<ItemModel>('$id');
    // print('keys : ${data_box.keys.toList()}');
    // print('values : ${data_box.values.toList()}');

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
              renderProfile(context,
                  nickname: nickName, road_address: road_address),
              SizedBox(height: 10),
              renderMileage(context, mileage: mileage),
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
              //renderSeparated(id: id),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderProfile(BuildContext context,
      {required String nickname, required String road_address}) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(style: ts, '안녕하세요,'),
                  Text(style: ts, '${nickname} 대표님!'),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: Hive.box('info').listenable(),
                        builder: (BuildContext context, Box<dynamic> value,
                            Widget? child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('우리 업체 주소', style: ts.copyWith(fontSize: 12)),
                              Text('${value.get('road_address')}',
                                  style: ts.copyWith(fontSize: 15)),
                            ],
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.white,
                        iconSize: 25.0,
                        onPressed: () {
                          AddressUtils.searchMyAddress(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderMileage(context, {required mileage}) {
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
              child: ValueListenableBuilder(
                valueListenable: Hive.box('info').listenable(),
                builder:
                    (BuildContext context, Box<dynamic> value, Widget? child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '보유 마일리지',
                        style: ts,
                      ),
                      Text(
                        '${value.get('mileage')} M',
                        style: ts,
                      ),
                    ],
                  );
                },
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

  Widget renderSeparated({required int id}) {
    final data_box = Hive.box<ItemModel>('$id');
    List<ItemModel> reversed_data = data_box.values.toList().reversed.toList();
    return ValueListenableBuilder(
      valueListenable: data_box.listenable(),
      builder: (context, box, widget) {
        if (box.values.isEmpty) {
          return Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Center(
              child: Text(
                '수거 요청 내역이 없습니다.',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else {
          // print('keys : ${data_box.keys.toList()}');
        }
        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {},
                  leading: Image.asset(
                      'assets/img/${DataUtils.getENGfromKOR(word: reversed_data[index].itemLabel)}.png'),
                  title: Text(reversed_data[index].category),
                  subtitle: Text(
                      '수거일: ${DataUtils.getDateFormatted(pickedDate: reversed_data[index].pickUpDate)}\n마일리지: ${reversed_data[index].mileage} 적립'),
                  trailing: Icon(
                    Icons.check,
                    size: 30,
                    color: reversed_data[index].isDone
                        ? Colors.green
                        : Colors.white,
                  ),
                  isThreeLine: true,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: box.values.length,
          ),
        );
      },
    );
  }
}
