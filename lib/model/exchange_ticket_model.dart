// To parse this JSON data, do
//
//     final exchangeTicketModel = exchangeTicketModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'exchange_ticket_model.g.dart';

ExchangeTicketModel exchangeTicketModelFromJson(String str) => ExchangeTicketModel.fromJson(json.decode(str));

String exchangeTicketModelToJson(ExchangeTicketModel data) => json.encode(data.toJson());

@JsonSerializable()
class ExchangeTicketModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "order")
  Order order;

  ExchangeTicketModel({
    required this.code,
    required this.success,
    required this.message,
    required this.order,
  });

  factory ExchangeTicketModel.fromJson(Map<String, dynamic> json) => _$ExchangeTicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeTicketModelToJson(this);
}

@JsonSerializable()
class Order {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "code_order")
  String codeOrder;
  @JsonKey(name: "name_fleet")
  String nameFleet;
  @JsonKey(name: "fleet_class")
  String fleetClass;
  @JsonKey(name: "total_passenger")
  int totalPassenger;
  @JsonKey(name: "checkpoints")
  Checkpoints checkpoints;
  @JsonKey(name: "checkpoint_destination")
  dynamic checkpointDestination;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "reserve_at")
  DateTime reserveAt;
  @JsonKey(name: "departure_at")
  String departureAt;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "name_passenger")
  String namePassenger;
  @JsonKey(name: "phone_passenger")
  String phonePassenger;
  @JsonKey(name: "seat_passenger")
  List<String> seatPassenger;
  @JsonKey(name: "chairs")
  List<Chair> chairs;
  @JsonKey(name: "price_member")
  int priceMember;
  @JsonKey(name: "price_travel")
  int priceTravel;
  @JsonKey(name: "price_feed")
  int priceFeed;
  @JsonKey(name: "id_member")
  String idMember;
  @JsonKey(name: "price")
  int price;
  @JsonKey(name: "total_price")
  int totalPrice;
  @JsonKey(name: "commision")
  int commision;
  @JsonKey(name: "review")
  dynamic review;

  Order({
    required this.id,
    required this.codeOrder,
    required this.nameFleet,
    required this.fleetClass,
    required this.totalPassenger,
    required this.checkpoints,
    required this.checkpointDestination,
    required this.createdAt,
    required this.reserveAt,
    required this.departureAt,
    required this.status,
    required this.namePassenger,
    required this.phonePassenger,
    required this.seatPassenger,
    required this.chairs,
    required this.priceMember,
    required this.priceTravel,
    required this.priceFeed,
    required this.idMember,
    required this.price,
    required this.totalPrice,
    required this.commision,
    required this.review,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class Chair {
  @JsonKey(name: "chair_name")
  String chairName;
  @JsonKey(name: "food")
  int food;
  @JsonKey(name: "is_member")
  String isMember;
  @JsonKey(name: "is_travel")
  String isTravel;
  @JsonKey(name: "price")
  int price;

  Chair({
    required this.chairName,
    required this.food,
    required this.isMember,
    required this.isTravel,
    required this.price,
  });

  factory Chair.fromJson(Map<String, dynamic> json) => _$ChairFromJson(json);

  Map<String, dynamic> toJson() => _$ChairToJson(this);
}

@JsonSerializable()
class Checkpoints {
  @JsonKey(name: "start")
  End start;
  @JsonKey(name: "end")
  End end;

  Checkpoints({
    required this.start,
    required this.end,
  });

  factory Checkpoints.fromJson(Map<String, dynamic> json) => _$CheckpointsFromJson(json);

  Map<String, dynamic> toJson() => _$CheckpointsToJson(this);
}

@JsonSerializable()
class End {
  @JsonKey(name: "agency_id")
  int agencyId;
  @JsonKey(name: "agency_name")
  String agencyName;
  @JsonKey(name: "agency_address")
  String agencyAddress;
  @JsonKey(name: "agency_phone")
  String agencyPhone;
  @JsonKey(name: "agency_lat")
  dynamic agencyLat;
  @JsonKey(name: "agency_lng")
  dynamic agencyLng;
  @JsonKey(name: "city_name")
  String cityName;
  @JsonKey(name: "arrived_at")
  dynamic arrivedAt;

  End({
    required this.agencyId,
    required this.agencyName,
    required this.agencyAddress,
    required this.agencyPhone,
    required this.agencyLat,
    required this.agencyLng,
    required this.cityName,
    required this.arrivedAt,
  });

  factory End.fromJson(Map<String, dynamic> json) => _$EndFromJson(json);

  Map<String, dynamic> toJson() => _$EndToJson(this);
}
