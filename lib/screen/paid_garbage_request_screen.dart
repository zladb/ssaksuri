import 'package:flutter/material.dart';
import 'package:ssaksuri/const/colors.dart';

class PaidGarbageRequestScreen extends StatelessWidget {
  final String category;
  final String item_label;

  const PaidGarbageRequestScreen({
    required this.category,
    required this.item_label,
    super.key,
  });

  final ts = const TextStyle(
    color: Colors.black54,
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          '$category 수거 요청',
        ),
      ),
      body: Column(
        children: [
          Text('제품사진', style: ts,),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: lightColor,
          ),
          Row(children: [],),

        ],
      ),
    );
  }
}
