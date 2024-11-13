import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestDetailScreen extends StatelessWidget {
  final String id;

  const RequestDetailScreen({super.key, required this.id});

  Future<void> approveRequest() async {
    try {
      final response = await GetConnect().put('https://heycow.my.id/request-angon/$id/approved', {});
      if (response.isOk) {
        Get.snackbar("Success", "Request approved successfully");
      } else {
        Get.snackbar("Error", "Failed to approve request");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while approving request");
    }
  }

  Future<void> rejectRequest() async {
    try {
      final response = await GetConnect().put('https://heycow.my.id/request-angon/$id/reject', {});
      if (response.isOk) {
        Get.snackbar("Success", "Request rejected successfully");
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
      backgroundColor: Color(0xFFEAEBED),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Set tombol back menjadi putih
        ),
        title: const Text('Contract',
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Content (unchanged from your code)
                    
                    // Payment Status Section
                    const Row(
                      children: [
                        Icon(Icons.dangerous, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          'Belum Lunas',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff20A577),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        // Get.to(() => SnapScreen());
                      },
                      child: const Text(
                        'Bayar',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Approve and Reject Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: approveRequest,
                          child: const Text(
                            'Approve',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: rejectRequest,
                          child: const Text(
                            'Reject',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
