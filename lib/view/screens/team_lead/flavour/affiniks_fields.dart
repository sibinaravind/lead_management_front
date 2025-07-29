import '../../../../model/officer/officer_model.dart';

class AffiniksFields {
  List<Map<String, dynamic>> userTableList() {
    return [
      {
        'name': 'ID',
        'extractor': (OfficerModel user) => user.officerId.toString()
      },
      {
        'name': 'OfficerModel Name',
        'extractor': (OfficerModel user) => user.name.toString()
      },
      {
        'name': 'Phone',
        'extractor': (OfficerModel user) => user.phone.toString()
      },
      {
        'name': 'Company Phone',
        'extractor': (OfficerModel user) => user.companyPhoneNumber.toString()
      },
      {
        'name': 'Designation',
        // 'extractor': (OfficersModel user) => user.designation.toString()
        'extractor': (OfficerModel user) =>
            (user.designation?.isNotEmpty ?? false)
                ? (user.designation as List).join('\n')
                : user.designation.toString()
      },
      // {
      //   // 'name': 'Department',
      //   // 'extractor': (OfficersModel user) => user.department.toString()

      //   'name': 'Department',
      //   'extractor': (OfficerModel user) =>
      //       (user.department?.isNotEmpty ?? false)
      //           ? (user.department as List).join('\n')
      //           : user.department.toString()
      // },
    ];
  }
}
