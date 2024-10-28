import 'package:flutter/material.dart';
import 'package:heycowmobileapp/controllers/cattle_controller.dart';
import 'package:heycowmobileapp/models/cattle.dart';
import 'package:heycowmobileapp/screens/cattle_module/assign_device_screen.dart';
import 'package:heycowmobileapp/screens/cattle_module/edit_cattle_screen.dart';
import 'package:heycowmobileapp/screens/cattle_module/pengangon_list_screen.dart'; // Import your controller
import 'package:get/get.dart';

class CattleDetailScreen extends StatelessWidget {
  final Cattle cattle;

  const CattleDetailScreen({super.key, required this.cattle});

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
                        top: 180,
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
                              // Text(
                              //   'Information',
                              //   style: TextStyle(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              // SizedBox(height: 100),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              cattle.name ?? 'N/A',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: cattle.status == 'sakit'
                                                  ? Colors.red
                                                  : Color(0xFF20A577),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              cattle.status,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: cattle.iotDeviceId == null
                                              ? Colors.red
                                              : Color(0xFF20A577),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x1A000000),
                                              blurRadius: 10,
                                              offset: Offset(0, 4),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                        child: const Icon(Icons.hearing_rounded,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'IoT ID : ' +
                                        (cattle.iotDeviceId?.toString() ??
                                            'N/A'),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 0.0),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Data',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Button
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff20A577),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15), // Rounded corners
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditCattleScreen(
                                                      cattle: cattle),
                                            ),
                                          );
                                          // Aksi tombol kedua
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff20A577),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15), // Rounded corners
                                          ),
                                        ),
                                        onPressed: () {
                                          if (cattle.iotDeviceId == null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AssignDeviceScreen(
                                                        cattle: cattle),
                                              ),
                                            );
                                          } else {
                                            CattleController()
                                                .removeIotDevice(cattle.id!);
                                          }
                                        },
                                        child: Text(
                                          cattle.iotDeviceId == null
                                              ? 'Pasang Alat'
                                              : 'Lepas Alat',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors
                                                .white, // Mengubah warna teks menjadi putih
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 25.0),
                              // Table for cattle data
                              Table(
                                border: TableBorder.all(),
                                columnWidths: const {0: FixedColumnWidth(150)},
                                children: [
                                  _buildTableRow('Name', cattle.name as String),
                                  _buildTableRow(
                                      'Breed', cattle.breed as String),
                                  _buildTableRow('Date of Birth',
                                      cattle.birthDate as String),
                                  _buildTableRow('Weight',
                                      cattle.birthWeight.toString() + ' kg'),
                                  _buildTableRow('Height',
                                      cattle.birthHeight.toString() + ' cm'),
                                  _buildTableRow(
                                      'Gender', cattle.gender as String),
                                  _buildTableRow('Vaccine', 'Vaccine 1'),
                                  _buildTableRow('ID Device',
                                      cattle.iotDeviceId?.toString() ?? 'N/A'),
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
                                  _buildTableRow('Temperature', '22°C'),
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
                                              'Jual',
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
