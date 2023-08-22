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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          '$category 수거 요청',
        ),
      ),
      body: Center(
        child: Text('$item_label 하이하이~'),
      ),
    );
  }
}
