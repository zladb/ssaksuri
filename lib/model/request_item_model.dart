import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'request_item_model.g.dart';

@HiveType(typeId: 1) // typeId는 절대 중복되면 안된다.
class ItemModel {
  @HiveField(0)
  final String category; // 카테고리

  @HiveField(1)
  final String itemLabel; // 아이템라벨

  @HiveField(2)
  final String title; // 제품명

  @HiveField(3)
  final String pickUpAddress; // 수거 주소

  @HiveField(4)
  final DateTime pickUpDate; // 수거 날짜

  @HiveField(5)
  final int mileage; // 마일리지

  @HiveField(6)
  final bool isDone; // 처리 상태

  ItemModel({
    required this.category,
    required this.itemLabel,
    required this.title,
    required this.pickUpAddress,
    required this.pickUpDate,
    required this.mileage,
    required this.isDone,
  });

  @override
  String toString() {
    // TODO: implement toString
    return '''
    value-
    category : ${category}
    item_label : ${itemLabel}
    title : ${title}
    pickUpAddress : ${pickUpAddress}
    pickUpDate : ${pickUpDate}
    mileage : ${mileage}
    isDone : ${isDone}\n''';
  }
}
