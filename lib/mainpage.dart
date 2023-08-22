import 'package:flutter/material.dart';
import 'package:ssaksuri/screen/garbage_collection_info_screen.dart';
import 'package:ssaksuri/screen/garbage_collection_request_screen.dart';
import 'package:ssaksuri/screen/home_screen.dart';
import 'package:ssaksuri/screen/my_page_screen.dart';

import 'const/tabs.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin  {
  late final TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TabController(length: TABS.length, vsync: this);
    controller.addListener(() { // 컨트롤의 상태가 변경될 때 마다 rebuild
      setState(() {});
    });
  }

  List pages = [
    HomeScreen(),
    GarbageCollectionInfoScreen(),
    GarbageCollectionRequestScreen(),
    MyPageScreen(),
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
        onTap: (index){
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
