import 'package:flutter/material.dart';
import 'package:ssaksuri/const/colors.dart';

class MainAppBar extends StatelessWidget {
  final String mainText;
  final String subText;

  MainAppBar({required this.mainText, required this.subText, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: darkColor,
      // pinned: true,
      // title: isExpanded ? null : Text('$region ${DataUtils.getTimeFromDateTime(dateTime: dateTime)}'),
      centerTitle: true,
      expandedHeight: 270,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
