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
  @JsonKey(name: "created_at")
  String createdAt;
  @JsonKey(name: "reserve_at")
  String reserveAt;
  @JsonKey(name: "departure_at")
  String departureAt;
  @JsonKey(name: "time_classification_id")
  int? timeClassificationId;
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
  @JsonKey(name: "price_non_feed")
  int? priceNonFeed;
  @JsonKey(name: "price_member_unit")
  int? priceMemberUnit;
  @JsonKey(name: "id_member")
  String? idMember;
  @JsonKey(name: "code_member_stk")
  String? codeMemberStk;
  @JsonKey(name: "price")
  int price;
  @JsonKey(name: "total_price")
  int totalPrice;
  @JsonKey(name: "commision")
  int commision;
  @JsonKey(name: "review")
  dynamic review;
  @JsonKey(name: "note")
  String? note;
  @JsonKey(name: "charge")
  int? charge;
  @JsonKey(name: "agent_discount_chair")
  int? agentDiscountChair;
  @JsonKey(name: "agent_discount_total")
  int? agentDiscountTotal;
  @JsonKey(name: "discount_agent_is_validate")
  bool? discountAgentIsValidate;
  @JsonKey(name: "is_traveloka")
  bool? isTraveloka;
  @JsonKey(name: "is_redbus")
  bool? isRedbus;
  @JsonKey(name: "payment")
  Payment? payment;

  Order({
    required this.id,
    required this.codeOrder,
    required this.nameFleet,
    required this.fleetClass,
    required this.totalPassenger,
    required this.checkpoints,
    required this.createdAt,
    required this.reserveAt,
    required this.departureAt,
    this.timeClassificationId,
    required this.status,
    required this.namePassenger,
    required this.phonePassenger,
    required this.seatPassenger,
    required this.chairs,
    required this.priceMember,
    required this.priceTravel,
    required this.priceFeed,
    this.priceNonFeed,
    this.priceMemberUnit,
    this.idMember,
    this.codeMemberStk,
    required this.price,
    required this.totalPrice,
    required this.commision,
    this.review,
    this.note,
    this.charge,
    this.agentDiscountChair,
    this.agentDiscountTotal,
    this.discountAgentIsValidate,
    this.isTraveloka,
    this.isRedbus,
    this.payment,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class Chair {
  @JsonKey(name: "order_detail_id")
  int? orderDetailId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "chair_name")
  String chairName;
  @JsonKey(name: "food")
  int food;
  @JsonKey(name: "is_member")
  String isMember;
  @JsonKey(name: "is_travel")
  String isTravel;
  @JsonKey(name: "note")
  String? note;
  @JsonKey(name: "is_feed")
  String? isFeed;
  @JsonKey(name: "price_member")
  int? priceMember;
  @JsonKey(name: "price_feed")
  int? priceFeed;
  @JsonKey(name: "price")
  int price;

  Chair({
    this.orderDetailId,
    this.name,
    this.email,
    this.phone,
    required this.chairName,
    required this.food,
    required this.isMember,
    required this.isTravel,
    this.note,
    this.isFeed,
    this.priceMember,
    this.priceFeed,
    required this.price,
  });

  factory Chair.fromJson(Map<String, dynamic> json) => _$ChairFromJson(json);

  Map<String, dynamic> toJson() => _$ChairToJson(this);
}

@JsonSerializable()
class Checkpoints {
  @JsonKey(name: "start")
  Agency start;
  @JsonKey(name: "destination")
  Agency? destination;  // PENTING: Tambah field ini
  @JsonKey(name: "end")
  Agency end;

  Checkpoints({
    required this.start,
    this.destination,  // Optional karena kadang ada kadang ga
    required this.end,
  });

  factory Checkpoints.fromJson(Map<String, dynamic> json) => _$CheckpointsFromJson(json);

  Map<String, dynamic> toJson() => _$CheckpointsToJson(this);
}

@JsonSerializable()
class Agency {
  @JsonKey(name: "agency_id")
  int agencyId;
  @JsonKey(name: "agency_name")
  String agencyName;
  @JsonKey(name: "agency_address")
  String agencyAddress;
  @JsonKey(name: "agency_phone")
  String agencyPhone;
  @JsonKey(name: "agency_lat")
  String? agencyLat;
  @JsonKey(name: "agency_lng")
  String? agencyLng;
  @JsonKey(name: "city_name")
  String cityName;

  Agency({
    required this.agencyId,
    required this.agencyName,
    required this.agencyAddress,
    required this.agencyPhone,
    this.agencyLat,
    this.agencyLng,
    required this.cityName,
  });

  factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyToJson(this);
}

@JsonSerializable()
class Payment {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "payment_type_id")
  int paymentTypeId;
  @JsonKey(name: "order_id")
  int orderId;
  @JsonKey(name: "secret_key")
  String secretKey;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "expired_at")
  String? expiredAt;
  @JsonKey(name: "deleted_at")
  String? deletedAt;
  @JsonKey(name: "created_at")
  String createdAt;
  @JsonKey(name: "updated_at")
  String updatedAt;
  @JsonKey(name: "paid_at")
  String? paidAt;
  @JsonKey(name: "proof")
  String? proof;
  @JsonKey(name: "proof_decline_reason")
  String? proofDeclineReason;
  @JsonKey(name: "proof_url")
  String? proofUrl;

  Payment({
    required this.id,
    required this.paymentTypeId,
    required this.orderId,
    required this.secretKey,
    required this.status,
    this.expiredAt,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.paidAt,
    this.proof,
    this.proofDeclineReason,
    this.proofUrl,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}