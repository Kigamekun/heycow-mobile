import 'package:flutter/material.dart';
import 'package:heycowmobileapp/models/iot_device.dart';

class IOTScreen extends StatelessWidget {

  IOTScreen({Key? key}) : super(key: key);

  // Data dummy untuk perangkat IoT
  final List<IoTDevice> devices = [
    IoTDevice(
      id: 1,
      serialNumber: "SN12345",
      status: "active",
      installationDate: "",
      qrImage: "https://example.com/qr1.png",
      userId: 101,
      createdAt: "",
      updatedAt: "",
      ssid: "IoTNetwork1",
      password: "password123",
    ),
    IoTDevice(
      id: 2,
      serialNumber: "SN67890",
      status: "inactive",
      installationDate: "",
      qrImage: "https://example.com/qr2.png",
      userId: 102,
      createdAt: "",
      updatedAt: "",
      ssid: "IoTNetwork2",
      password: "password456",
    ),
    IoTDevice(
      id: 3,
      serialNumber: "SN11223",
      status: "active",
      installationDate: "",
      qrImage: "https://example.com/qr3.png",
      userId: 103,
      createdAt: "",
      updatedAt: "",
      ssid: "IoTNetwork3",
      password: "password789",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IoT Devices"),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Serial Number: ${device.serialNumber}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Status: ${device.status}",
                    style: TextStyle(
                      color: device.status == 'active' ? Colors.green : Colors.red,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Installation Date: ",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  // Image.network(
                  //   device.qrImage,
                  //   height: 100,
                  //   width: 100,
                  //   fit: BoxFit.cover,
                  // ),
                  const SizedBox(height: 8),
                  Text(
                    "SSID: ${device.ssid}",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Password: ${device.password}",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
