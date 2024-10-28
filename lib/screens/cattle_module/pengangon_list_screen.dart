import 'package:flutter/material.dart';
import 'package:heycowmobileapp/screens/cattle_module/pengangon_detail_screen.dart';
import 'package:get/get.dart';


class PengangonListScreen extends StatefulWidget {
  static const routeName = '/beranda';

  const PengangonListScreen({super.key});

  @override
  State<PengangonListScreen> createState() => _PengangonListScreenState();
}

class _PengangonListScreenState extends State<PengangonListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEBED),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 90),
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
                          const SizedBox(height: 55),
                        ],
                      ),
                      Positioned(
                        top: 200,
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
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText:
                                              "Search Cattle Name or Device ID",
                                          hintStyle: TextStyle(
                                            color: Colors.grey, // Text color
                                          ),
                                          border: InputBorder
                                              .none, // Remove the underline border
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.search,
                                      color: Colors.black, // Search icon color
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 0.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "List Peternak ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF20212B),
                                  ),
                                ),
                                // Button
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // List of Cattle
                        CustomCard(),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    'https://via.placeholder.com/80', // Replace with the actual image URL
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),

                // Details Column
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mamat Suramat',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Reksa\'s Farm',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and.',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 16),

                      // Star Rating
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 30),
                    Icon(Icons.star, color: Colors.amber, size: 30),
                    Icon(Icons.star, color: Colors.amber, size: 30),
                    Icon(Icons.star, color: Colors.amber, size: 30),
                    Icon(Icons.star_border, color: Colors.grey, size: 30),
                  ],
                ),
                SizedBox(
                  width: 120, // Memastikan tombol mengisi seluruh lebar
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff20A577),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Rounded corners
                      ),
                    ),
                    onPressed: () {
                      // Aksi tombol kedua
                      Get.to(() =>  const PengangonDetailScreen());
                    },
                    child: const Text(
                      'Pilih',
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            Colors.white, // Mengubah warna teks menjadi putih
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
