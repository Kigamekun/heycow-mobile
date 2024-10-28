// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:heycowmobileapp/controllers/beranda_controller.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BerandaScreen extends StatefulWidget {
  static const routeName = '/beranda';

  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  final AuthController _authController = Get.find<AuthController>();

  final BerandaController berandaController = Get.find<BerandaController>();

  final TextEditingController _searchController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late CameraPosition _kGooglePlex;

  int _selectedIndex = 0; // To keep track of selected index

  List<_SalesData> data = [
    _SalesData('Jan', 20, const Color(0xffBD1919)),
    _SalesData('Mar', 40, const Color(0XFFFACC15)),
    _SalesData('Apr', 40, const Color(0xFF20A577)),
  ];

  void redirectToMapApp(double latitude, double longitude) async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void setCameraPosition() {}

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double
                                    .infinity, // Membuat tombol full width
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffBD1919),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Rounded corners
                                    ),
                                  ),
                                  onPressed: () {
                                    // Implement Upgrade Action
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text(
                                      'There are 3 cattle sick, check them now!',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors
                                            .white, // Mengubah warna teks menjadi putih
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    // Expanded pertama dengan flex 5
                                    Expanded(
                                      flex: 5,
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
                                                // Aksi tombol pertama
                                              },
                                              child: const Text(
                                                'Basic Plan Until 30-06-2024',
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
                                      flex: 3,
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
                                                'Upgrade',
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
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
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
                                      Center(
                                          //Initialize the chart widget
                                          child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5.0,
                                                    color: Colors.grey
                                                        .withAlpha(60),
                                                    spreadRadius: 5.0,
                                                    offset:
                                                        const Offset(0.0, 3.0))
                                              ],
                                              gradient: const RadialGradient(
                                                  stops: <double>[
                                                    0.9,
                                                    0.2,
                                                    0.2
                                                  ],
                                                  colors: <Color>[
                                                    Color.fromARGB(
                                                        255, 254, 255, 254),
                                                    Color.fromARGB(
                                                        255, 235, 242, 249),
                                                    Color.fromARGB(
                                                        255, 215, 223, 232),
                                                  ],
                                                  radius: 0.5,
                                                  center: Alignment.center),
                                              shape: BoxShape.circle,
                                            ),
                                            child: SfCircularChart(
                                                annotations: <CircularChartAnnotation>[
                                                  CircularChartAnnotation(
                                                    widget: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 50),
                                                      child: Container(
                                                          width: 150,
                                                          child: const Column(
                                                              children: <Widget>[
                                                                Text('23%',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            22,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ])),
                                                    ),
                                                    angle: 90,
                                                    horizontalAlignment:
                                                        ChartAlignment.center,
                                                  ),
                                                ],
                                                series: <CircularSeries<
                                                    _SalesData, String>>[
                                                  DoughnutSeries<_SalesData,
                                                      String>(
                                                    innerRadius: '70%',
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
                                                  )
                                                ])),
                                      )),
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
                                      child: const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              PhosphorIcon(
                                                PhosphorIconsRegular.ear,
                                                size: 45.0,
                                                semanticLabel: 'New Note',
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '54',
                                                    style: TextStyle(
                                                      color: Color(0xff20212B),
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
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
                                      child: const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              PhosphorIcon(
                                                PhosphorIconsRegular.user,
                                                size: 45.0,
                                                semanticLabel: 'New Note',
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '54',
                                                    style: TextStyle(
                                                      color: Color(0xff20212B),
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
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
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              for (int i = 1; i <= 3; i++)
                                CattleCard(
                                  cattleName: 'Cattle $i',
                                  iotId: 'IoT ID $i',
                                  breedAndWeight: 'Breed $i, 100kg',
                                  lastVaccinate: 'Last Vaccinate $i',
                                  status: 'Sick',
                                  statusIcon: PhosphorIconsRegular.ear,
                                  healthStatus: 'Healthy',
                                  temperature: '37',
                                ),
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
          // Floating Bottom Navigation Bar
        ],
      ),
    );
  }
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
      padding: const EdgeInsets.only(bottom:20.0),
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
                        width: 150, // Set the maximum width for the text
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
                    child: const Icon(Icons.hearing_rounded, color: Colors.white),
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
                      const Icon(Icons.thermostat_outlined, color: Colors.black),
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
