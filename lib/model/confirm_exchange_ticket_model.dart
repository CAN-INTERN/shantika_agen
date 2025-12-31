// To parse this JSON data, do
//
//     final confirmExchangeTicketModel = confirmExchangeTicketModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'confirm_exchange_ticket_model.g.dart';

ConfirmExchangeTicketModel confirmExchangeTicketModelFromJson(String str) =>
    ConfirmExchangeTicketModel.fromJson(json.decode(str));

String confirmExchangeTicketModelToJson(ConfirmExchangeTicketModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ConfirmExchangeTicketModel {
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "order")
  Order? order;

  ConfirmExchangeTicketModel({
    this.code,
    this.success,
    this.message,
    this.order,
  });

  factory ConfirmExchangeTicketModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmExchangeTicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmExchangeTicketModelToJson(this);
}

@JsonSerializable()
class Order {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "code_order")
  String? codeOrder;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "route_id")
  int? routeId;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "expired_at")
  DateTime? expiredAt;
  @JsonKey(name: "reserve_at")
  DateTime? reserveAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "order_detail")
  List<OrderDetail>? orderDetail;
  @JsonKey(name: "payment")
  List<dynamic>? payment;

  Order({
    this.id,
    this.codeOrder,
    this.userId,
    this.routeId,
    this.status,
    this.price,
    this.expiredAt,
    this.reserveAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.orderDetail,
    this.payment,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderDetail {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "order_id")
  int? orderId;
  @JsonKey(name: "layout_chair_id")
  int? layoutChairId;
  @JsonKey(name: "code_ticket")
  String? codeTicket;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "is_feed")
  String? isFeed;
  @JsonKey(name: "is_travel")
  String? isTravel;
  @JsonKey(name: "is_member")
  String? isMember;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  OrderDetail({
    this.id,
    this.orderId,
    this.layoutChairId,
    this.codeTicket,
    this.name,
    this.phone,
    this.email,
    this.isFeed,
    this.isTravel,
    this.isMember,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}