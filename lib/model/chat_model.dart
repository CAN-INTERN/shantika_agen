// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'chat_model.g.dart';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

@JsonSerializable()
class ChatModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "data")
  List<Datum> data;

  ChatModel({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "value")
  String value;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "icon")
  String icon;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;
  @JsonKey(name: "link")
  String link;

  Datum({
    required this.id,
    required this.name,
    required this.value,
    required this.type,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
    required this.link,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
