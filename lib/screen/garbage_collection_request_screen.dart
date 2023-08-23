import 'package:flutter/material.dart';

class GarbageCollectionRequestScreen extends StatelessWidget {
  const GarbageCollectionRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 70,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Center(
        child: Text(
          '쓰레기 수거 요청 페이지',
        ),
      ),
    );
  }
}
