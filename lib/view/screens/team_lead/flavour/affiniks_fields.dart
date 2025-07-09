import 'package:overseas_front_end/model/team_lead/team_lead_model.dart';

import '../../../../model/officer/officer_model.dart';

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
                : user.designation.toString()
      },
      {
        // 'name': 'Department',
        // 'extractor': (OfficersModel user) => user.department.toString()

        'name': 'Department',
        'extractor': (TeamLeadModel user) =>
            (user.department?.isNotEmpty ?? false)
                ? (user.department as List).join('\n')
                : user.department.toString()
      },
    ];
  }
}
