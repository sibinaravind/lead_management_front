import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF222B45); // Deep Blue

  static const LinearGradient buttonGraidentColour = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6366F1), // Indigo 500
      Color(0xFF8B5CF6), // Violet 500
    ],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E293B),
      Color(0xFF222B45),
      Color(0xFF3B82F6),
    ],
  );

  static const LinearGradient orangeGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 247, 184, 75),
      Color(0xFFF59E0B),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGraident = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF8FAFC),
      Color(0xFFEFF6FF),
      Color(0xFFF1F5F9),
    ],
  );

  static LinearGradient blackGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primaryColor,
      AppColors.primaryColor.withOpacity(0.8),
    ],
  );

  static LinearGradient redGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 196, 84, 84),
      Color.fromARGB(255, 162, 13, 13),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient greenGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 10, 185, 129),
      Color.fromARGB(255, 0, 128, 64),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient pinkGradient = LinearGradient(
    colors: [
      Color(0xFFEC4899),
      Color(0xFFD81B60),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [
      Color(0xFF3B82F6),
      Color(0xFF1E40AF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Color get violetPrimaryColor => Color(0xFF6366F1);

  static List<Color> roleColors = [
    Color(0xFF3B82F6),
    Color(0xFF10B981),
    Color(0xFF8B5CF6),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFFEC4899),
    Color(0xFF06B6D4),
    Color(0xFF6366F1),
    Color(0xFFEC4899),
    Color(0xFF06B6D4),
  ];
}

class CustomerJourneyData {
  final String id;
  final String type;
  final String clientId;
  final DateTime createdAt;
  final String comment;
  final Officer officer;

  CustomerJourneyData({
    required this.id,
    required this.type,
    required this.clientId,
    required this.createdAt,
    required this.comment,
    required this.officer,
  });

  factory CustomerJourneyData.fromJson(dynamic json) {
    final Map<String, dynamic> data = Map<String, dynamic>.from(json);
    return CustomerJourneyData(
      id: data['_id'] ?? '',
      type: data['type'] ?? '',
      clientId: data['client_id'] ?? '',
      createdAt: DateTime.parse(
          data['created_at'] ?? DateTime.now().toIso8601String()),
      comment: data['comment'] ?? '',
      officer: Officer.fromJson(data['officer'] ?? {}),
    );
  }
}

class Officer {
  final String id;
  final String name;
  final String phone;
  final String officerId;
  final List<String> designation;

  Officer({
    required this.id,
    required this.name,
    required this.phone,
    required this.officerId,
    required this.designation,
  });

  factory Officer.fromJson(dynamic json) {
    final Map<String, dynamic> data = Map<String, dynamic>.from(json);
    return Officer(
      id: data['_id'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      officerId: data['officer_id'] ?? '',
      designation: List<String>.from(data['designation'] ?? []),
    );
  }
}

class CustomerJourneyStages extends StatelessWidget {
  final List<CustomerJourneyData> journeyData;

  const CustomerJourneyStages({
    Key? key,
    required this.journeyData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.backgroundGraident,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Journey',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          ...journeyData.asMap().entries.map((entry) {
            int index = entry.key;
            CustomerJourneyData data = entry.value;
            bool isLast = index == journeyData.length - 1;

            return _buildStageItem(data, index, isLast);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStageItem(CustomerJourneyData data, int index, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: _getGradientForType(data.type),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _getColorForType(data.type).withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                _getIconForType(data.type),
                color: Colors.white,
                size: 20,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _getColorForType(data.type).withOpacity(0.5),
                      Colors.grey.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),
        // Content
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: _getGradientForType(data.type),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getStageTitle(data.type),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatDate(data.createdAt),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (data.comment.isNotEmpty)
                  Text(
                    data.comment,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                const SizedBox(height: 8),
                if (data.officer.name.isNotEmpty)
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          gradient: AppColors.buttonGraidentColour,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.officer.name,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (data.officer.designation.isNotEmpty)
                              Text(
                                data.officer.designation.join(', '),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 11,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  LinearGradient _getGradientForType(String type) {
    switch (type.toLowerCase()) {
      case 'customer_created':
        return AppColors.greenGradient;
      case 'assign_officer':
        return AppColors.blueGradient;
      case 'status_update':
        return AppColors.orangeGradient;
      case 'client_restored':
        return AppColors.pinkGradient;
      default:
        return AppColors.buttonGraidentColour;
    }
  }

  Color _getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'customer_created':
        return const Color(0xFF10B981);
      case 'assign_officer':
        return const Color(0xFF3B82F6);
      case 'status_update':
        return const Color(0xFFF59E0B);
      case 'client_restored':
        return const Color(0xFFEC4899);
      default:
        return AppColors.violetPrimaryColor;
    }
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'customer_created':
        return Icons.person_add;
      case 'assign_officer':
        return Icons.assignment_ind;
      case 'status_update':
        return Icons.update;
      case 'client_restored':
        return Icons.restore;
      default:
        return Icons.timeline;
    }
  }

  String _getStageTitle(String type) {
    switch (type.toLowerCase()) {
      case 'customer_created':
        return 'Customer Created';
      case 'assign_officer':
        return 'Officer Assigned';
      case 'status_update':
        return 'Status Updated';
      case 'client_restored':
        return 'Client Restored';
      default:
        return type.replaceAll('_', ' ').toUpperCase();
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

// Usage Example
class CustomerJourneyScreen extends StatelessWidget {
  const CustomerJourneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Your JSON data
    final Map<String, dynamic> jsonData = {
      "success": true,
      "data": [
        {
          "_id": "6878fe523e1c829a55bcebef",
          "type": "customer_created",
          "client_id": "6878fe523e1c829a55bcebee",
          "created_at": "2025-07-17T13:44:50.597Z",
          "comment": "Looking for remote opportunities",
          "officer": {
            "_id": "686d1edde9299f3429d623a5",
            "name": "Mr Aswin",
            "phone": "+1234568881",
            "officer_id": "64",
            "designation": ["COUNSILOR"]
          }
        },
        {
          "_id": "68792fe82e03cb8ceca5457b",
          "type": "assign_officer",
          "client_id": "6878fe523e1c829a55bcebee",
          "created_at": "2025-07-17T17:16:24.923Z",
          "comment": "tsting",
          "officer": {
            "_id": "686d1edde9299f3429d623a5",
            "name": "Mr Aswin",
            "phone": "+1234568881",
            "officer_id": "64",
            "designation": ["COUNSILOR"]
          }
        },
        {
          "_id": "68792fff2e03cb8ceca5457c",
          "type": "status_update",
          "client_id": "6878fe523e1c829a55bcebee",
          "created_at": "2025-07-17T17:16:47.970Z",
          "comment": "cmd",
          "officer": {
            "_id": "686ceda9e9299f3429d6239a",
            "name": "Mr Sibin James",
            "phone": "+91 3456789344",
            "officer_id": "4",
            "designation": ["COUNSILOR", "ADMIN"]
          }
        },
        {
          "_id": "687930c52e03cb8ceca5457f",
          "type": "status_update",
          "client_id": "6878fe523e1c829a55bcebee",
          "created_at": "2025-07-17T17:20:05.818Z",
          "comment": "cmd",
          "officer": {
            "_id": "686ceda9e9299f3429d6239a",
            "name": "Mr Sibin James",
            "phone": "+91 3456789344",
            "officer_id": "4",
            "designation": ["COUNSILOR", "ADMIN"]
          }
        },
        {
          "_id": "687ba45e30cc9a790f7fd0fb",
          "type": "client_restored",
          "client_id": "6878fe523e1c829a55bcebee",
          "created_at": "2025-07-19T13:57:50.274Z",
          "comment": "yes",
          "officer": {}
        }
      ]
    };

    // Parse the data
    final List<CustomerJourneyData> journeyData = (jsonData['data'] as List)
        .map((item) => CustomerJourneyData.fromJson(item))
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Customer Journey'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppColors.heroGradient,
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: CustomerJourneyStages(journeyData: journeyData),
      ),
    );
  }
}
