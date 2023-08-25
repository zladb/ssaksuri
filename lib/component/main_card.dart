import 'package:flutter/material.dart';

import '../const/colors.dart';

class MainCard extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;
  final bool isTop;
  final bool isRecycle;

  const MainCard({
    required this.backgroundColor,
    required this.child,
    required this.isTop,
    required this.isRecycle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      shape: isTop ? RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight : Radius.circular(16.0)
        ),
      // side: BorderSide(color: darkColor),
      ): null,
      color: backgroundColor,
      child: child,
      elevation: 0,
    );
  }
}
