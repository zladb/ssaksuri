// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemModelAdapter extends TypeAdapter<ItemModel> {
  @override
  final int typeId = 1;

  @override
  ItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemModel(
      category: fields[0] as String,
      itemLabel: fields[1] as String,
      title: fields[2] as String,
      pickUpAddress: fields[3] as String,
      pickUpDate: fields[4] as DateTime,
      mileage: fields[5] as int,
      isDone: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ItemModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.itemLabel)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.pickUpAddress)
      ..writeByte(4)
      ..write(obj.pickUpDate)
      ..writeByte(5)
      ..write(obj.mileage)
      ..writeByte(6)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
