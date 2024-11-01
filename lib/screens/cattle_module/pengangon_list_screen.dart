import 'package:flutter/material.dart';
import 'package:heycowmobileapp/screens/cattle_module/pengangon_detail_screen.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/pengangon_controller.dart';
import 'package:heycowmobileapp/models/pengangon.dart';
class PengangonListScreen extends StatefulWidget {
  static const routeName = '/beranda';

  const PengangonListScreen({super.key});

  @override
  State<PengangonListScreen> createState() => _PengangonListScreenState();
}

class _PengangonListScreenState extends State<PengangonListScreen> {
  final PengangonController _pengangonController = Get.put(PengangonController());

  @override
  void initState() {
    super.initState();
    _pengangonController.fetchPengangonItems();
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
                                  Color(0xff20A577),
                                  Color(0xff64CFAA),
                                ],
                                stops: [0.1, 0.5],
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            height: 250,
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
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.search,
                                      color: Colors.black,
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
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "List Peternak ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF20212B),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    return Column(
                      children: _pengangonController.pengangonItems
                          .map((pengangon) => CustomCard(pengangon: pengangon))
                          .toList(),
                    );
                  }),
                  const SizedBox(height: 100),
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
  final Pengangon pengangon;

  const CustomCard({super.key, required this.pengangon});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

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
                // Avatar Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: pengangon.avatar != null
                      ? Image.network(
                          pengangon.avatar!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
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
                          pengangon.name ?? 'Unknown',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pengangon.address ?? 'Unknown address',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pengangon.bio ?? 'No bio available.',
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
        ),
      ),
    );
  }
}