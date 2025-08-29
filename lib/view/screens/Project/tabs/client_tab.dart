import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/project/project_controller.dart';

import '../../../../model/project/client_data_vacancy_model.dart';
import '../../../../utils/style/colors/colors.dart';

class ClientTab extends StatefulWidget {
  final String id;
  const ClientTab({super.key, required this.id});

  @override
  State<ClientTab> createState() => _ClientTabState();
}

class _ClientTabState extends State<ClientTab> {
  List<VacancyClientDataModel> data = [];
  final _projectController = Get.find<ProjectController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchClient();
    });
  }

  Future<void> fetchClient() async {
    _projectController
        .fetchVacancyClient(widget.id)
        .then((value) {})
        .catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Obx(
          () {
            final clients = _projectController.vacanciesClientList;

            if (clients == null || clients.isEmpty) {
              return Center(child: Text('No clients found.'));
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients[index];

                return Card(
                  color: AppColors.whiteMainColor,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Client Header
                        Text(
                          client.name ?? '',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 12.0),
                        // Client Details
                        Text('Email: ${client.email}',
                            style: TextStyle(fontSize: 16.0)),
                        Text('Phone: ${client.phone}',
                            style: TextStyle(fontSize: 16.0)),
                        Text(
                          'Address: ${client.address}, ${client.city}, ${client.country}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 16.0),
                        // Vacancies Section
                        Text(
                          'Vacancies',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8.0),
                        ...client.vacancies?.entries.map((vacancy) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Type: ${vacancy.key} | Count: ${vacancy.value.count} | Target CV: ${vacancy.value.targetCv ?? 'N/A'}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: AppColors.greenSecondaryColor),
                                ),
                              );
                            }).toList() ??
                            [],
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
