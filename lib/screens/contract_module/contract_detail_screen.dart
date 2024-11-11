// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:heycowmobileapp/screens/cattle_module/snap_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:heycowmobileapp/controllers/auth_controller.dart';

class ContractDetailScreen extends StatefulWidget {
  final int id;

  const ContractDetailScreen({super.key, required this.id});

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
        'Authorization':
            'Bearer ${_authController.accessToken}', // Add your auth token here
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

  Future<void> selesaikanContrat() async {
    final response = await http.post(
      Uri.parse('https://heycow.my.id/api/contract/${widget.id}/return'),
      headers: <String, String>{
        'Authorization':
            'Bearer ${_authController.accessToken}', // Add your auth token here
      },
    );

    if (response.statusCode == 200) {
      fetchContractDetails();
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange; // Orange for 'pending'
      case 'active':
        return Colors.blue; // Blue for 'active'
      case 'completed':
        return Colors.green; // Green for 'completed'
      case 'returned':
        return Colors.grey; // Grey for 'returned'
      default:
        return Colors.black; // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                    // Contract Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          contractDetails?['contract_code'] ?? 'N/A',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(
                                contractDetails?['status'] ?? 'N/A'),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            contractDetails?['status'] ?? 'N/A',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      contractDetails?['cattleName'] ?? 'N/A',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${contractDetails?['farmName'] ?? 'N/A'}\n${contractDetails?['farmAddress'] ?? 'N/A'}\n${contractDetails?['pengangonPhone'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const Divider(height: 30),
                    const Text(
                      'Mulai Mengangon',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      contractDetails?['start_date'] ?? 'N/A',
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Akhir Mengangon',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      contractDetails?['end_date'] ?? 'N/A',
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const Divider(height: 30),
                    const Text(
                      'Biaya',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Jasa Pengangon',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        Text(
                          contractDetails?['pengangonFee'] ?? 'N/A',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      contractDetails?['pengangonName'] ?? 'N/A',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                    const Divider(height: 30),

                    if (contractDetails?['status'] == 'pending') ...[
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

                          // Payment Button
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff20A577),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(5), // Rounded corners
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => SnapScreen(
                                id: widget.id,
                              )); //
                          // Aksi tombol kedua
                        },
                        child: const Text(
                          'Bayar',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors
                                .white, // Mengubah warna teks menjadi putih
                          ),
                        ),
                      ),
                    ] else if (contractDetails?['status'] == 'active') ...[
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            'Lunas',
                            style: TextStyle(
                              color: Colors.green,
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
                            borderRadius:
                                BorderRadius.circular(5), // Rounded corners
                          ),
                        ),
                        onPressed: () {
                          selesaikanContrat();
                        },
                        child: const Text(
                          'Selesaikan Kontrak',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors
                                .white, // Mengubah warna teks menjadi putih
                          ),
                        ),
                      ),
                      // selesaikan kontrak button
                    ],
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
