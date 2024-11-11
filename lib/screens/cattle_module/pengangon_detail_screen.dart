// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:heycowmobileapp/models/pengangon.dart';
import 'package:heycowmobileapp/screens/cattle_module/detail_request_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'dart:convert';

class PengangonDetailScreen extends StatefulWidget {
  final int id;
  final int cattleId;

  const PengangonDetailScreen(
      {super.key, required this.id, required this.cattleId});

  @override
  State<PengangonDetailScreen> createState() => _PengangonDetailScreenState();
}

class _PengangonDetailScreenState extends State<PengangonDetailScreen> {
  Map<String, dynamic>? pengangonDetail;
  String? _selectedDuration; // Menyimpan durasi yang dipilih
  final AuthController _authController = Get.find<AuthController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContractDetails();
  }

  Future<void> fetchContractDetails() async {
    final response = await http.get(
      Uri.parse('https://heycow.my.id/api/users/${widget.id}/detail'),
      headers: <String, String>{
        'Authorization':
            'Bearer ${_authController.accessToken}', // Add your auth token here
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        pengangonDetail = jsonData['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> postAngonkan() async {
    if (_selectedDuration == null) {
      // Handle jika durasi belum dipilih
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih durasi terlebih dahulu')),
      );
      return;
    }

    final durationInt = _selectedDuration == '6 Bulan' ? 6 : 12;
    final response = await http.post(
      Uri.parse('https://heycow.my.id/api/request-angon'),
      headers: <String, String>{
        'Authorization': 'Bearer ${_authController.accessToken}',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'peternak_id': widget.id,
        'cattle_id': widget.cattleId,
        'durasi': durationInt,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request berhasil')),
      );

          final body = json.decode(response.body);

    // Pass the 'data' to the DetailRequestScreen
    Get.to(() => DetailRequestScreen(data: body['data']));
    
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal melakukan request')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEBED),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff20A577), // Top color
                                  Color(0xff64CFAA), // Bottom color
                                ],
                                stops: [0.1, 0.5],
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            height: 250, // Height of the gradient container
                            width: double.infinity,
                          ),
                          const SizedBox(height: 95),
                        ],
                      ),
                      Positioned(
                        top: 150,
                        left: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33959DA5),
                                blurRadius: 24,
                                offset: Offset(0, 8),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomCard(
                                pengangon: Pengangon(
                                  id: pengangonDetail != null
                                      ? pengangonDetail!['pengangon']['id']
                                      : 0,
                                  name: pengangonDetail != null
                                      ? pengangonDetail!['pengangon']['name']
                                      : '',
                                  farm: pengangonDetail != null
                                      ? pengangonDetail!['pengangon']['farm']
                                      : '',
                                  address: pengangonDetail != null
                                      ? pengangonDetail!['pengangon']['address']
                                      : '',
                                  upah: pengangonDetail != null
                                      ? pengangonDetail!['pengangon']['upah']
                                      : "",
                                  rate: pengangonDetail != null
                                      ? pengangonDetail!['pengangon']['rate']
                                      : 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 20.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33959DA5),
                                blurRadius: 24,
                                offset: Offset(0, 8),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Riwayat Pelanggan',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 25.0),
                              // Table for cattle data
                              Table(
                                border: TableBorder.all(),
                                columnWidths: const {0: FixedColumnWidth(150)},
                                children: [
                                  _buildTableRowHeading(
                                      'Pelanggan', 'Sapi', 'Durasi'),
                                  if (pengangonDetail?['riwayat_pelanggan'] !=
                                      null)
                                    ...pengangonDetail!['riwayat_pelanggan']
                                        .map<TableRow>((data) => _buildTableRow(
                                              data['customer_name'] ?? '',
                                              data['cow_name'] ?? '',
                                              data['durasi'] ?? '',
                                            ))
                                        .toList(),
                                  if (pengangonDetail?['riwayat_pelanggan'] ==
                                      null)
                                    _buildTableRow(
                                        'Data tidak tersedia', '', ''),
                                ],
                              ),

                              const SizedBox(height: 20.0),

                              const Text(
                                'Durasi Mengangon:',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 20.0),

                              DropdownButtonFormField<String>(
                                items: ['6 Bulan', '1 Tahun'].map((type) {
                                  return DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(type),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedDuration = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Pilih Durasi Mengangon',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF20A577)),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 30.0),

                              Row(
                                children: <Widget>[
                                  // Expanded pertama dengan flex 5
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          width: double
                                              .infinity, // Memastikan tombol mengisi seluruh lebar
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xffFACC15),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5), // Rounded corners
                                              ),
                                            ),
                                            onPressed: () {
                                              // Get.to(() =>
                                              //     const PengangonListScreen());
                                            },
                                            child: const Text(
                                              'Kembali',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors
                                                    .white, // Mengubah warna teks menjadi putih
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 20),

                                  // Expanded kedua dengan flex 2
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          width: double
                                              .infinity, // Memastikan tombol mengisi seluruh lebar
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xff20A577),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5), // Rounded corners
                                              ),
                                            ),
                                            onPressed: () {
                                              postAngonkan();
                                            },
                                            child: const Text(
                                              'Angonkan',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors
                                                    .white, // Mengubah warna teks menjadi putih
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 100.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Floating Bottom Navigation Bar
        ],
      ),
    );
  }

  TableRow _buildTableRowHeading(String label, String value, String value2) {
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
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value2,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(String label, String value, String value2) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value2),
        ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final Pengangon pengangon;

  const CustomCard({super.key, required this.pengangon});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Details Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * 0.5,
                    child: Text(
                      pengangon.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pengangon.farm,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pengangon.address,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pengangon.upah,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < pengangon.rate ? Icons.star : Icons.star_border,
                  color: index < pengangon.rate ? Colors.amber : Colors.grey,
                  size: 30,
                );
              }),
            ),
          ],
        )
      ],
    );
  }
}
