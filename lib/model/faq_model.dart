// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'faq_model.g.dart';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

@JsonSerializable()
class FaqModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "faqs")
  List<Faq> faqs;

  FaqModel({
    required this.code,
    required this.success,
    required this.message,
    required this.faqs,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => _$FaqModelFromJson(json);

  Map<String, dynamic> toJson() => _$FaqModelToJson(this);
}

@JsonSerializable()
class Faq {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "question")
  String question;
  @JsonKey(name: "answer")
  String answer;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;

  Faq({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => _$FaqFromJson(json);

  Map<String, dynamic> toJson() => _$FaqToJson(this);
}
