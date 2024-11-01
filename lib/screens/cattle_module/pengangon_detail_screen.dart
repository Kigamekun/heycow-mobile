import 'package:flutter/material.dart';
import 'package:heycowmobileapp/models/cattle.dart';
import 'package:heycowmobileapp/screens/cattle_module/detail_contract_screen.dart';
import 'package:heycowmobileapp/screens/cattle_module/pengangon_list_screen.dart'; // Import your controller
import 'package:get/get.dart';
import 'package:heycowmobileapp/models/pengangon.dart';

class PengangonDetailScreen extends StatefulWidget {
  const PengangonDetailScreen({super.key});

  @override
  State<PengangonDetailScreen> createState() => _PengangonDetailScreenState();
}

class _PengangonDetailScreenState extends State<PengangonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    String selectedDuration = '6 Bulan';

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
                              CustomCard(),
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
                                  _buildTableRow('Name', 'Sapi'),
                                  _buildTableRow('Ahmad Abdul', 'Limousin 1'),
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
                                    items: [
                                      '6 Bulan',
                                      '1 Tahun',
                                    ].map((type) {
                                      return DropdownMenuItem<String>(
                                        value: type,
                                        child: Text(type),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedDuration = value!;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Pilih Durasi Mengangon',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF20A577)),
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
                                              Get.to(
                                                  () => DetailContractScreen());

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

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

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
              child: Image.network(
                'https://via.placeholder.com/80',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),

            // Details Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth * 0.5,
                    child: Text(
                      'Unknown',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Unknown address',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No bio available.',
                    style: const TextStyle(fontSize: 14),
                  ),
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
              children: const [
                Icon(Icons.star, color: Colors.amber, size: 30),
                Icon(Icons.star, color: Colors.amber, size: 30),
                Icon(Icons.star, color: Colors.amber, size: 30),
                Icon(Icons.star, color: Colors.amber, size: 30),
                Icon(Icons.star_border, color: Colors.grey, size: 30),
              ],
            ),
            SizedBox(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff20A577),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Get.to(() => const PengangonDetailScreen());
                },
                child: const Text(
                  'Pilih',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
