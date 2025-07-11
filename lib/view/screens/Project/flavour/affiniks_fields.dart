import 'package:overseas_front_end/model/client/client_data_model.dart';
import 'package:overseas_front_end/model/client/client_model.dart';

class AffiniksFields {
  List<Map<String, dynamic>> clientTableList() {
    return [
      {'name': 'Client Id', 'extractor': (ClientModel user) => user.clientId.toString()},
      {
        'name': 'Client Name',
        'extractor': (ClientModel user) => user.name.toString()
      },
      {
        'name': 'Status',
        'extractor': (ClientModel user) => user.status.toString()
      },
      {
        'name': 'Email',
        'extractor': (ClientModel user) => user.email.toString()
      },
      {
        'name': 'Phone',
        'extractor': (ClientModel user) => user.phone.toString()
      },
      {
        'name': 'Alternate No.',
        'extractor': (ClientModel user) => user.alternatePhone.toString()
      },
      {
        'name': 'Address',
        'extractor': (ClientModel user) => user.address.toString()
      }, {
        'name': 'City',
        'extractor': (ClientModel user) => user.city.toString()
      }, {
        'name': 'State',
        'extractor': (ClientModel user) => user.state.toString()
      }, {
        'name': 'Country',
        'extractor': (ClientModel user) => user.country.toString()
      },{
        'name': 'Action',
        'extractor': (ClientModel user) => user
      },
    ];
  }
}
