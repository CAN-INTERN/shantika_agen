// To parse this JSON data, do
//
//     final privacyPolicyModel = privacyPolicyModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'privacy_policy_model.g.dart';

PrivacyPolicyModel privacyPolicyModelFromJson(String str) => PrivacyPolicyModel.fromJson(json.decode(str));

String privacyPolicyModelToJson(PrivacyPolicyModel data) => json.encode(data.toJson());

@JsonSerializable()
class PrivacyPolicyModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "privacy_policy")
  PrivacyPolicy privacyPolicy;

  PrivacyPolicyModel({
    required this.code,
    required this.success,
    required this.message,
    required this.privacyPolicy,
  });

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) => _$PrivacyPolicyModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrivacyPolicyModelToJson(this);
}

@JsonSerializable()
class PrivacyPolicy {
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

  PrivacyPolicy({
    required this.id,
    required this.name,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) => _$PrivacyPolicyFromJson(json);

  Map<String, dynamic> toJson() => _$PrivacyPolicyToJson(this);
}
