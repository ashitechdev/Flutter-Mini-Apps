import 'package:hive/hive.dart';

part 'whatsapp_message_model.g.dart';

@HiveType(typeId: 1)
class WhatsAppMessageModel {
  @HiveField(0)
  final String number;
  @HiveField(1)
  final String messageBody;
  @HiveField(2)
  final DateTime timeSent;

  WhatsAppMessageModel({this.number, this.messageBody, this.timeSent});
}
