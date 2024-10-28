import 'package:flutter/material.dart';
import 'package:heycowmobileapp/models/cattle.dart';
import 'package:heycowmobileapp/screens/cattle_module/pengangon_list_screen.dart'; // Import your controller
import 'package:get/get.dart';

class PengangonDetailScreen extends StatelessWidget {
  const PengangonDetailScreen({super.key});

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
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 100),
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
                                'Data',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 25.0),
                              // Table for cattle data
                              Table(
                                border: TableBorder.all(),
                                columnWidths: const {0: FixedColumnWidth(150)},
                                children: [
                                  _buildTableRow('Name', 'Cattle 1'),
                                  _buildTableRow('Breed', 'Limousin'),
                                  _buildTableRow('Date of Birth', '10-12-2004'),
                                  _buildTableRow('Weight', '45 kg'),
                                  _buildTableRow('Height', '170 cm'),
                                  _buildTableRow('Gender', 'male'),
                                  _buildTableRow('Vaccine', '01-01-2024'),
                                  _buildTableRow('ID Device', '8271-2323-5602'),
                                  _buildTableRow('Battery', '87%'),
                                ],
                              ),

                              const SizedBox(height: 25.0),
                              const Text(
                                'Health Monitoring',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 25.0),
                              Table(
                                border: TableBorder.all(),
                                columnWidths: const {0: FixedColumnWidth(150)},
                                children: [
                                  _buildTableRow('Body Temperature', '22°C'),
                                  _buildTableRow('Activity', 'Normal'),
                                  _buildTableRow('Date of Birth', '10-12-2004'),
                                ],
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
                                              Get.to(() =>
                                                  const PengangonListScreen());
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
                                              // Aksi tombol kedua
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

  TableRow _buildTableRow(String label, String value) {
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
}
