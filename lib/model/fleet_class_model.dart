import 'package:json_annotation/json_annotation.dart';

part 'fleet_class_model.g.dart';

@JsonSerializable()
class FleetClassModel {
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "fleet_classes")
  List<FleetClass>? fleetClasses;

  FleetClassModel({
    this.code,
    this.success,
    this.message,
    this.fleetClasses,
  });

  factory FleetClassModel.fromJson(Map<String, dynamic> json) =>
      _$FleetClassModelFromJson(json);

  Map<String, dynamic> toJson() => _$FleetClassModelToJson(this);
}

@JsonSerializable()
class FleetClass {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "price_food")
  String? priceFood;
  @JsonKey(name: "seat_capacity")
  int? seatCapacity;

  FleetClass({
    this.id,
    this.name,
    this.priceFood,
    this.seatCapacity,
  });

  factory FleetClass.fromJson(Map<String, dynamic> json) =>
      _$FleetClassFromJson(json);

  Map<String, dynamic> toJson() => _$FleetClassToJson(this);
}
