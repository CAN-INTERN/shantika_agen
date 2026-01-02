import 'package:json_annotation/json_annotation.dart';

part 'agency_model.g.dart';

@JsonSerializable()
class AgencyModel {
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "agencies")
  List<Agency>? agencies;

  AgencyModel({
    this.code,
    this.success,
    this.message,
    this.agencies,
  });

  factory AgencyModel.fromJson(Map<String, dynamic> json) =>
      _$AgencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyModelToJson(this);
}

@JsonSerializable()
class Agency {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "agency_name")
  String? agencyName;
  @JsonKey(name: "city_name")
  String? cityName;
  @JsonKey(name: "agency_address")
  String? agencyAddress;
  @JsonKey(name: "agency_phone")
  String? agencyPhone;
  @JsonKey(name: "phone")
  List<String>? phone;
  @JsonKey(name: "agency_avatar")
  AgencyAvatar? agencyAvatar;
  @JsonKey(name: "agency_lat")
  String? agencyLat;
  @JsonKey(name: "agency_lng")
  String? agencyLng;
  @JsonKey(name: "morning_time")
  String? morningTime;
  @JsonKey(name: "night_time")
  String? nightTime;
  @JsonKey(name: "agency_departure_times")
  List<AgencyDepartureTime>? agencyDepartureTimes;

  Agency({
    this.id,
    this.agencyName,
    this.cityName,
    this.agencyAddress,
    this.agencyPhone,
    this.phone,
    this.agencyAvatar,
    this.agencyLat,
    this.agencyLng,
    this.morningTime,
    this.nightTime,
    this.agencyDepartureTimes,
  });

  factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyToJson(this);
}

enum AgencyAvatar {
  @JsonValue("/avatar/KbzwboL5uHghGdeJyTyJrEWdWwWfw1DlkJXDCrwl.jpg")
  AVATAR_KBZWBO_L5_U_HGH_GDE_JY_TY_JR_E_WD_WW_WFW1_DLK_JXD_CRWL_JPG,
  @JsonValue("")
  EMPTY
}

final agencyAvatarValues = EnumValues({
  "/avatar/KbzwboL5uHghGdeJyTyJrEWdWwWfw1DlkJXDCrwl.jpg": AgencyAvatar
      .AVATAR_KBZWBO_L5_U_HGH_GDE_JY_TY_JR_E_WD_WW_WFW1_DLK_JXD_CRWL_JPG,
  "": AgencyAvatar.EMPTY
});

@JsonSerializable()
class AgencyDepartureTime {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "agency_id")
  int? agencyId;
  @JsonKey(name: "departure_at")
  String? departureAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "time_classification_id")
  int? timeClassificationId;
  @JsonKey(name: "time_name")
  String? timeName;
  @JsonKey(name: "time_classification")
  TimeClassification? timeClassification;

  AgencyDepartureTime({
    this.id,
    this.agencyId,
    this.departureAt,
    this.createdAt,
    this.updatedAt,
    this.timeClassificationId,
    this.timeName,
    this.timeClassification,
  });

  factory AgencyDepartureTime.fromJson(Map<String, dynamic> json) =>
      _$AgencyDepartureTimeFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyDepartureTimeToJson(this);
}

@JsonSerializable()
class TimeClassification {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  Name? name;
  @JsonKey(name: "time_start")
  String? timeStart;
  @JsonKey(name: "time_end")
  String? timeEnd;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  TimeClassification({
    this.id,
    this.name,
    this.timeStart,
    this.timeEnd,
    this.createdAt,
    this.updatedAt,
  });

  factory TimeClassification.fromJson(Map<String, dynamic> json) =>
      _$TimeClassificationFromJson(json);

  Map<String, dynamic> toJson() => _$TimeClassificationToJson(this);
}

enum Name {
  @JsonValue("Malam")
  MALAM,
  @JsonValue("Pagi")
  PAGI,
  @JsonValue("Sore")
  SORE
}

final nameValues =
    EnumValues({"Malam": Name.MALAM, "Pagi": Name.PAGI, "Sore": Name.SORE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
