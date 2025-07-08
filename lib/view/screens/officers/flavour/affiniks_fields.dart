import '../../../../model/officer/officer_model.dart';

class AffiniksFields {
  List<Map<String, dynamic>> userTableList() {
    return [
      {
        'name': 'ID',
        'extractor': (OfficersModel user) => user.officerId.toString()
      },
      {
        'name': 'Client Name',
        'extractor': (OfficersModel user) => user.name.toString()
      },
      {
        'name': 'Phone Number',
        'extractor': (OfficersModel user) => user.phone.toString()
      },
      {
        'name': 'Officer Phone',
        'extractor': (OfficersModel user) => user.companyPhoneNumber.toString()
      },
      {
        'name': 'Designation',
        'extractor': (OfficersModel user) => user.designation.toString()
      },
      {
        'name': 'Department',
        'extractor': (OfficersModel user) => user.department.toString()
      },
    ];
  }
}
