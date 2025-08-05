import 'package:overseas_front_end/model/backup/client/client_data_model.dart';

import '../../../../model/lead/lead_model.dart';

class MaximaFields {
  List<Map<String, dynamic>> userTableList() {
    return [
      {'name': 'ID', 'extractor': (LeadModel user) => user.toString()},
      {'name': 'Display Name', 'extractor': (LeadModel user) => user.sId},
      {
        'name': 'Phone Number',
        'extractor': (LeadModel user) => user.sId.toString()
      },
      {'name': 'AGE', 'extractor': (LeadModel user) => user.sId.toString()},
      {'name': 'NIC', 'extractor': (LeadModel user) => user.sId},
    ];
  }
}
