import 'package:overseas_front_end/model/client/client_data_model.dart';

class AffiniksFields {
  List<Map<String, dynamic>> userTableList() {
    return [
      {'name': 'ID', 'extractor': (ClientDataModel user) => user.id.toString()},
      {
        'name': 'Client Name',
        'extractor': (ClientDataModel user) => user.name.toString()
      },
      {
        'name': 'Phone Number',
        'extractor': (ClientDataModel user) => user.mobile.toString()
      },
      {
        'name': 'Country',
        'extractor': (ClientDataModel user) => user.country.toString()
      },
      {
        'name': 'Email',
        'extractor': (ClientDataModel user) => user.email.toString()
      },
      {
        'name': 'Address',
        'extractor': (ClientDataModel user) => user.address.toString()
      },
    ];
  }
}
