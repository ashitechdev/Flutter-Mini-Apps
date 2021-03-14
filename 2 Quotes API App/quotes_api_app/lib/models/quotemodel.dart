import 'dart:convert';

class QuoteModel {
  QuoteModel({
    this.id,
    this.tags,
    this.content,
    this.author,
    this.length,
  });

  final String id;
  final List<String> tags;
  final String content;
  final String author;
  final int length;

  factory QuoteModel.fromRawJson(String str) =>
      QuoteModel.fromJson(json.decode(str));

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        id: json["_id"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        content: json["content"],
        author: json["author"],
        length: json["length"],
      );
}
