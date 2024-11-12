import 'package:flutter/material.dart';
import 'package:heycowmobileapp/screens/contract_module/contract_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<dynamic> historyData = [];
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    fetchHistoryData();
  }

  Future<void> fetchHistoryData() async {
    final url = Uri.parse(
        'https://heycow.my.id/api/history_records'); // Replace with your API endpoint
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer ${_authController.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        setState(() {
          historyData = data['data'];
        });
      }
    } else {
      // Handle API error here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'History',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: historyData.length,
              itemBuilder: (context, index) {
                final item = historyData[index];
                return RequestItem(
                  date: "2024-10-14", // Replace with actual date if available
                  title: item['message'],
                  statusText: item['record_type'],
                  initialData: item['old_value'],
                  finalData: item['new_value'],
                  statusColor: Colors.blue, // Customize as needed
                  icon: Icons.history,
                  cattleId: item['cattle_id'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RequestItem extends StatelessWidget {
  final String date;
  final String title;
  final String statusText;
  final String initialData;
  final String finalData;
  final Color statusColor;
  final IconData icon;
  final int cattleId;

  const RequestItem({
    super.key,
    required this.date,
    required this.title,
    required this.statusText,
    required this.initialData,
    required this.finalData,
    required this.statusColor,
    required this.icon,
    required this.cattleId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContractDetailScreen(
              id: cattleId,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Icon(
                  icon,
                  color: statusColor,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  statusText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: statusColor,
                  ),
                ),
                const SizedBox(width: 20,),
                Text(
                  initialData,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                // arrow icon
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.grey,
                  size: 16,
                ),

                Text(
                  finalData,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
