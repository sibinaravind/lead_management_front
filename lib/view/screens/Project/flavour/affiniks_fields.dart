import 'package:intl/intl.dart';
import 'package:overseas_front_end/model/client/client_data_model.dart';
import 'package:overseas_front_end/model/client/client_model.dart';
import 'package:overseas_front_end/model/project/project_model.dart';
import 'package:overseas_front_end/model/project/vacancy_model.dart';

class AffiniksFields {
  List<Map<String, dynamic>> clientTableList() {
    return [
      // {'name': 'ID', 'extractor': (ClientModel user) => user..toString()},
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
      // {
      //   'name': 'Country',
      //   'extractor': (ClientModel user) => user.country.toString()
      // },
      {
        'name': 'Alternate Phone',
        'extractor': (ClientModel user) => user.alternatePhone.toString()
      },
      {
        'name': 'Address',
        'extractor': (ClientModel user) => user.address.toString()
      },
      {'name': 'City', 'extractor': (ClientModel user) => user.city.toString()},
      {
        'name': 'State',
        'extractor': (ClientModel user) => user.state.toString()
      },
      {
        'name': 'Country',
        'extractor': (ClientModel user) => user.country.toString()
      },
      {'name': 'Action', 'extractor': (ClientModel user) => user},
    ];
  }

  List<Map<String, dynamic>> projectTableList() {
    return [
      {
        'name': 'Project Name',
        'extractor': (ProjectModel user) => user.projectName.toString()
      },
      {
        'name': 'Status',
        'extractor': (ProjectModel user) => user.status.toString()
      },
      {
        'name': 'Organization Name',
        'extractor': (ProjectModel user) => user.organizationName.toString()
      },
      {
        'name': 'Organization Type',
        'extractor': (ProjectModel user) => user.organizationType.toString()
      },
      {
        'name': 'Created At',
        'extractor': (ProjectModel user) {
          try {
            final date = DateTime.parse(user.createdAt ?? '');
            return DateFormat('dd-MM-yyyy').format(date);
          } catch (e) {
            return '';
          }
        }
      },
      {
        'name': 'City',
        'extractor': (ProjectModel user) => user.city.toString()
      },
      {
        'name': 'Country',
        'extractor': (ProjectModel user) => user.country.toString()
      },
      {
        'name': 'Action',
        'extractor': (ProjectModel user) => user,
      },
    ];
  }

  List<Map<String, dynamic>> vacancyTableList() {
    return [
      {
        'name': 'Job Title',
        'extractor': (VacancyModel user) => user.jobTitle ?? ''
      },
      {
        'name': 'Experience',
        'extractor': (VacancyModel user) => user.experience ?? ''
      },
      {
        'name': 'Description',
        'extractor': (VacancyModel user) => user.description ?? ''
      },
      {
        'name': 'Qualifications',
        'extractor': (VacancyModel user) =>
        user.qualifications?.join(", ") ?? ''
      },
      {
        'name': 'City',
        'extractor': (VacancyModel user) => user.city ?? ''
      },
      {
        'name': 'Country',
        'extractor': (VacancyModel user) => user.country ?? ''
      },
      {'name': 'Action', 'extractor': (VacancyModel user) => user},


    ];
  }

  // List<Map<String, dynamic>> vacancyTableList() {
  //   return [
  //     // {'name': 'ID', 'extractor': (VacancyModel user) => user.sId.toString()},
  //     {
  //       'name': 'Job Title',
  //       'extractor': (VacancyModel user) => user.jobTitle.toString()
  //     },
  //     {
  //       'name': 'Experience',
  //       'extractor': (VacancyModel user) => user.experience.toString()
  //     },
  //     // {'name': 'Email', 'extractor': (ProjectModel user) => user.email.toString()},
  //     // {
  //     //   'name': 'Country',
  //     //   'extractor': (ClientModel user) => user.country.toString()
  //     // },
  //     {
  //       'name': 'Description',
  //       'extractor': (VacancyModel user) => user.description.toString()
  //     },
  //     {
  //       'name': 'Qualifications',
  //       'extractor': (VacancyModel user) => user.qualifications.toString()
  //     },
  //     {
  //       'name': 'City',
  //       'extractor': (VacancyModel user) => user.city.toString()
  //     },
  //     // {
  //     //   'name': 'State',
  //     //   'extractor': (ProjectModel user) => user.state.toString()
  //     // },
  //     {
  //       'name': 'Country',
  //       'extractor': (VacancyModel user) => user.country.toString()
  //     },
  //     // {'name': 'Action', 'extractor': (ProjectModel user) => user},
  //   ];
  // }
}
