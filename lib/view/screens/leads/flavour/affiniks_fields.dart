import 'package:overseas_front_end/model/lead/lead_model.dart';
import 'package:overseas_front_end/utils/functions/format_date.dart';

class AffiniksFields {
  List<Map<String, dynamic>> userTableList() {
    return [
      {'name': 'ID', 'extractor': (LeadModel user) => user.clientId.toString()},
      {
        'name': 'Display Name',
        'extractor': (LeadModel user) => user.name.toString()
      },
      {
        'name': 'Phone Number',
        'extractor': (LeadModel user) => user.phone.toString()
      },
      {
        'name': 'Status',
        'extractor': (LeadModel user) => user.status.toString()
      },
      {
        'name': 'Campaign ',
        'extractor': (LeadModel user) => user.leadSource.toString()
      },
      {
        'name': 'Officer',
        'extractor': (LeadModel user) => user.officerId.toString()
      },
      {
        'name': 'Created Date',
        'extractor': (LeadModel user) => formatDatetoString(user.createdAt)
      },
      {
        'name': 'Action',
        'extractor': (LeadModel user) => user.email.toString()
      },
    ];
  }

  // List<Map<String, dynamic>> repeatLeadTableList() {
  //   return [
  //     {'name': 'ID', 'extractor': (ClientDataModel user) => user.id.toString()},
  //     {
  //       'name': 'Display Name',
  //       'extractor': (ClientDataModel user) => user.name.toString()
  //     },
  //     {
  //       'name': 'Phone Number',
  //       'extractor': (ClientDataModel user) => user.mobile.toString()
  //     },
  //     {
  //       'name': 'Status',
  //       'extractor': (ClientDataModel user) => user.status.toString()
  //     },
  //     {
  //       'name': 'Repeated Entry ',
  //       'extractor': (ClientDataModel user) => user.repeatedEntry.toString()
  //     },
  //     {
  //       'name': 'Campaign ',
  //       'extractor': (ClientDataModel user) => user.campaign.toString()
  //     },
  //     {
  //       'name': 'Counsellor',
  //       'extractor': (ClientDataModel user) => user.counsellor.toString()
  //     },
  //     {
  //       'name': 'Action',
  //       'extractor': (ClientDataModel user) => user.id.toString()
  //     },
  //   ];
  // }

  // List<Map<String, dynamic>> registerTableList() {
  //   return [
  //     {'name': 'ID', 'extractor': (ClientDataModel user) => user.id.toString()},
  //     {
  //       'name': 'Display Name',
  //       'extractor': (ClientDataModel user) => user.name.toString()
  //     },
  //     {
  //       'name': 'Phone Number',
  //       'extractor': (ClientDataModel user) => user.mobile.toString()
  //     },
  //     {
  //       'name': 'Registration Status',
  //       'extractor': (ClientDataModel user) =>
  //           user.registrationStatus.toString()
  //     },
  //     {
  //       'name': 'Campaign ',
  //       'extractor': (ClientDataModel user) => user.campaign.toString()
  //     },
  //     {
  //       'name': 'Counsellor',
  //       'extractor': (ClientDataModel user) => user.counsellor.toString()
  //     },
  //     {
  //       'name': 'Action',
  //       'extractor': (ClientDataModel user) => user.id.toString()
  //     },
  //   ];
  // }

  // List<Map<String, dynamic>> projectTableList() {
  //   return [
  //     {'name': 'ID', 'extractor': (ClientDataModel user) => user.id.toString()},
  //     {
  //       'name': 'Project Name',
  //       'extractor': (ClientDataModel user) => user.organization.toString()
  //     },
  //     {
  //       'name': 'Job Position',
  //       'extractor': (ClientDataModel user) => user.jobPosition.toString()
  //     },
  //     {
  //       'name': 'Job Field',
  //       'extractor': (ClientDataModel user) => user.jobField.toString()
  //     },
  //     {
  //       'name': 'Qualification ',
  //       'extractor': (ClientDataModel user) => user.qualification.toString()
  //     },
  //     {
  //       'name': 'No of vacancies',
  //       'extractor': (ClientDataModel user) => user.noOfVacancies.toString()
  //     },
  //     {
  //       'name': 'CV Target',
  //       'extractor': (ClientDataModel user) => user.cvTarget.toString()
  //     },
  //     {
  //       'name': 'Deadline',
  //       'extractor': (ClientDataModel user) => user.deadline.toString()
  //     },
  //   ];
  // }

  // List<Map<String, dynamic>> interviewTableList() {
  //   return [
  //     {'name': 'ID', 'extractor': (ClientDataModel user) => user.id.toString()},
  //     {
  //       'name': 'Candidate',
  //       'extractor': (ClientDataModel user) => user.name.toString()
  //     },
  //     {
  //       'name': 'Phone Number',
  //       'extractor': (ClientDataModel user) => user.mobile.toString()
  //     },
  //     {
  //       'name': 'Location',
  //       'extractor': (ClientDataModel user) => user.location.toString()
  //     },
  //     {
  //       'name': 'Schedule ',
  //       'extractor': (ClientDataModel user) => user.date.toString()
  //     },
  //     {
  //       'name': 'Counsellor',
  //       'extractor': (ClientDataModel user) => user.counsellor.toString()
  //     },
  //     {
  //       'name': 'Action',
  //       'extractor': (ClientDataModel user) => user.id.toString()
  //     },
  //   ];
  // }

  // List<Map<String, dynamic>> shortlistTableList() {
  //   return [
  //     {'name': 'ID', 'extractor': (ClientDataModel user) => user.id.toString()},
  //     {
  //       'name': 'Candidate',
  //       'extractor': (ClientDataModel user) => user.name.toString()
  //     },
  //     {
  //       'name': 'Phone Number',
  //       'extractor': (ClientDataModel user) => user.mobile.toString()
  //     },
  //     {
  //       'name': 'Location',
  //       'extractor': (ClientDataModel user) => user.location.toString()
  //     },
  //     {
  //       'name': 'Schedule ',
  //       'extractor': (ClientDataModel user) => user.date.toString()
  //     },
  //     {
  //       'name': 'Counsellor',
  //       'extractor': (ClientDataModel user) => user.counsellor.toString()
  //     },
  //     {
  //       'name': 'Action',
  //       'extractor': (ClientDataModel user) => user.id.toString()
  //     },
  //   ];
  // }

  // List<Map<String, dynamic>> callLogTableList() {
  //   return [
  //     // {'name': 'ID', 'extractor': (ClientDataModel user) => user.id.toString()},
  //     {
  //       'name': 'Name',
  //       'extractor': (ClientDataModel user) => user.name.toString()
  //     },
  //     {
  //       'name': 'Phone Number',
  //       'extractor': (ClientDataModel user) => user.mobile.toString()
  //     },
  //     {
  //       'name': 'Status',
  //       'extractor': (ClientDataModel user) => user.status.toString()
  //     },
  //     {
  //       'name': 'Type ',
  //       'extractor': (ClientDataModel user) => user.type.toString()
  //     },
  //     // {
  //     //   'name': 'Counsellor',
  //     //   'extractor': (ClientDataModel user) => user.counsellor.toString()
  //     // },
  //     // {
  //     //   'name': 'Action',
  //     //   'extractor': (ClientDataModel user) => user.id.toString()
  //     // },
  //   ];
  // }
}
