// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whatsapp_message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WhatsAppMessageModelAdapter extends TypeAdapter<WhatsAppMessageModel> {
  @override
  final int typeId = 1;

  @override
  WhatsAppMessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WhatsAppMessageModel(
      number: fields[0] as String,
      messageBody: fields[1] as String,
      timeSent: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WhatsAppMessageModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.messageBody)
      ..writeByte(2)
      ..write(obj.timeSent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WhatsAppMessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
