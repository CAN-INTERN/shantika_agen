import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@JsonSerializable()
class UserModel {
  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "success")
  bool success;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "user")
  User? user;

  @JsonKey(name: "token")
  String? token;

  UserModel({
    required this.code,
    required this.success,
    required this.message,
    this.user,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "phone")
  String phone;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "avatar")
  dynamic avatar;
  @JsonKey(name: "birth")
  DateTime? birth;
  @JsonKey(name: "birth_place")
  String? birthPlace;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "uuid")
  String uuid;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "is_active")
  bool isActive;
  @JsonKey(name: "avatar_url")
  String? avatarUrl;
  @JsonKey(name: "name_agent")
  String? nameAgent;
  @JsonKey(name: "agencies")
  Agencies? agencies;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.avatar,
    this.birth,
    this.birthPlace,
    this.address,
    this.gender,
    required this.uuid,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    required this.isActive,
    this.avatarUrl,
    this.nameAgent,
    this.agencies,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Agencies {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "user_id")
  int userId;
  @JsonKey(name: "agency_id")
  int agencyId;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "agent")
  Agent agent;

  Agencies({
    required this.id,
    required this.userId,
    required this.agencyId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    required this.agent,
  });

  factory Agencies.fromJson(Map<String, dynamic> json) => _$AgenciesFromJson(json);

  Map<String, dynamic> toJson() => _$AgenciesToJson(this);
}

@JsonSerializable()
class Agent {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "city_id")
  int cityId;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "lat")
  String? lat;
  @JsonKey(name: "lng")
  String? lng;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "avatar")
  dynamic avatar;
  @JsonKey(name: "is_active")
  bool isActive;
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "is_agent")
  bool isAgent;
  @JsonKey(name: "is_route")
  bool isRoute;
  @JsonKey(name: "is_agent_route")
  bool isAgentRoute;
  @JsonKey(name: "sectoral_id")
  int? sectoralId;
  @JsonKey(name: "is_redbus_pickup")
  bool isRedbusPickup;
  @JsonKey(name: "duration")
  dynamic duration;
  @JsonKey(name: "avatar_url")
  String? avatarUrl;
  @JsonKey(name: "city_name")
  String? cityName;
  @JsonKey(name: "area_name")
  String? areaName;
  @JsonKey(name: "morning_time")
  String? morningTime;
  @JsonKey(name: "night_time")
  String? nightTime;
  @JsonKey(name: "time_group")
  List<String>? timeGroup;
  @JsonKey(name: "price_agency")
  num? priceAgency;
  @JsonKey(name: "price_route")
  num? priceRoute;
  @JsonKey(name: "agency_departure_time_by_time_classification")
  dynamic agencyDepartureTimeByTimeClassification;

  Agent({
    required this.id,
    required this.name,
    required this.cityId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.lat,
    this.lng,
    this.address,
    this.avatar,
    required this.isActive,
    this.code,
    this.phone,
    required this.isAgent,
    required this.isRoute,
    required this.isAgentRoute,
    this.sectoralId,
    required this.isRedbusPickup,
    this.duration,
    this.avatarUrl,
    this.cityName,
    this.areaName,
    this.morningTime,
    this.nightTime,
    this.timeGroup,
    this.priceAgency,
    this.priceRoute,
    this.agencyDepartureTimeByTimeClassification,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => _$AgentFromJson(json);

  Map<String, dynamic> toJson() => _$AgentToJson(this);
}