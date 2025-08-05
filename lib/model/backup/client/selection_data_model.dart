// class ClientSelectionDataModel {
//   String? id;
//   String? nameProject;
//   String? total;
//   String? underVerification;
//   String? hrd;
//   String? dataFlow;
//   String? exam;
//   String? qvp;

//   ClientSelectionDataModel({
//     this.id,
//     this.nameProject,
//     this.total,
//     this.underVerification,
//     this.hrd,
//     this.dataFlow,
//     this.exam,
//     this.qvp,
//   });

//   factory ClientSelectionDataModel.fromMap(Map<String, dynamic> map) {
//     return ClientSelectionDataModel(
//       id: map['id'],
//       nameProject: map['nameProject'],
//       total: map['total'],
//       underVerification: map['underVerification'],
//       hrd: map['hrd'],
//       dataFlow: map['dataFlow'],
//       exam: map['exam'],
//       qvp: map['qvp'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'nameProject': nameProject,
//       'total': total,
//       'underVerification': underVerification,
//       'hrd': hrd,
//       'dataFlow': dataFlow,
//       'exam': exam,
//       'qvp': qvp,
//     };
//   }
// }
