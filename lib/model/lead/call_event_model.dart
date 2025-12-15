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
  String? clientStatus;
  String? callType;
  DateTime? createdAt;
  String? comment;
  String? nextSchedule;
  String? nextSheduleTime;
  String? updatedAt;
  String? deadLeadReason;

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
    this.clientStatus,
    this.deadLeadReason,
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
        nextSheduleTime: json["next_shedule_time"].toString(),
        updatedAt: json["updated_at"] == null
            ? null
            : formatDatetoString(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        // "_id": id,
        "type": type,
        "client_id": clientId,
        "officer_id": officerId,
        "officer_phone": officerPhone,
        "phone": phone,
        "duration": duration,
        "call_type": callType,
        "call_status": callStatus,
        // "created_at": createdAt,
        "comment": comment,
        "next_schedule": nextSchedule ?? formatDateToYYYYMMDD(nextSchedule),
        "next_shedule_time": nextSheduleTime,
        // "updated_at": updatedAt,
        "client_status": clientStatus,
        "dead_lead_reason": deadLeadReason,
      };
  Map<String, dynamic> updateToJson() => {
        "comment": comment,
        "next_schedule": nextSchedule ?? formatDateToYYYYMMDD(nextSchedule),
        "next_shedule_time": nextSheduleTime,
      };
}



// class CallEventModel {
//   String? id;
//   String? type;
//   String? clientId;
//   String? officerId;
//   String? officerPhone;
//   String? phone;
//   int? duration;
//   String? callStatus;
//   String? callType;
//   DateTime? createdAt;
//   String? comment;
//   String? nextSchedule;
//   double? nextSheduleTime;
//   String? updatedAt;
//   // New fields for dead lead handling
//   String? clientStatus;
//   String? deadLeadReason;

//   CallEventModel({
//     this.id,
//     this.type,
//     this.clientId,
//     this.officerId,
//     this.officerPhone,
//     this.phone,
//     this.duration,
//     this.callStatus,
//     this.callType,
//     this.createdAt,
//     this.comment,
//     this.nextSchedule,
//     this.nextSheduleTime,
//     this.updatedAt,
//     this.clientStatus,
//     this.deadLeadReason,
//   });

//   factory CallEventModel.fromJson(Map<String, dynamic> json) => CallEventModel(
//         id: json["_id"],
//         type: json["type"],
//         clientId: json["clientId"] ?? json["client_id"],
//         officerId: json["officerId"] ?? json["officer_id"],
//         officerPhone: json["officerPhone"] ?? json["officer_phone"],
//         phone: json["phone"],
//         duration: json["duration"],
//         callStatus: json["callStatus"] ?? json["call_status"],
//         callType: json["callType"] ?? json["call_type"],
//         createdAt: json["createdAt"] == null || json["created_at"] == null
//             ? null
//             : DateTime.tryParse(json["createdAt"] ?? json["created_at"]),
//         comment: json["comment"],
//         nextSchedule: json["nextSchedule"] ?? json["next_schedule"],
//         nextSheduleTime:
//             (json["nextSheduleTime"] ?? json["next_shedule_time"])?.toDouble(),
//         updatedAt: json["updatedAt"] ?? json["updated_at"],
//         clientStatus: json["clientStatus"] ?? json["client_status"],
//         deadLeadReason: json["deadLeadReason"] ?? json["dead_lead_reason"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "type": type,
//         "client_id": clientId,
//         "officer_id": officerId,
//         "officer_phone": officerPhone,
//         "phone": phone,
//         "duration": duration,
//         "call_type": callType,
//         "call_status": callStatus,
//         "created_at": createdAt?.toIso8601String(),
//         "comment": comment,
//         "next_schedule": nextSchedule,
//         "next_shedule_time": nextSheduleTime,
//         "updated_at": updatedAt,
//         "client_status": clientStatus,
//         "dead_lead_reason": deadLeadReason,
//       };

//   // Create API JSON for new call records
//   Map<String, dynamic> toCreateCallJson() {
//     return {
//       'client_id': clientId,
//       'duration': duration ?? 0,
//       if (nextSchedule != null) 'next_schedule': nextSchedule,
//       if (nextSheduleTime != null) 'next_shedule_time': nextSheduleTime,
//       if (clientStatus != null) 'client_status': clientStatus,
//       if (deadLeadReason != null) 'dead_lead_reason': deadLeadReason,
//       if (comment != null && comment!.isNotEmpty) 'comment': comment,
//       if (callType != null) 'call_type': callType,
//       if (callStatus != null) 'call_status': callStatus,
//     };
//   }

