// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'about_us_model.g.dart';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

@JsonSerializable()
class AboutUsModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "about")
  About about;

  AboutUsModel({
    required this.code,
    required this.success,
    required this.message,
    required this.about,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => _$AboutUsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AboutUsModelToJson(this);
}

@JsonSerializable()
class About {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "image")
  String image;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "address")
  String address;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;

  About({
    required this.id,
    required this.image,
    required this.description,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory About.fromJson(Map<String, dynamic> json) => _$AboutFromJson(json);

  Map<String, dynamic> toJson() => _$AboutToJson(this);
}
