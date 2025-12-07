import '../../utils/functions/format_date.dart';

class CallEventModel {
  String? id;
  String? type;
  String? clientId;
  String? officerId;
  String? officerPhone;
  String? phone;
  int? duration;
  String? callStatus;
  String? callType;
  DateTime? createdAt;
  String? comment;
  String? nextSchedule;
  double? nextSheduleTime;
  String? updatedAt;

  CallEventModel({
    this.id,
    this.type,
    this.clientId,
    this.officerId,
    this.officerPhone,
    this.phone,
    this.callStatus,
    this.duration,
    this.callType,
    this.createdAt,
    this.comment,
    this.nextSchedule,
    this.nextSheduleTime,
    this.updatedAt,
  });

  factory CallEventModel.fromJson(Map<String, dynamic> json) => CallEventModel(
        id: json["_id"],
        type: json["type"],
        clientId: json["client_id"],
        officerId: json["officer_id"],
        officerPhone: json["officer_phone"],
        phone: json["phone"],
        duration: json["duration"],
        callStatus: json["call_status"],
        callType: json["call_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        comment: json["comment"],
        nextSchedule: json["next_schedule"] == null
            ? null
            : formatDatetoString(json["next_schedule"]),
        nextSheduleTime: json["next_shedule_time"]?.toDouble(),
        updatedAt: json["updated_at"] == null
            ? null
            : formatDatetoString(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "client_id": clientId,
        "officer_id": officerId,
        "officer_phone": officerPhone,
        "phone": phone,
        "duration": duration,
        "call_type": callType,
        "call_status": callStatus,
        "created_at": createdAt,
        "comment": comment,
        "next_schedule": nextSchedule ?? formatDateToYYYYMMDD(nextSchedule),
        "next_shedule_time": nextSheduleTime,
        "updated_at": updatedAt,
      };
}
