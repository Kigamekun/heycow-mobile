class Cattle {
  final int? id;
  final String? name;
  final String? breed;
  final bool? diAngon;
  final String status;
  final String? type;
  final String? gender;
  final String? birthDate;
  final int? birthWeight;
  final int? birthHeight;
  final int? farmId;
  final int? userId;
  final String? farmName;
  final int? iotDeviceId;
  final String? image;
  final IoTDevice? iotDevice;
  final int? breedId; // Added breedId field
  final String? temperature;
  final String? healthStatus;

  Cattle({
    this.id,
    this.name,
    this.breed,
    this.diAngon,
    required this.status,
    this.type,
    this.gender,
    this.birthDate,
    this.birthWeight,
    this.farmName,
    this.birthHeight,
    this.farmId,
    this.userId,
    this.iotDeviceId,
    this.image,
    this.iotDevice,
    this.breedId,
    this.temperature,
    this.healthStatus,
  });
}

class IoTDevice {
  final int id;
  final String serialNumber;
  final String status;
  final String installationDate;
  final String? qrImage;

  IoTDevice({
    required this.id,
    required this.serialNumber,
    required this.status,
    required this.installationDate,
    this.qrImage,
  });
}