//   // Duration formatting function
//   String get formattedDuration {
//     if (duration == null || duration! <= 0) return '00:00';

//     final minutes = (duration! / 60).floor();
//     final seconds = duration! % 60;

//     if (minutes >= 60) {
//       final hours = (minutes / 60).floor();
//       final remainingMinutes = minutes % 60;
//       return '${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//     }

//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }

//   // Time formatting function (24-hour format)
//   String get formattedTime {
//     if (nextSheduleTime == null ||
//         nextSheduleTime!.isNaN ||
//         nextSheduleTime!.isInfinite) {
//       return '00:00';
//     }

//     final totalMinutes = (nextSheduleTime! * 100).toInt();
//     final hours = totalMinutes ~/ 100;
//     final minutes = totalMinutes % 100;

//     return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
//   }

//   // 12-hour format time
//   String get formattedTime12Hour {
//     if (nextSheduleTime == null ||
//         nextSheduleTime!.isNaN ||
//         nextSheduleTime!.isInfinite) {
//       return '12:00 AM';
//     }

//     final totalMinutes = (nextSheduleTime! * 100).toInt();
//     final hours = totalMinutes ~/ 100;
//     final minutes = totalMinutes % 100;

//     final period = hours >= 12 ? 'PM' : 'AM';
//     final hour12 = hours > 12 ? hours - 12 : (hours == 0 ? 12 : hours);

//     return '${hour12.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $period';
//   }

//   // Parse duration string (mm:ss or hh:mm:ss) to seconds
//   static int? parseDuration(String durationString) {
//     if (durationString.isEmpty) return null;

//     final parts = durationString.split(':');
//     if (parts.isEmpty) return null;

//     try {
//       if (parts.length == 2) {
//         // mm:ss format
//         final minutes = int.tryParse(parts[0]) ?? 0;
//         final seconds = int.tryParse(parts[1]) ?? 0;
//         return (minutes * 60) + seconds;
//       } else if (parts.length == 3) {
//         // hh:mm:ss format
//         final hours = int.tryParse(parts[0]) ?? 0;
//         final minutes = int.tryParse(parts[1]) ?? 0;
//         final seconds = int.tryParse(parts[2]) ?? 0;
//         return (hours * 3600) + (minutes * 60) + seconds;
//       }
//     } catch (e) {
//       return null;
//     }

//     return null;
//   }

//   // Parse time string (HH:mm) to double (14.12 format)
//   static double? parseTime(String timeString) {
//     if (timeString.isEmpty) return null;

//     try {
//       final parts = timeString.split(':');
//       if (parts.length != 2) return null;

//       final hours = int.tryParse(parts[0]) ?? 0;
//       final minutes = int.tryParse(parts[1]) ?? 0;

//       if (hours < 0 || hours > 23 || minutes < 0 || minutes > 59) {
//         return null;
//       }

//       // Convert to 14.12 format (hours.minutes as decimal)
//       return hours + (minutes / 100.0);
//     } catch (e) {
//       return null;
//     }
//   }

//   // Check if it's a dead lead
//   bool get isDeadLead => (clientStatus?.toUpperCase() ?? '') == 'DEAD';

//   // Create a copy of the model
//   CallEventModel copyWith({
//     String? id,
//     String? type,
//     String? clientId,
//     String? officerId,
//     String? officerPhone,
//     String? phone,
//     int? duration,
//     String? callStatus,
//     String? callType,
//     DateTime? createdAt,
//     String? comment,
//     String? nextSchedule,
//     double? nextSheduleTime,
//     String? updatedAt,
//     String? clientStatus,
//     String? deadLeadReason,
//   }) {
//     return CallEventModel(
//       id: id ?? this.id,
//       type: type ?? this.type,
//       clientId: clientId ?? this.clientId,
//       officerId: officerId ?? this.officerId,
//       officerPhone: officerPhone ?? this.officerPhone,
//       phone: phone ?? this.phone,
//       duration: duration ?? this.duration,
//       callStatus: callStatus ?? this.callStatus,
//       callType: callType ?? this.callType,
//       createdAt: createdAt ?? this.createdAt,
//       comment: comment ?? this.comment,
//       nextSchedule: nextSchedule ?? this.nextSchedule,
//       nextSheduleTime: nextSheduleTime ?? this.nextSheduleTime,
//       updatedAt: updatedAt ?? this.updatedAt,
//       clientStatus: clientStatus ?? this.clientStatus,
//       deadLeadReason: deadLeadReason ?? this.deadLeadReason,
//     );
//   }
// }