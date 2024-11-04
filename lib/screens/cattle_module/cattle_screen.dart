import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/cattle_controller.dart'; // Import your controller
import 'package:heycowmobileapp/screens/cattle_module/add_cattle_screen.dart';
import 'package:heycowmobileapp/screens/cattle_module/cattle_detail_screen.dart';

class CattleScreen extends StatefulWidget {
  static const routeName = '/beranda';

  const CattleScreen({Key? key}) : super(key: key);
  @override
  CattleScreenState createState() => CattleScreenState();
}

class CattleScreenState extends State<CattleScreen> {
  //
  final CattleController cattleController = Get.put(CattleController());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCattleItems(); // Fetch initial data
    searchController.addListener(() {
      cattleController.fetchCattleItems(query: searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Method to fetch cattle items
  void fetchCattleItems() {
    cattleController.fetchCattleItems();
  }

  // Public method to refresh cattle data
  void refreshData() {
    fetchCattleItems();
  }

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
                                              "Search Cattle Name or Device ID",
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 0.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Cattle",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF20212B),
                                  ),
                                ),
                                // Button
                                ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => const AddCattleScreen());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF20A577),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.add, color: Colors.white),
                                      SizedBox(width: 8),
                                      Text('Tambah Cattle',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Obx(() {
                          if (cattleController.cattleItems.isEmpty) {
                            return const Center(
                              child: Text('No cattle available.'),
                            );
                          }
                          return Column(
                            children:
                                cattleController.cattleItems.map((cattle) {
                              return InkWell(
                                onTap: () {
                                  // Navigasi ke halaman detail saat card diklik
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CattleDetailScreen(cattle: cattle),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    CattleCard(
                                      cattleName: cattle.name ??
                                          'N/A', // Check for null
                                      iotId: cattle.iotDevice?.serialNumber ??
                                          'N/A', // Check for null
                                      breedAndWeight:
                                          '${cattle.breed} (${cattle.birthWeight} kg)',
                                      lastVaccinate: '12',
                                      status: cattle.status,
                                      statusIcon: Icons.check_circle,
                                      healthStatus: 'Healthy',
                                      temperature: '37',
                                      onDelete: () {
                                        // Delete function
                                        cattleController
                                            .deleteCattle(cattle.id as int);
                                      },
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        }),
                        const SizedBox(height: 100),
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

class CattleCard extends StatelessWidget {
  final String cattleName;
  final String iotId;
  final String breedAndWeight;
  final String lastVaccinate;
  final String status;
  final IconData statusIcon;
  final String healthStatus;
  final String temperature;
  final VoidCallback onDelete; // Callback to handle delete action

  const CattleCard({
    super.key,
    required this.cattleName,
    required this.iotId,
    required this.breedAndWeight,
    required this.lastVaccinate,
    required this.status,
    required this.statusIcon,
    required this.healthStatus,
    required this.temperature,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(iotId),
      direction: DismissDirection.endToStart,
      background: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.red,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm Delete"),
              content:
                  const Text("Are you sure you want to delete this cattle?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Confirm deletion
                  },
                  child: const Text("Delete"),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        onDelete(); // Call the delete function
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          cattleName,
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
                          color: status == 'mati'
                              ? Colors.grey // Warna untuk status mati
                              : status == 'sakit'
                                  ? Colors.red // Warna untuk status sakit
                                  : status == 'dijual'
                                      ? Colors
                                          .yellow // Warna untuk status dijual
                                      : const Color(
                                          0xFF20A577), // Warna untuk status sehat
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          status,
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
                      color:
                          iotId == 'N/A' ? Colors.red : const Color(0xFF20A577),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child:
                        const Icon(Icons.hearing_rounded, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'IoT ID : $iotId',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                breedAndWeight,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'Last Vaccinate : $lastVaccinate',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.monitor_heart_outlined,
                          color: Colors.black),
                      const SizedBox(width: 4),
                      Text(healthStatus),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      const Icon(Icons.thermostat_outlined,
                          color: Colors.black),
                      const SizedBox(width: 4),
                      Text('$temperature°C'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
