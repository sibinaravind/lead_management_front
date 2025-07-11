import 'package:overseas_front_end/model/client/client_data_model.dart';

import 'package:overseas_front_end/model/client/client_data_model.dart';

class partner1Fields {
  List<Map<String, dynamic>> userTableList() {
    return [
      {'name': 'ID', 'extractor': (ClientDataModel user) => user..toString()},
      {'name': 'Display Name', 'extractor': (ClientDataModel user) => user.id},
      {
        'name': 'Phone Number',
        'extractor': (ClientDataModel user) => user.id.toString()
      },
      {
        'name': 'AGE',
        'extractor': (ClientDataModel user) => user.id.toString()
      },
      {'name': 'NIC', 'extractor': (ClientDataModel user) => user.id},
    ];
  }
}
