import 'package:flutter/material.dart';
import 'package:heycowmobileapp/screens/cattle_module/pengangon_detail_screen.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/pengangon_controller.dart';
import 'package:heycowmobileapp/models/pengangon.dart';

class PengangonListScreen extends StatefulWidget {
  static const routeName = '/beranda';
  final int cattleId;

  const PengangonListScreen({super.key, required this.cattleId});

  @override
  State<PengangonListScreen> createState() => _PengangonListScreenState();
}

class _PengangonListScreenState extends State<PengangonListScreen> {
  final PengangonController _pengangonController =
      Get.put(PengangonController());

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pengangonController.fetchPengangonItems();
    searchController.addListener(() {
      _pengangonController.fetchPengangonItems(query: searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Method to fetch cattle items
  void fetchPengangonItems() {
    _pengangonController.fetchPengangonItems();
  }

  // Public method to refresh cattle data
  void refreshData() {
    fetchPengangonItems();
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: searchController,
                                        decoration: const InputDecoration(
                                          hintText:
                                              "Search Pengangon Name",
                                          hintStyle: TextStyle(
                                            color: Colors.grey, // Text color
                                          ),
                                          border: InputBorder
                                              .none, // Remove the underline border
                                        ),
                                      ),
                                    ),
                                    const Icon(
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
                    padding: EdgeInsets.only(left: 10, right: 10, top: 0.0),
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
                    if (_pengangonController.pengangonItems.isEmpty) {
                      return const Center(
                        child: Text('No Pengangon available.'),
                      );
                    }

                    return Column(
                      children: _pengangonController.pengangonItems
                          .map((pengangon) => CustomCard(pengangon: pengangon,cattleId:widget.cattleId))
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
  final int cattleId;

  const CustomCard({super.key,required this.cattleId, required this.pengangon});

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
                      : Container(
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
                      Container(
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
                      color:
                          index < pengangon.rate ? Colors.amber : Colors.grey,
                      size: 30,
                    );
                  }),
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
                      Get.to(() => PengangonDetailScreen(
                        id : pengangon.id,
                        cattleId: cattleId,
                      ));
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
