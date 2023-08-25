import 'package:flutter/material.dart';
import 'package:ssaksuri/const/colors.dart';
import 'package:ssaksuri/main_biz_page.dart';

import '../mainpage.dart';
import '../screen/home_screen.dart';

class MainAppBar extends StatelessWidget {
  final String mainText;
  final String subText;
  final bool isBiz;

  MainAppBar({required this.mainText, required this.subText, required this.isBiz,super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.work),
          tooltip: 'Add new entry',
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => isBiz ? MainPage(): MainBusinessPage()),
                    (route) => false);
          },
        ),
      ],
      backgroundColor: darkColor,
      // pinned: true,
      centerTitle: true,
      expandedHeight: 315,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              margin: EdgeInsets.only(top: kToolbarHeight), // 앱 바의 기본 크기.
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    mainText,
                    style: TextStyle(
                      // fontFamily: PyeongChangPeace,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    subText,
                    style: TextStyle(
                      // fontFamily: PyeongChangPeace,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // Image.asset(
                  //   status.imagePath,
                  //   height: MediaQuery.of(context).size.width / 2,
                  // ),
                  isBiz ? Image.asset('assets/img/wink_bear_cutting.png') : Image.asset('assets/img/cute_bear_cutting.png')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
