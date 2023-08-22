
import 'package:flutter/material.dart';

class ItemInfo extends StatelessWidget {
  // 카테고리 이름
  final String itemLabel;
  // 아이콘 위치 (경로)
  final String imgPath;
  // 너비
  final double width;

  const ItemInfo({
    required this.itemLabel,
    required this.imgPath,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.black,
    );
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imgPath, width: 65.0,),
          const SizedBox(height: 12.0,),
          Text(itemLabel??'null', style: ts,),
        ],
      ),
    );
  }
}
