import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../model/project/client_data_vacancy_model.dart';

class ClientDashboard extends StatefulWidget {
  const ClientDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ClientDashboardState createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  List<VacancyClientDataModel> clients = [];
  bool isLoading = true;
  String? error;
  Set<String> expandedClients = {};

  @override
  void initState() {
    super.initState();
  }

  void toggleExpanded(String clientId) {
    setState(() {
      if (expandedClients.contains(clientId)) {
        expandedClients.remove(clientId);
      } else {
        expandedClients.add(clientId);
      }
    });
  }

  Color getStatusColor(String status) {
    return status.toLowerCase() == 'active' ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSummaryCards(),
          SizedBox(height: 24),
          _buildClientList(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    int activeClients =
        clients.where((c) => c.clientInfo?.status == 'active').length;
    // double totalCommission = clients.fold(0.0, (sum, client) => sum + client.commissionHistory);
    double totalCommission = 0;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Total Clients',
            clients.length.toString(),
            Icons.people,
            Colors.blue,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'Active',
            activeClients.toString(),
            Icons.check_circle,
            Colors.green,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'Commission',
            '\$${totalCommission.toStringAsFixed(0)}',
            Icons.attach_money,
            Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientList() {
    return Column(
      children: clients.map((client) => _buildClientCard(client)).toList(),
    );
  }

  Widget _buildClientCard(VacancyClientDataModel client) {
    bool isExpanded = expandedClients.contains(client.clientId);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Client Header - Only Name and Email
          InkWell(
            onTap: () => toggleExpanded(client.clientId ?? ''),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[600]!, Colors.purple[600]!],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.business, color: Colors.white, size: 24),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client.clientInfo?.name ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          client.clientInfo?.email ?? '',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey[600],
                    size: 28,
                  ),
                ],
              ),
            ),
          ),

          // Expanded Details
          if (isExpanded) _buildExpandedDetails(client),
        ],
      ),
    );
  }

  Widget _buildStatChip(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedDetails(VacancyClientDataModel client) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status and Stats Row
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: getStatusColor(client.clientInfo?.status ?? '')
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: getStatusColor(client.clientInfo?.status ?? '')
                        .withOpacity(0.3),
                  ),
                ),
                child: Text(
                  client.clientInfo?.status?.toUpperCase() ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: getStatusColor(client.clientInfo?.status ?? ""),
                  ),
                ),
              ),
              Spacer(),
              _buildStatChip(
                  '${client.vacancies?.length ?? 0}', 'Vacancies', Colors.blue),
              SizedBox(width: 16),
              _buildStatChip('{client.vacancies.map(convert)}', 'Target CVs',
                  Colors.orange),
              SizedBox(width: 16),
              _buildStatChip('\${client.totalCommission.toInt()}', 'Commission',
                  Colors.green),
            ],
          ),

          SizedBox(height: 20),

          // Contact Information
          _buildSectionTitle('Contact Information', Icons.contact_mail),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                    'Phone', client.clientInfo?.phone ?? '', Icons.phone),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildInfoItem('Address',
                    client.clientInfo?.address ?? '', Icons.location_on),
              ),
            ],
          ),
          SizedBox(height: 12),
          _buildInfoItem(
              'Location',
              '${client.clientInfo?.city}, ${client.clientInfo?.country}',
              Icons.place),

          SizedBox(height: 20),

          // Vacancies
          _buildSectionTitle('Vacancies', Icons.work),
          SizedBox(height: 12),
          // ...client.vacancies?.entries.map((entry) =>
          //     _buildVacancyItem(entry.key, entry.value)
          // ).toList()??[],

          SizedBox(height: 20),

          // Commission History
          _buildSectionTitle('Commission History', Icons.trending_up),
          SizedBox(height: 12),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: client.commissionHistory?.length,
              itemBuilder: (context, index) {
                final commission =
                    client.commissionHistory?[index] ?? [] as CommissionHistory;
                return _buildCommissionItem(commission);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.indigo[600], size: 20),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVacancyItem(String type, VacancyClientDataModel? vacancy) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '{vacancy?.vacancies.count??0} positions',
                style: TextStyle(
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              // if (vacancy.targetCv > 0)
              Text(
                '{vacancy.targetCv} target CVs',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommissionItem(CommissionHistory? commission) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('MMM dd, yyyy - HH:mm')
                .format(commission?.updatedAt ?? DateTime.now()),
            style: TextStyle(fontSize: 14),
          ),
          Text(
            '\$${commission?.value?.toStringAsFixed(0)}',
            style: TextStyle(
              color: Colors.green[600],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
