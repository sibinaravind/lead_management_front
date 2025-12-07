import '../../../../model/lead/lead_model.dart';

class partner1Fields {
  List<Map<String, dynamic>> userTableList() {
    return [
      {'name': 'ID', 'extractor': (LeadModel user) => user..toString()},
      {'name': 'Display Name', 'extractor': (LeadModel user) => user.clientId},
      {
        'name': 'Phone Number',
        'extractor': (LeadModel user) => user.clientId.toString()
      },
      {
        'name': 'AGE',
        'extractor': (LeadModel user) => user.clientId.toString()
      },
      {'name': 'NIC', 'extractor': (LeadModel user) => user.clientId},
    ];
  }
}
