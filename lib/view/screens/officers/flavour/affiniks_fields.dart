import '../../../../model/team_lead/team_lead_model.dart';

class AffiniksFields {
  List<Map<String, dynamic>> userTableList() {
    return [
      {
        'name': 'ID',
        'extractor': (TeamLeadModel user) => user.officerId.toString()
      },
      {
        'name': 'Officer Name',
        'extractor': (TeamLeadModel user) => user.name.toString()
      },
      {
        'name': 'Phone',
        'extractor': (TeamLeadModel user) => user.phone.toString()
      },
      {
        'name': 'Company Phone',
        'extractor': (TeamLeadModel user) => user.companyPhoneNumber.toString()
      },
      {
        'name': 'Designation',
        // 'extractor': (OfficersModel user) => user.designation.toString()
        'extractor': (TeamLeadModel user) =>
            (user.designation?.isNotEmpty ?? false)
                ? (user.designation as List).join('\n')
                : 'NIL' /*user.designation.toString()*/
      },
      // {
      //   // 'name': 'Department',
      //   // 'extractor': (OfficersModel user) => user.department.toString()
      //
      //   'name': 'Designation',
      //   'extractor': (OfficersModel user) =>
      //       (user.designation?.isNotEmpty ?? false)
      //           ? (user.designation as List).join('\n')
      //           : user.designation.toString()
      // },
      {'name': 'Action', 'extractor': (TeamLeadModel user) => user}
    ];
  }
}
