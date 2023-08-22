import 'package:flutter/material.dart';
import 'package:ssaksuri/const/colors.dart';

import '../component/main_app_bar.dart';
import '../component/main_card.dart';
import '../container/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: CustomScrollView(
        slivers: [
          MainAppBar(
            mainText: '버리기 곤란한 쓰레기!',
            subText: '싹쓰리로 처리하세요.',
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CategoryCard(category: '가구류',),
                SizedBox(
                  height: 150,
                  child: MainCard(
                    backgroundColor: Colors.white,
                    child: Container(),
                    isTop: false,
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: MainCard(
                    backgroundColor: Colors.white,
                    child: Container(),
                    isTop: false,
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: MainCard(
                    backgroundColor: Colors.white,
                    child: Container(),
                    isTop: false,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
