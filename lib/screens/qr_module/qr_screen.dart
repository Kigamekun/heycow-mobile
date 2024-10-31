import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
        _showDetailBottomSheet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
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
                      _showDetailBottomSheet();
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

  void _showDetailBottomSheet() {
    _isPopupVisible = true;
    controller?.pauseCamera(); // Hentikan kamera sementara saat popup muncul

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Color(0xffEAEBED),
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
                    // const Text(
                    //   'Detail Scan',
                    //   style: TextStyle(
                    //     fontSize: 24,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    // Text(
                    //   'Scanned QR Code Data: ${result!.code}',
                    //   style: const TextStyle(fontSize: 16),
                    // ),
                    CattleCard(
                      cattleName: 'N/A', // Check for null
                      iotId: 'N/A', // Check for null
                      breedAndWeight: '',
                      lastVaccinate: '12',
                      status: "",
                      statusIcon: Icons.check_circle,
                      healthStatus: 'Healthy',
                      temperature: '37',
                      onDelete: () {
                        // Delete function
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      padding: const EdgeInsets.all(20),
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
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Data',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Table(
                            border: TableBorder.all(),
                            columnWidths: const {0: FixedColumnWidth(150)},
                            children: [
                              _buildTableRow('Name', "Cattle 1"),
                              _buildTableRow('Breed', "Cattle 1"),
                              _buildTableRow('Date of Birth', "100"),
                              _buildTableRow('Weight', '100 kg'),
                              _buildTableRow('Height', '48 cm'),
                              _buildTableRow('Gender', "gender"),
                              _buildTableRow('Vaccine', 'Vaccine 1'),
                              _buildTableRow('ID Device', ('N/A')),
                              _buildTableRow('Battery', '87%'),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Health Monitoring',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Table(
                            border: TableBorder.all(),
                            columnWidths: const {0: FixedColumnWidth(150)},
                            children: [
                              _buildTableRow('Body Temperature', "Cattle 1"),
                              _buildTableRow('Activity', "Cattle 1"),
                              _buildTableRow('Date of Birth', "100"),
                            ],
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Tutup bottom sheet
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
      result = null; // Reset hasil scan untuk bisa scan ulang
      controller?.resumeCamera(); // Lanjutkan kamera setelah popup ditutup
    });
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
                              : Color(0xFF20A577),
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
                      color: iotId == 'N/A' ? Colors.red : Color(0xFF20A577),
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
