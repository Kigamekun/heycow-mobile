import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:get/get.dart';

class QRScreen extends StatefulWidget {
  static const routeName = '/beranda';

  const QRScreen({super.key});

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool _isPopupVisible = false;

  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (!_isPopupVisible &&
          (result == null || result!.code != scanData.code)) {
        setState(() {
          result = scanData;
        });
        _showDetailBottomSheet(scanData.code as String);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Set tombol back menjadi putih
        ),
        title: const Text('Scan Cattle',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF20A577), // Start color
                Color(0xFF64CFAA), // End color
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.green,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: result != null
                ? GestureDetector(
                    onTap: () {
                      if (result?.code != null) {
                        _showDetailBottomSheet(result!.code!);
                      }
                    },
                    child: Container())
                : Container(
                    color: Colors.grey,
                    child: const Center(
                      child: Text(
                        'Scan a code',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDetailBottomSheet(String qrCode) async {
    _isPopupVisible = true;
    controller?.pauseCamera(); // Pause the camera while the popup is visible

    // Fetch data from API using the QR code
    final response = await http.get(
        Uri.parse('https://heycow.my.id/api/cattle/iot-devices/$qrCode'),
        headers: <String, String>{
          'Authorization': 'Bearer ${_authController.accessToken}',
        });

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the data
      var data = json.decode(response.body);

      // Example data extraction from the response
      var cattleData = data['data'];
      String cattleName = cattleData['name'];
      String iotId = cattleData['iot_device']['serial_number'];
      String breedAndWeight =
          "${cattleData['breed']['name']} - ${cattleData['birth_weight']} kg";
      String healthStatus = cattleData['status'];
// You can set it based on your data

      // Show the bottom sheet with the fetched data
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        backgroundColor: const Color(0xffEAEBED),
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CattleCard(
                        cattleName: cattleName,
                        iotId: iotId,
                        breedAndWeight: breedAndWeight,
                        lastVaccinate: 'N/A', // Update as necessary
                        status: healthStatus,
                        statusIcon: Icons.check_circle,
                        healthStatus: cattleData['healthRecords']?['status'],
                        temperature: cattleData['healthRecords']?['temperature'],
                        onDelete: () {
                          // Handle delete action
                        },
                      ),
                      const SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 3, left: 3, top: 0.0),
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
                                              // Aksi tombol kedua
                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
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
                                          'Name', cattleData['name'] as String),
                                      _buildTableRow(
                                          'Breed',
                                          cattleData['breed']['name']
                                              as String),
                                      _buildTableRow('Date of Birth',
                                          cattleData['birth_date'] as String),
                                      _buildTableRow('Weight',
                                          '${cattleData['birth_weight']} kg'),
                                      _buildTableRow('Height',
                                          '${cattleData['birth_height']} cm'),
                                      _buildTableRow('Gender',
                                          cattleData['gender'] as String),
                                      _buildTableRow(
                                          'ID Device',
                                          (cattleData['iot_device']
                                                      ?['serial_number']
                                                  .toString() ??
                                              'N/A')),
                                    ],
                                  ),
                                  const SizedBox(height: 25.0),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween, // Center the buttons
                                    children: [
                                      Text(
                                        'Health Monitoring',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
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
                                          '${cattleData['healthRecords']?['temperature']} °C'),
                                      _buildTableRow('Status', '${cattleData['healthRecords']?['status']}'),
                                    ],
                                  ),

                                  const SizedBox(height: 100.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close bottom sheet
                        },
                        child: const Text('Kembali'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ).whenComplete(() {
        _isPopupVisible = false;
        result = null; // Reset scan result for a new scan
        controller?.resumeCamera(); // Resume the camera
      });
    } else {
      // Handle error if the request fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data: ${response.statusCode}')),
      );
    }
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
                          color: status == 'sakit'
                              ? Colors.red
                              : const Color(0xFF20A577),
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
