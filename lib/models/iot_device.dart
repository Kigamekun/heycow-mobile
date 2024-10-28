class IoTDevice {
  final int id;
  final String serialNumber;
  final String status;
  final String installationDate;
  final String? qrImage;
  final String createdAt;
  final String updatedAt;

  IoTDevice({
    required this.id,
    required this.serialNumber,
    required this.status,
    required this.installationDate,
    this.qrImage,
    required this.createdAt,
    required this.updatedAt,
  });
}
