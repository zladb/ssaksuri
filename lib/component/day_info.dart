import 'package:flutter/material.dart';
import 'package:ssaksuri/const/colors.dart';

import '../const/days.dart';

class DayInfo extends StatelessWidget {
  final String day;
  final List<String> day_trash_info_list;
  final bool isBiz;
  const DayInfo({
    required this.day,
    required this.day_trash_info_list,
    required this.isBiz,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle ts = TextStyle(
        fontWeight: FontWeight.w700, fontSize: 10, color: Colors.black);
    return SizedBox(
      height: 48.5,
      width: 48.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: primaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: pickColor(length : day_trash_info_list.length),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: isBiz? [] : day_trash_info_list
                  .map(
                    (e) => Text(e, style: ts, textAlign: TextAlign.center,),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Color pickColor ({required length}){
    if (length >= 3){
      return Colors.green;
    }
    if (length == 2){
      return Colors.lightGreen;
    }
    if (length == 1) {
      return Colors.lightGreenAccent;
    }
    else{
      return Colors.white;
    }
  }
}
