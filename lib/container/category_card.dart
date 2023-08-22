import 'package:flutter/material.dart';
import 'package:ssaksuri/screen/paid_garbage_request_screen.dart';
import 'package:ssaksuri/utils/data_utils.dart';

import '../component/category_info.dart';
import '../component/main_card.dart';
import '../const/colors.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final bool isTop;

  CategoryCard({
    required this.category,
    required this.isTop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        isTop: isTop, // 맨 위에 녀석만 둥근 테두리
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 카테고리명 (ex) 가구류, 대형 전자제품류, 소형 전자제품류, 생활용품류
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                // 물건 image와 label
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  children: DataUtils.getItemListfromCategory(category: category)
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PaidGarbageRequestScreen(
                                  category: category,
                                  item_label: e,
                                ),
                              ),
                            );
                          },
                          child: CategoryInfo(
                            imgPath: 'assets/img/${DataUtils.getENGfromKOR(word: e)}.png',
                            itemLabel: e,
                            width: constraint.maxWidth / 3,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
