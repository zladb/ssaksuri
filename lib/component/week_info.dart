import 'package:flutter/material.dart';

import '../const/days.dart';
import 'day_info.dart';

class WeekInfo extends StatelessWidget {
  final bool isBiz;
  const WeekInfo({
    required this.isBiz,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return DayInfo(
          day: days[index],
          day_trash_info_list: day_trash_info[days[index]]!,
          isBiz: isBiz,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 3);
      },
      itemCount: days.length,
    );
  }
}
