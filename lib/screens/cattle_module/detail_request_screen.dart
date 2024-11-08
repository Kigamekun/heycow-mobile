import 'package:flutter/material.dart';
import 'package:heycowmobileapp/models/cattle.dart';
import 'package:heycowmobileapp/screens/cattle_module/detail_contract_screen.dart';
import 'package:heycowmobileapp/screens/cattle_module/pengangon_list_screen.dart'; // Import your controller
import 'package:get/get.dart';
import 'package:heycowmobileapp/screens/beranda_module/beranda_screen.dart';
import 'package:heycowmobileapp/screens/cattle_module/snap_screen.dart';
import 'package:heycowmobileapp/screens/main_screen.dart'; // Import MainScreen

class DetailRequestScreen extends StatelessWidget {
  const DetailRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to MainScreen and prevent back navigation
        Get.offAll(() => MainScreen());
        return false; // Prevent the default back action
      },
      child: Scaffold(
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
                            SizedBox(height: MediaQuery.of(context).size.height * 0.7)
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
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.all(0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.access_time,
                                              color: Colors.yellow[700],
                                              size: 50),
                                          const SizedBox(height: 10),
                                          const Text(
                                            "Dalam Proses Konfirmasi",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 50),
                                          // Details Section
                                          _buildDetailsRow(
                                              "Nama Pengangon", "Mamat Suramat"),
                                          _buildDetailsRow(
                                              "Nama Sapi", "Catle 1"),
                                          _buildDetailsRow(
                                              "Durasi Mengangon", "28-11-2024"),
                                          _buildDetailsRow("Biaya", "Rp 500.000"),
                                          const SizedBox(height: 20),
                                          const Divider(),
                                          // Activity Section
                                          const SizedBox(height: 20),
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Aktivitas",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          _buildActivityItem(
                                            icon: Icons.check_circle,
                                            color: Colors.green,
                                            title: "Data Diterima",
                                            dateTime: "28 Oktober 2024 • 09:11",
                                          ),
                                          _buildActivityItem(
                                            icon: Icons.access_time,
                                            color: Colors.yellow[700]!,
                                            title: "Menunggu Konfirmasi",
                                            dateTime: "28 Oktober 2024 • 09:11",
                                          ),
                                          const SizedBox(height: 20),
                                          // Close Button
                                          SizedBox(
                                            width: double.infinity, // Ensure button fills the width
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xff20A577),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13), // Rounded corners
                                                ),
                                              ),
                                              onPressed: () {
                                               Get.offAll(() => MainScreen()); // Navigate to MainScreen
                                              },
                                              child: const Text(
                                                'Tutup',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors
                                                      .white, // Change text color to white
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Floating Bottom Navigation Bar
          ],
        ),
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

  Widget _buildDetailsRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color color,
    required String title,
    required String dateTime,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        dateTime,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }
}
