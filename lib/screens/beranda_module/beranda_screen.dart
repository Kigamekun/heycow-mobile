// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:heycowmobileapp/controllers/beranda_controller.dart';
import 'package:heycowmobileapp/models/cattle.dart';
import 'package:heycowmobileapp/screens/cattle_module/cattle_detail_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:heycowmobileapp/app/constants_variable.dart';

import 'dart:convert';

class BerandaScreen extends StatefulWidget {
  static const routeName = '/beranda';

  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  final AuthController _authController = Get.find<AuthController>();

  int _selectedIndex = 0; // To keep track of selected index

  int cattleSick = 0;
  int cattleHealthy = 0;
  int cattleDead = 0;
  int iotDevices = 0;
  int pengangon = 0;
  String farm = '';
  int cattleCount = 0;
  List<dynamic> cattle = [];

  List<_SalesData> data = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
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
        farm = datas['farm']['name'];
        cattleCount = datas['cattle_count'];
        cattle = datas['cattle'];

        data = [
          _SalesData('Sakit', cattleDead.toDouble(), const Color(0xffBD1919)),
          _SalesData('Sehat', cattleSick.toDouble(), const Color(0XFFFACC15)),
          _SalesData('Mati', cattleHealthy.toDouble(), const Color(0xFF20A577)),
        ];
      });
    } else {
      // Penanganan error jika ada kesalahan saat fetch data
      print('Failed to load data');
    }
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
                                        'assets/contract.png', 'Contract'),
                                    _buildPngIconButton(
                                        'assets/history.png', 'History'),
                                    _buildPngIconButton(
                                        'assets/request.png', 'Request'),
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
                                      Container(
                                        height: 145,
                                        child:                           SfCircularChart(
                                          series: <CircularSeries<_SalesData,
                                              String>>[
                                            DoughnutSeries<_SalesData, String>(
                                              innerRadius: '75%',
                                              explodeAll: true,
                                              explode: true,
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
                                                PhosphorIconsRegular.ear,
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
                                                    'Ear Tag ',
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
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              for (var ctl in cattle)
                                InkWell(
                                    onTap: () {
                                      // Navigasi ke halaman detail saat card diklik
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CattleDetailScreen(
                                                  cattle: Cattle(
                                            id: ctl['id'],
                                            name: ctl['name'],
                                            breed: ctl['breed'],
                                            status: ctl['status'],
                                            breedId: ctl['breed_id'],
                                            gender: ctl['gender'],
                                            type: ctl['type'],
                                            birthDate: ctl['birth_date'],
                                            birthWeight: ctl['birth_weight'],
                                            birthHeight: ctl['birth_height'],
                                            userId: ctl['user_id'],
                                            iotDeviceId: ctl['iot_devices']['id'] ??
                                                2,
                                            image: ctl['image'],
                                            iotDevice: ctl['iot_devices'] !=
                                                    null
                                                ? IoTDevice(
                                                    id: ctl['iot_devices']['id'],
                                                    serialNumber:
                                                        ctl['iot_devices']
                                                            ['serial_number'],
                                                    status: ctl['iot_devices']
                                                        ['status'],
                                                    installationDate: ctl[
                                                            'iot_devices']
                                                        ['installation_date'],
                                                    qrImage: ctl['iot_devices']
                                                        ['qr_image'],
                                                  )
                                                : null,
                                          )),
                                        ),
                                      );
                                    },
                                    child: CattleCard(
                                      cattleName: ctl['name'] ?? 'Unknown',
                                      iotId: (ctl['iot_devices'] != null &&
                                              ctl['iot_devices']
                                                      ['serial_number'] !=
                                                  null)
                                          ? ctl['iot_devices']['serial_number']
                                          : 'Unknown',
                                      breedAndWeight:
                                          '${ctl['breed'] ?? 'Unknown'} (${ctl['birth_weight'] ?? 'Unknown'} kg)',
                                      lastVaccinate:
                                          ctl['last_vaccinate'] ?? 'Unknown',
                                      status: ctl['status'] ?? 'Unknown',
                                      statusIcon: PhosphorIconsRegular.ear,
                                      healthStatus: (ctl['latest_health_status'] != null &&
                                              ctl['latest_health_status']
                                                      ['status'] !=
                                                  null)
                                          ? ctl['latest_health_status']['status']
                                          : 'Unknown',
                                      temperature: (ctl['latest_health_status'] != null &&
                                              ctl['latest_health_status']
                                                      ['temperature'] !=
                                                  null)
                                          ? ctl['latest_health_status']['temperature']
                                          : 'Unknown',
                                    ))
                            ],
                          ),
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

Widget _buildPngIconButton(String assetPath, String label) {
  return Column(
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
                          color: const Color(0xFF20A577),
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
                      color: const Color(0xFF20A577),
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
