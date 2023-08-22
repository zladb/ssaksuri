import 'package:flutter/material.dart';
import 'package:ssaksuri/const/colors.dart';

class PaidGarbageRequestScreen extends StatelessWidget {
  final String category;
  final String categoryDetail;

  const PaidGarbageRequestScreen({
    required this.category,
    required this.categoryDetail,
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
        child: Text('$categoryDetail 하이하이~'),
      ),
    );
  }
}
