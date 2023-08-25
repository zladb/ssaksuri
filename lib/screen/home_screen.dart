import 'package:flutter/material.dart';
import 'package:ssaksuri/const/colors.dart';

import '../component/main_app_bar.dart';
import '../container/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: CustomScrollView(
        slivers: [
          MainAppBar(
            mainText: '버리기 곤란한 쓰레기!',
            subText: '싹쓰리로 처리하세요.',
            isBiz: false,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CategoryCard(
                  category: '가구류',
                  isTop: true,
                  isRecycle: false,
                ),
                CategoryCard(
                  category: '대형 전자제품류',
                  isTop: false,
                  isRecycle: false,
                ),
                CategoryCard(
                  category: '소형 전자제품류',
                  isTop: false,
                  isRecycle: false,
                ),
                CategoryCard(
                  category: '생활용품류',
                  isTop: false,
                  isRecycle: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
