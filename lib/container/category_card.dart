import 'package:flutter/material.dart';
import 'package:ssaksuri/screen/paid_garbage_request_screen.dart';
import 'package:ssaksuri/utils/data_utils.dart';

import '../component/category_info.dart';
import '../component/main_card.dart';
import '../const/colors.dart';
import '../const/item_category_list.dart';

class CategoryCard extends StatelessWidget {
  final String category;

  CategoryCard({
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        isTop: true, // 맨 위에 녀석만 둥근 테두리
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  children: item_category_gagu
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PaidGarbageRequestScreen(
                                  category: category,
                                  categoryDetail: e,
                                ),
                              ),
                            );
                          },
                          child: CategoryInfo(
                            imgPath: 'assets/img/${DataUtils.getENGfromKOR(word: e)}.png',
                            category: e,
                            width: constraint.maxWidth / 3,
                          ),
                        ),
                      )
                      .toList(),

                  // List.generate(
                  //   6,
                  //   (index) => CategoryInfo(
                  //     imgPath: 'assets/img/ok.png',
                  //     category: '$category $index',
                  //     width: constraint.maxWidth / 3,
                  //   ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
