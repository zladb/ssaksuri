import 'package:flutter/material.dart';
import 'package:ssaksuri/const/colors.dart';
import 'package:ssaksuri/screen/biz/biz_company_list_screen.dart';

import '../../component/main_app_bar.dart';
import '../../const/biz/category_biz_list.dart';
import '../../container/category_card.dart';

class HomeBusinessScreen extends StatelessWidget {
  const HomeBusinessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: CustomScrollView(
        slivers: [
          MainAppBar(
            mainText: '대규모 산업 쓰레기!',
            subText: '싹쓰리로 비교하세요.',
            isBiz: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  String category = biz_category_list[index];
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => BizCompanyListScreen(category: category)));
                      },
                      leading: Image.asset('assets/img/truck.png'),
                      title: Text(category),
                      subtitle: Text('일반 업체, 식당, '),
                      isThreeLine: true,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 5,
                  );
                },
                itemCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
