import 'package:flutter/material.dart';
import 'package:heycowmobileapp/controllers/cattle_controller.dart';
import 'package:heycowmobileapp/models/cattle.dart';
import 'package:heycowmobileapp/screens/cattle_module/assign_device_screen.dart';
import 'package:heycowmobileapp/screens/cattle_module/edit_cattle_screen.dart';
import 'package:heycowmobileapp/screens/cattle_module/health_monitoring_screen.dart';
import 'package:heycowmobileapp/screens/cattle_module/pengangon_list_screen.dart'; // Import your controller
import 'package:get/get.dart';
import 'package:heycowmobileapp/screens/community_module/community_create_sell_screen.dart';

class CattleDetailScreen extends StatefulWidget {
  final Cattle cattle;

  const CattleDetailScreen({super.key, required this.cattle});

  @override
  // ignore: library_private_types_in_public_api
  _CattleDetailScreenState createState() => _CattleDetailScreenState();
}

class _CattleDetailScreenState extends State<CattleDetailScreen> {
  late Cattle _cattle;

  @override
  void initState() {
    super.initState();
    _cattle = widget.cattle;
    _fetchCattleDetails();
  }

  Future<void> _fetchCattleDetails() async {
    try {
      final updatedCattle = await CattleController().getCattleById(_cattle.id!);
      setState(() {
        _cattle = updatedCattle as Cattle;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _refreshCurrentScreen() async {
    // Simulate a network call or any other asynchronous operation
    await Future.delayed(const Duration(seconds: 1));
    _fetchCattleDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEBED),
      body: RefreshIndicator(
        onRefresh: _refreshCurrentScreen,
        child: Stack(
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
                                                _cattle.name ?? 'N/A',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                color: _cattle.status == 'sakit'
                                                    ? Colors.red
                                                    : const Color(0xFF20A577),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                _cattle.status,
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
                                            color: _cattle.iotDeviceId == null
                                                ? Colors.red
                                                : const Color(0xFF20A577),
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
                                          child: const Icon(
                                              Icons.hearing_rounded,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'IoT ID : ${_cattle.iotDevice?.serialNumber.toString() ?? 'N/A'}',
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
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      15), // Rounded corners
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditCattleScreen(
                                                        cattle: _cattle),
                                              ),
                                            );
                                            // Aksi tombol kedua
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff20A577),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      15), // Rounded corners
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (_cattle.iotDeviceId == null) {
                                              final isSuccess =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AssignDeviceScreen(
                                                          cattle: _cattle),
                                                ),
                                              );
                                              if (isSuccess == true) {
                                                // Fetch updated cattle details if the assignment was successful
                                                _fetchCattleDetails();
                                              }
                                            } else {
                                              CattleController()
                                                  .removeIotDevice(_cattle.id!);
                                              _fetchCattleDetails(); // Ensure the cattle details are updated
                                            }
                                          },
                                          child: Text(
                                            _cattle.iotDeviceId == null
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
                                  columnWidths: const {
                                    0: FixedColumnWidth(150)
                                  },
                                  children: [
                                    _buildTableRow(
                                        'Name', _cattle.name as String),
                                    _buildTableRow(
                                        'Breed', _cattle.breed as String),
                                    _buildTableRow('Date of Birth',
                                        _cattle.birthDate as String),
                                    _buildTableRow(
                                        'Weight', '${_cattle.birthWeight} kg'),
                                    _buildTableRow(
                                        'Height', '${_cattle.birthHeight} cm'),
                                    _buildTableRow(
                                        'Gender', _cattle.gender as String),
                                    _buildTableRow(
                                        'ID Device',
                                        (_cattle.iotDevice?.serialNumber
                                                .toString() ??
                                            'N/A')),
                                  ],
                                ),
                                const SizedBox(height: 25.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // Center the buttons
                                  children: [
                                    const Text(
                                      'Health Monitoring',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
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
                                        Get.to(() =>
                                            const HealthMonitoringScreen());
                                        // Aksi tombol kedua
                                      },
                                      child: const Text("Detail",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors
                                                .white, // Mengubah warna teks menjadi putih
                                          )),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 25.0),
                                Table(
                                  border: TableBorder.all(),
                                  columnWidths: const {
                                    0: FixedColumnWidth(150)
                                  },
                                  children: [
                                    _buildTableRow('Temperature',
                                        '${_cattle.temperature} °C'),
                                    _buildTableRow(
                                        'Status', '${_cattle.healthStatus}'),
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
                                                backgroundColor: _cattle
                                                            .diAngon ==
                                                        true
                                                    ? Colors
                                                        .grey // Warna abu-abu jika disabled
                                                    : const Color(
                                                        0xffFACC15), // Warna biasa jika tidak disabled
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5), // Rounded corners
                                                ),
                                              ),
                                              onPressed: _cattle.diAngon == true
                                                  ? null // Jika diAngon true, tombol tidak bisa ditekan
                                                  : () {
                                                      Get.to(() =>
                                                          PengangonListScreen(
                                                              cattleId:
                                                                  _cattle.id!));
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
                                                Get.to(() =>
                                                    CommunityCreateSellScreen(
                                                        id: _cattle.id!));
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
