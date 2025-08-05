// class ClientDataModel {
//   String? id;
//   String? name;
//   String? mobile;
//   String? organization;
//   String? jobPosition;
//   String? jobField;
//   String? qualification;
//   String? noOfVacancies;
//   String? country;
//   String? email;
//   String? address;
//   String? status;
//   String? campaign;
//   String? counsellor;
//   String? action;
//   String? cvTarget;
//   String? deadline;
//   String? location;
//   String? callStatus;
//   String? date;
//   String? registrationStatus;
//   String? confirmation;
//   String? feedback;
//   String? closedBy;

//   // New fields
//   String? number;
//   String? type;
//   String? timestamp;
//   String? duration;
//   String? leadStatus;
//   String? repeatedEntry;

//   ClientDataModel({
//     this.id,
//     this.name,
//     this.organization,
//     this.jobPosition,
//     this.jobField,
//     this.cvTarget,
//     this.location,
//     this.deadline,
//     this.qualification,
//     this.noOfVacancies,
//     this.country,
//     this.email,
//     this.address,
//     this.mobile,
//     this.status,
//     this.campaign,
//     this.counsellor,
//     this.action,
//     this.callStatus,
//     this.date,
//     this.registrationStatus,
//     this.confirmation,
//     this.feedback,
//     this.closedBy,
//     this.number,
//     this.type,
//     this.timestamp,
//     this.duration,
//     this.leadStatus,
//     this.repeatedEntry, // ✅ Added to constructor
//   });

//   factory ClientDataModel.fromMap(Map<String, dynamic> map) {
//     return ClientDataModel(
//       id: map['id'],
//       name: map['name'],
//       organization: map['organization'],
//       jobPosition: map['job_position'],
//       jobField: map['job_field'],
//       cvTarget: map['cv_target'],
//       location: map['location'],
//       deadline: map['deadline'],
//       qualification: map['qualification'],
//       noOfVacancies: map['no_of_vacancies'],
//       country: map['country'],
//       email: map['email'],
//       address: map['address'],
//       mobile: map['mobile'],
//       status: map['status'],
//       campaign: map['campaign'],
//       counsellor: map['counsellor'],
//       action: map['action'],
//       callStatus: map['callStatus'],
//       date: map['date'],
//       registrationStatus: map['registrationStatus'],
//       confirmation: map['confirmation'],
//       feedback: map['feedback'],
//       closedBy: map['closedBy'],
//       number: map['number'],
//       type: map['type'],
//       timestamp: map['timestamp'],
//       duration: map['duration'],
//       leadStatus: map['leadStatus'],
//       repeatedEntry: map['repeatedEntry'], // ✅ Added to fromMap
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'mobile': mobile,
//       'organization': organization,
//       'job_position': jobPosition,
//       'job_field': jobField,
//       'qualification': qualification,
//       'no_of_vacancies': noOfVacancies,
//       'country': country,
//       'email': email,
//       'address': address,
//       'status': status,
//       'campaign': campaign,
//       'counsellor': counsellor,
//       'action': action,
//       'cv_target': cvTarget,
//       'deadline': deadline,
//       'location': location,
//       'callStatus': callStatus,
//       'date': date,
//       'registrationStatus': registrationStatus,
//       'confirmation': confirmation,
//       'feedback': feedback,
//       'closedBy': closedBy,
//       'number': number,
//       'type': type,
//       'timestamp': timestamp,
//       'duration': duration,
//       'leadStatus': leadStatus,
//       'repeatedEntry': repeatedEntry, // ✅ Added to toMap
//     };
//   }
// }
