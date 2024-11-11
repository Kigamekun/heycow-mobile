// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:heycowmobileapp/controllers/cattle_controller.dart';
import 'package:heycowmobileapp/screens/cattle_module/cattle_detail_screen.dart';
import 'package:heycowmobileapp/screens/history_module/history_screen.dart';
import 'package:heycowmobileapp/screens/request_module/request_screen.dart';
import 'package:heycowmobileapp/screens/user_module/notification_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:heycowmobileapp/app/constants_variable.dart';
import 'package:heycowmobileapp/screens/contract_module/contract_screen.dart';

import 'dart:convert';

class BerandaScreen extends StatefulWidget {
  static const routeName = '/beranda';

  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final CattleController cattleController = Get.put(CattleController());

  final int _selectedIndex = 0; // To keep track of selected index

  int cattleSick = 0;
  int cattleHealthy = 0;
  int cattleDead = 0;
  int iotDevices = 0;
  int pengangon = 0;
  String farm = '';
  int cattleCount = 0;
  List<dynamic> cattle = [];

  List<_SalesData> data = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
    fetchCattleItems();
  }

  // Method to fetch cattle items
  void fetchCattleItems() {
    cattleController.fetchCattleItems();
  }

  // Method untuk mengambil data dari API
  Future<void> fetchDataFromApi() async {
    final response = await http
        .get(Uri.parse(AppConstants.dashboardUrl), headers: <String, String>{
      'Authorization': 'Bearer ${_authController.accessToken}',
    });
    if (response.statusCode == 200) {
      final datas = json.decode(response.body);
      setState(() {
        cattleSick = datas['cattle_sick'];
        cattleHealthy = datas['cattle_healthy'];
        cattleDead = datas['cattle_dead'];
        iotDevices = datas['iot_devices'];
        pengangon = datas['pengangon'];
        farm = datas['farm'] == null ? '' : datas['farm']['name'];
        cattleCount = datas['cattle_count'];
        cattle = datas['cattle'];

        data = [
          _SalesData('Sakit', cattleDead.toDouble(), const Color(0xffBD1919)),
          _SalesData('Sehat', cattleSick.toDouble(), const Color(0XFFFACC15)),
          _SalesData('Mati', cattleHealthy.toDouble(), const Color(0xFF20A577)),
        ];
      });
    } else {}
  }

  @override
  void dispose() {
    super.dispose();
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
                          const SizedBox(height: 95),
                        ],
                      ),

                      // button notif with number

                      Positioned(
                        top: 30,
                        right: 16,
                        child: IconButton(
                          icon: Stack(
                            children: <Widget>[
                              const Icon(Icons.notifications, size: 30),
                              Positioned(
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 12,
                                    minHeight: 12,
                                  ),
                                  child: const Text(
                                    '3', // Angka notifikasi
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            Get.to(() => const NotificationScreen());
                            // Aksi ketika tombol notifikasi ditekan
                          },
                        ),
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
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Text(
                                        'Alert',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Ada $cattleSick sapi yang sakit',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: Colors.red,
                                      size: 30,
                                    )
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey[300],
                                  thickness: 1,
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildPngIconButton(
                                      context,
                                      'assets/contract.png',
                                      'Contract',
                                      const ContractScreen(),
                                    ),

                                    // History Button
                                    _buildPngIconButton(
                                      context,
                                      'assets/history.png',
                                      'History',
                                      const HistoryScreen(), // Replace with the screen for "History"
                                    ),

                                    // Request Button
                                    _buildPngIconButton(
                                      context,
                                      'assets/request.png',
                                      'Request',
                                      const RequestScreen(), // Replace with the screen for "Request"
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              "${_authController.nama.value.split(' ')[0]}'s Farm",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF20212B),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 180,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Cattle Status',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 145,
                                        child: SfCircularChart(
                                          series: <CircularSeries<_SalesData,
                                              String>>[
                                            DoughnutSeries<_SalesData, String>(
                                              innerRadius: '75%',
                                              explodeAll: true,
                                              explode: false,
                                              dataSource: data,
                                              xValueMapper:
                                                  (_SalesData sales, _) =>
                                                      sales.year,
                                              yValueMapper:
                                                  (_SalesData sales, _) =>
                                                      sales.sales,
                                              pointColorMapper:
                                                  (_SalesData sales, _) =>
                                                      sales.color,
                                              name: 'Sales',
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          DotWithText(
                                              color: Colors.red, text: 'Mati'),
                                          SizedBox(width: 10),
                                          DotWithText(
                                              color: Colors.yellow,
                                              text: 'Sakit'),
                                          SizedBox(width: 10),
                                          DotWithText(
                                              color: Colors.green,
                                              text: 'Sehat'),
                                        ],
                                      )
                                    ],
                                  )),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const PhosphorIcon(
                                                PhosphorIconsRegular.lasso,
                                                size: 45.0,
                                                semanticLabel: 'New Note',
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    iotDevices.toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xff20212B),
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Text(
                                                    'Necklace ',
                                                    style: TextStyle(
                                                      color: Color(0xff20212B),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const PhosphorIcon(
                                                PhosphorIconsRegular.user,
                                                size: 45.0,
                                                semanticLabel: 'New Note',
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    pengangon.toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xff20212B),
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Text(
                                                    'Pengangon',
                                                    style: TextStyle(
                                                      color: Color(0xff20212B),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Cattle",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF20212B),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(() {
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
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }),
                        ),
                        const SizedBox(height: 20),
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

// Widget _buildPngIconButton(String assetPath, String label) {
//   return Column(
//     children: [
//       Image.asset(
//         assetPath,
//         width: 20,
//         height: 20,
//       ),
//       const SizedBox(height: 8),
//       Text(
//         label,
//         style: const TextStyle(
//           fontSize: 12,
//           color: Colors.black,
//         ),
//       ),
//     ],
//   );
// }

Widget _buildPngIconButton(BuildContext context, String assetPath, String label,
    Widget destinationScreen) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destinationScreen),
      );
    },
    child: Column(
      children: [
        Image.asset(
          assetPath,
          width: 20,
          height: 20,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

class _SalesData {
  _SalesData(this.year, this.sales, this.color);

  final String year;
  final double sales;
  final Color color;
}

class DotWithText extends StatelessWidget {
  final Color color;
  final String text;

  const DotWithText({required this.color, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Titik kecil
        Container(
          width: 10, // Lebar titik
          height: 10, // Tinggi titik
          decoration: BoxDecoration(
            color: color, // Warna titik
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4), // Jarak antara titik dan teks
        // Teks di sebelah titik
        Text(
          text,
          style: const TextStyle(fontSize: 11),
        ),
      ],
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
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
                        width: 80, // Set the maximum width for the text
                        child: Text(
                          cattleName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // This adds "..." at the end if text overflows
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
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
                      )
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
