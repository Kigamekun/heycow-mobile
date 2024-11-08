import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:heycowmobileapp/screens/cattle_module/snap_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:heycowmobileapp/controllers/auth_controller.dart';

import 'package:get/get.dart';

class ContractDetailScreen extends StatefulWidget {
  final int id;

  ContractDetailScreen({required this.id});

  @override
  _ContractDetailScreenState createState() => _ContractDetailScreenState();
}

class _ContractDetailScreenState extends State<ContractDetailScreen> {
  Map<String, dynamic>? contractDetails;
  final AuthController _authController = Get.find<AuthController>();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContractDetails();
  }

  Future<void> fetchContractDetails() async {
    final response = await http.get(
      Uri.parse('https://heycow.my.id/api/contract/${widget.id}'),
      headers: <String, String>{
        'Authorization': 'Bearer ${_authController.accessToken}', // Add your auth token here
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        contractDetails = jsonData['data'];
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Contract',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF20A577),
                Color(0xFF64CFAA),
              ],
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : contractDetails == null
              ? Center(child: Text("Failed to load contract details"))
              : Column(
                  children: [
                    // Display contract details
                    Text(
                      'Contract ID: ${contractDetails!['id']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Cattle: ${contractDetails!['cattle']}',
                      style: TextStyle(fontSize: 14),
                    ),
                    // Add other contract details here

                    const Divider(height: 30),
                    Row(
                      children: [
                        Icon(
                          contractDetails!['paymentStatus'] == 'unpaid'
                              ? Icons.dangerous
                              : Icons.check_circle,
                          color: contractDetails!['paymentStatus'] == 'unpaid'
                              ? Colors.red
                              : Colors.green,
                        ),
                        SizedBox(width: 8),
                        Text(
                          contractDetails!['paymentStatus'] == 'unpaid'
                              ? 'Belum Lunas'
                              : 'Lunas',
                          style: TextStyle(
                            color: contractDetails!['paymentStatus'] == 'unpaid'
                                ? Colors.red
                                : Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff20A577),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => SnapScreen());
                      },
                      child: const Text(
                        'Bayar',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
    );
  }
}
