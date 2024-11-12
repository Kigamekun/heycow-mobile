import 'package:flutter/material.dart';

// Dummy API call function
Future<Map<String, dynamic>> fetchHealthData() async {
  await Future.delayed(const Duration(seconds: 2)); // Simulating network delay
  return {
    'checkUpTime': '12-02-2024',
    'veterinarian': 'Riani Pujawasti',
    'activity': 'Normal',
    'weight': '145 kg',
    'heartRate': '56 hr/m',
    'temperature': '39°C',
  };
}

class HealthMonitoringScreen extends StatefulWidget {
  const HealthMonitoringScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HealthMonitoringScreenState createState() => _HealthMonitoringScreenState();
}

class _HealthMonitoringScreenState extends State<HealthMonitoringScreen> {
  late Future<Map<String, dynamic>> _healthData;

  @override
  void initState() {
    super.initState();
    _healthData = fetchHealthData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Health Records',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF20A577), // Start color
                Color(0xFF64CFAA), // End color
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFEAEBED),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: _healthData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching data'));
                } else {
                  final data = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Health Monitoring',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDataTable(data),
                      const SizedBox(height: 24),
                      const Text(
                        'Health Records',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildRecordItem('October 2024', [
                        _buildRecordDetail(
                            '28 Senin', 'Weight Measurement', 'Weight: 173 kg'),
                        _buildRecordDetail('26 Sabtu', 'Temperature Measurement',
                            'Temperature: 38.4°C'),
                      ]),
                      _buildRecordItem('November 2024', [
                        _buildRecordDetail(
                            '05 Minggu', 'Heart Rate Measurement', 'Heart Rate: 60 hr/m'),
                      ]),
                    ],
                  );
                }
              },
            ),
            const Spacer(),
      
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable(Map<String, dynamic> data) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
      },
      children: [
        _buildDataRow('Check Up Time', data['checkUpTime']),
        _buildDataRow('Veterinarian', data['veterinarian']),
        _buildDataRow('Activity', data['activity']),
        _buildDataRow('Weight', data['weight']),
        _buildDataRow('Heart Rate', data['heartRate']),
        _buildDataRow('Temperature', data['temperature']),
      ],
    );
  }

  TableRow _buildDataRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
      ],
    );
  }

 Widget _buildRecordItem(String monthYear, List<Widget> records) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        childrenPadding: const EdgeInsets.all(16),
        title: Text(
          monthYear,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.add),
        children: records,
      ),
    ),
  );
}

  Widget _buildRecordDetail(String date, String title, String detail) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,
            child: Text(
              date.split(' ')[0],
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                detail,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
