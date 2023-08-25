import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ssaksuri/screen/biz/garbage_collection_info_biz_screen.dart';
import 'package:ssaksuri/screen/biz/garbage_collection_request_biz_screen.dart';
import 'package:ssaksuri/screen/biz/home_biz_screen.dart';
import 'package:ssaksuri/screen/biz/my_biz_page_screen.dart';
import 'package:ssaksuri/screen/garbage_collection_info_screen.dart';
import 'package:ssaksuri/screen/garbage_collection_request_screen.dart';
import 'package:ssaksuri/screen/home_screen.dart';
import 'package:ssaksuri/screen/my_page_screen.dart';

import 'const/tabs.dart';

class MainBusinessPage extends StatefulWidget {
  // final User? user;
  const MainBusinessPage({super.key});

  @override
  State<MainBusinessPage> createState() => _MainBusinessPageState();
}

class _MainBusinessPageState extends State<MainBusinessPage> with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TabController(length: TABS.length, vsync: this);
    controller.addListener(() {
      // 컨트롤의 상태가 변경될 때 마다 rebuild
      setState(() {});
    });
  }

  List pages = [
    HomeBusinessScreen(),
    GarbageCollectionInfoBizScreen(),
    GarbageCollectionRequestBizScreen(),
    MyBizPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[controller.index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: controller.index,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          controller.animateTo(index);
        },
        items: TABS
            .map(
              (e) => BottomNavigationBarItem(
            icon: Icon(
              e.icon,
            ),
            label: e.label,
          ),
        )
            .toList(),
      ),
    );
  }
}
