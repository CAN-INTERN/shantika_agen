import 'package:json_annotation/json_annotation.dart';

part 'time_classification_model.g.dart';

@JsonSerializable()
class TimeClassificationModel {
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "time")
  List<Time>? time;
  @JsonKey(name: "d")
  String? d;

  TimeClassificationModel({
    this.code,
    this.success,
    this.message,
    this.time,
    this.d,
  });

  factory TimeClassificationModel.fromJson(Map<String, dynamic> json) =>
      _$TimeClassificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeClassificationModelToJson(this);
}

@JsonSerializable()
class Time {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "time_start")
  String? timeStart;
  @JsonKey(name: "time_end")
  String? timeEnd;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  Time({
    this.id,
    this.name,
    this.timeStart,
    this.timeEnd,
    this.createdAt,
    this.updatedAt,
  });

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  Map<String, dynamic> toJson() => _$TimeToJson(this);
}
