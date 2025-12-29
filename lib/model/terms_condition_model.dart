// To parse this JSON data, do
//
//     final termsConditionModel = termsConditionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'terms_condition_model.g.dart';

TermsConditionModel termsConditionModelFromJson(String str) => TermsConditionModel.fromJson(json.decode(str));

String termsConditionModelToJson(TermsConditionModel data) => json.encode(data.toJson());

@JsonSerializable()
class TermsConditionModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "term_and_condition")
  TermAndCondition termAndCondition;

  TermsConditionModel({
    required this.code,
    required this.success,
    required this.message,
    required this.termAndCondition,
  });

  factory TermsConditionModel.fromJson(Map<String, dynamic> json) => _$TermsConditionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TermsConditionModelToJson(this);
}

@JsonSerializable()
class TermAndCondition {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;

  TermAndCondition({
    required this.id,
    required this.name,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TermAndCondition.fromJson(Map<String, dynamic> json) => _$TermAndConditionFromJson(json);

  Map<String, dynamic> toJson() => _$TermAndConditionToJson(this);
}
