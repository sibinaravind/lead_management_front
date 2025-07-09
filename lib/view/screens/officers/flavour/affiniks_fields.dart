import '../../../../model/officer/officer_model.dart';

class AffiniksFields {
  List<Map<String, dynamic>> userTableList() {
    return [
      {
        'name': 'ID',
        'extractor': (OfficersModel user) => user.officerId.toString()
      },
      {
        'name': 'Officer Name',
        'extractor': (OfficersModel user) => user.name.toString()
      },
      {
        'name': 'Phone',
        'extractor': (OfficersModel user) => user.phone.toString()
      },
      {
        'name': 'Company Phone',
        'extractor': (OfficersModel user) => user.companyPhoneNumber.toString()
      },
      {
        'name': 'Designation',
        // 'extractor': (OfficersModel user) => user.designation.toString()
        'extractor': (OfficersModel user) =>
        (user.designation.isNotEmpty )
            ? (user.designation as List).join('\n')
            : user.designation.toString()
      },
      {
        // 'name': 'Department',
        // 'extractor': (OfficersModel user) => user.department.toString()

        'name': 'Department',
        'extractor': (OfficersModel user) =>
        (user.department.isNotEmpty)
            ? (user.department as List).join('\n')
            : user.department.toString()
      },
      {
        'name':'Action',
        'extractor':(OfficersModel user)=>user
      }
    ];
  }
}
