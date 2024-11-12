import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:heycowmobileapp/controllers/auth_controller.dart';

import 'package:get/get.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final AuthController _authController = Get.find<AuthController>();

  List<dynamic> requests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    final response = await http.get(
      Uri.parse('https://heycow.my.id/api/request-angon'),
      headers: <String, String>{
        'Authorization': 'Bearer ${_authController.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        requests = jsonData['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> approveRequest(int id) async {
    try {
      final response = await GetConnect().put(
        'https://heycow.my.id/api/request-angon/$id/approve',
        {},
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_authController.accessToken}',
        },
      );
      if (response.isOk) {
        Get.snackbar("Success", "Request approved successfully");
        fetchRequests(); // Refresh requests after approval
      } else {
        Get.snackbar("Error", "Failed to approve request");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while approving request");
    }
  }

  Future<void> rejectRequest(int id) async {
    try {
      final response = await GetConnect().put(
        'https://heycow.my.id/api/request-angon/$id/reject',
        {},
        headers: {
          'Authorization': 'Bearer ${_authController.accessToken}',
        },
      );
      if (response.isOk) {
        Get.snackbar("Success", "Request rejected successfully");
        fetchRequests(); // Refresh requests after rejection
      } else {
        Get.snackbar("Error", "Failed to reject request");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while rejecting request");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Requests',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF20A577), Color(0xFF64CFAA)],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFEAEBED),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : requests.isEmpty
              ? const Center(child: Text("No requests found"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return RequestItem(
                      date: request['tanggal'] ?? 'N/A',
                      title: request['title'],
                      statusText: request['status'],
                      isPengangon: request['is_pengangon'],
                      statusColor: getStatusColor(request['status']),
                      icon: getStatusIcon(request['status']),
                      onApprove: () => approveRequest(request['id']),
                      onDecline: () => rejectRequest(request['id']),
                    );
                  },
                ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.hourglass_empty;
      case 'approved':
        return Icons.check_circle;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }
}

class RequestItem extends StatelessWidget {
  final String date;
  final String title;
  final String statusText;
  final Color statusColor;
  final IconData icon;
  final bool isPengangon;
  final VoidCallback onApprove;
  final VoidCallback onDecline;

  const RequestItem({
    super.key,
    required this.date,
    required this.title,
    required this.statusText,
    required this.statusColor,
    required this.icon,
    required this.isPengangon,
    required this.onApprove,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const ContractDetailScreen(
        //       id: 1,
        //     ),
        //   ),
        // );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(icon, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        statusText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isPengangon) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: onDecline,
                    child: const Text(
                      'Decline',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff20A577),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: onApprove,
                    child: const Text(
                      'Approve',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
