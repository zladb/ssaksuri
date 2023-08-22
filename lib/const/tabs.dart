import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabInfo {
  final IconData icon;
  final String label;

  TabInfo({
    required this.icon,
    required this.label,
  });
}

final TABS = [
  TabInfo(icon: Icons.other_houses, label: '홈',),
  TabInfo(icon: Icons.local_shipping, label: '배출안내',),
  TabInfo(icon: Icons.flag, label: '수거요청',),
  TabInfo(icon: Icons.account_circle, label: '마이페이지',),
];
