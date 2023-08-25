
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ssaksuri/const/colors.dart';
import 'package:ssaksuri/utils/data_utils.dart';

import '../const/basic_text.dart';
import '../model/request_item_model.dart';

class MyPageScreen extends StatelessWidget {
  MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Hive.box('info');
    int id = user.get('id');
    String nickName = user.get('nickname');
    int mileage = user.get('mileage');
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
              renderProfile(context, nickname: nickName),
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
              renderSeparated(id: id),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderProfile(BuildContext context, {required String nickname}) {
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
                  Text(style: ts, '${nickname}님!'),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '보유 마일리지',
                    style: ts,
                  ),
                  Text(
                    '${mileage} M',
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

  Widget renderSeparated({required int id}) {
    final data_box = Hive.box<ItemModel>('$id');
    List<ItemModel> reversed_data = data_box.values.toList().reversed.toList();
    return ValueListenableBuilder(
      valueListenable: data_box.listenable(),
      builder: (context, box, widget){
        if (box.values.isEmpty) {
          return Container(
            height: MediaQuery.of(context).size.height/3,
            child: Center(child: Text('수거 요청 내역이 없습니다.', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white,),),
            ),
          );
        }
        else{
          // print('keys : ${data_box.keys.toList()}');

        }
        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {

              return Card(
                child: ListTile(
                  onTap: () {},
                  leading: Image.asset('assets/img/${DataUtils.getENGfromKOR(word: reversed_data[index].itemLabel)}.png'),
                  title: Text(reversed_data[index].category),
                  subtitle: Text('수거일: ${DataUtils.getDateFormatted(pickedDate: reversed_data[index].pickUpDate)}\n마일리지: ${reversed_data[index].mileage} 적립'),
                  trailing: Icon(
                    Icons.check,
                    size: 30,
                    color: reversed_data[index].isDone ? Colors.green : Colors.white,
                  ),
                  isThreeLine: true,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            }, itemCount: box.values.length,
          ),
        );
      },
    );
  }
}
