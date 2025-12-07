import '../../../../model/lead/lead_model.dart';
import '../../../../model/project/client_model.dart';
import '../../../../model/project/project_model.dart';

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
        'name': 'Phone',
        'extractor': (ClientModel user) => user.phone.toString()
      },
      {
        'name': 'Alternate Phone',
        'extractor': (ClientModel user) => user.alternatePhone.toString()
      },
      {
        'name': 'Email',
        'extractor': (ClientModel user) => user.email.toString()
      },
      {
        'name': 'Address',
        'extractor': (ClientModel user) =>
            ' ${user.address.toString()} ${user.city.toString()} ${user.state.toString()}'
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
        'name': 'Organization Type',
        'extractor': (ProjectModel user) => user.organizationType.toString()
      },
      {
        'name': 'Organization Category',
        'extractor': (ProjectModel user) => user.organizationCategory.toString()
      },
      // {
      //   'name': 'Created At',
      //   'extractor': (ProjectModel user) {
      //     try {
      //       final date = DateTime.parse(user.createdAt ?? '');
      //       return DateFormat('dd-MM-yyyy').format(date);
      //     } catch (e) {
      //       return '';
      //     }
      //   }
      // },
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
      // {
      //   'name': 'Project Name',
      //   'extractor': (VacancyModel user) => user.project?.projectName ?? ''
      // },
      // {
      //   'name': 'Job Profile',
      //   'extractor': (VacancyModel user) => user.jobCategory ?? ''
      // },
      // {
      //   'name': 'Specializations',
      //   'extractor': (VacancyModel user) => user.specializationTotals != null
      //       ? user.specializationTotals
      //           ?.map((e) => e.specialization.toString())
      //           .join(", ")
      //       : ''
      // },
      // {
      //   'name': 'Experience',
      //   'extractor': (VacancyModel user) => user.experience ?? ''
      // },
      // {
      //   'name': 'Qualifications',
      //   'extractor': (VacancyModel user) =>
      //       user.qualifications?.join(", ") ?? ''
      // },
      // {
      //   'name': 'Country',
      //   'extractor': (VacancyModel user) => user.country ?? ''
      // },
      // {
      //   'name': 'Last Date',
      //   'extractor': (VacancyModel user) => user.lastDateToApply
      // },
      // {
      //   'name': 'Total Vacancies',
      //   'extractor': (VacancyModel user) => user.totalVacancies.toString()
      // },
      // {
      //   'name': 'Target CV',
      //   'extractor': (VacancyModel user) => user.totalTargetCv.toString()
      // },
      // {
      //   'name': 'Action',
      //   'extractor': (VacancyModel user) => user,
      // },
    ];
  }

  List<Map<String, dynamic>> matchingList() {
    return [
      {'name': 'ID', 'extractor': (LeadModel user) => user.clientId.toString()},
      {
        'name': 'Display Name',
        'extractor': (LeadModel user) => user.name.toString()
      },
      {
        'name': 'Phone Number',
        'extractor': (LeadModel user) => user.phone.toString()
      },
      {
        'name': 'Status',
        'extractor': (LeadModel user) => user.status.toString()
      },
      {
        'name': 'Qualification',
        'extractor': (LeadModel user) => user.qualification ?? ''
      },
      {
        'name': 'Experience',
        'extractor': (LeadModel user) => user.experience.toString() ?? ''
      },
      {
        'name': 'Country Interested',
        'extractor': (LeadModel user) =>
            user.countryInterested?.map((e) => e.toString()).join(", ") ?? ''
      },
      {
        'name': 'Action',
        'extractor': (LeadModel user) => user.clientId.toString()
      },
    ];
  }

  List<Map<String, dynamic>> shortListed() {
    return [
      {'name': 'ID', 'extractor': (LeadModel user) => user.clientId.toString()},
      {
        'name': 'Display Name',
        'extractor': (LeadModel user) => user.name.toString()
      },
      {
        'name': 'Phone Number',
        'extractor': (LeadModel user) => user.phone.toString()
      },
      {
        'name': 'Status',
        'extractor': (LeadModel user) => user.status.toString()
      },
      {
        'name': 'Qualification',
        'extractor': (LeadModel user) => user.qualification ?? ''
      },
      {
        'name': 'Country Interested',
        'extractor': (LeadModel user) =>
            user.countryInterested?.map((e) => e.toString()).join(", ") ?? ''
      },
      {
        'name': 'Action',
        'extractor': (LeadModel user) => user.clientId.toString()
      },
    ];
  }

  // List<Map<String, dynamic>> vacancyTableList() {
  //   return [
  //     // {'name': 'ID', 'extractor': (VacancyModel user) => user.clientId.toString()},
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
