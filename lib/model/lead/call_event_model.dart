import '../officer/officer_model.dart';

class CallEventModel {
  String? sId;
  String? type;
  String? clientId;
  int? duration;
  String? nextSchedule;
  String? nextScheduleTime;
  String? comment;
  String? callType;
  String? callStatus;
  String? createdAt;
  OfficerModel? officer;

  CallEventModel({
    this.sId,
    this.type,
    this.clientId,
    this.duration,
    this.nextSchedule,
    this.nextScheduleTime,
    this.comment,
    this.callType,
    this.callStatus,
    this.createdAt,
    this.officer,
  });

  CallEventModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    clientId = json['client_id'];
    duration = json['duration'];
    nextSchedule = json['next_schedule'];
    nextScheduleTime =
        json['next_shedule_time']; // Note: keeping the typo from original JSON
    comment = json['comment'];
    callType = json['call_type'];
    callStatus = json['call_status'];
    createdAt = json['created_at'];
    officer =
        json['officer'] != null ? OfficerModel.fromJson(json['officer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['type'] = type;
    data['client_id'] = clientId;
    data['duration'] = duration;
    data['next_schedule'] = nextSchedule;
    data['next_shedule_time'] =
        nextScheduleTime; // Note: keeping the typo from original JSON
    data['comment'] = comment;
    data['call_type'] = callType;
    data['call_status'] = callStatus;
    data['created_at'] = createdAt;
    if (officer != null) {
      data['officer'] = officer!.toJson();
    }
    return data;
  }
}
