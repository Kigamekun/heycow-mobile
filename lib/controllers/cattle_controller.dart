import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:heycowmobileapp/app/constants_variable.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:heycowmobileapp/models/cattle.dart';
import 'package:heycowmobileapp/models/breed.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';

class CattleController extends GetxController {
  final List<Cattle> cattleItems = <Cattle>[].obs;
  final List<Breed> breedItems = <Breed>[].obs;

  final AuthController _authController = Get.find<AuthController>();

  Future<void> fetchCattleItems({String? query}) async {
    try {
      final url = Uri.parse(AppConstants.cattleUrl).replace(
        queryParameters: {
          'search': query ?? '',
        },
      );
      final response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer ${_authController.accessToken}',
        },
      );
      if (response.statusCode == 200) {
        log('ada disini');
        final jsonResponse = jsonDecode(response.body);
        log('Response JSON: $jsonResponse');
        final jsonData = jsonResponse['data'];
        if (jsonData == null || jsonData.isEmpty) {
          log('No cattle items found or jsonData is empty.');
          cattleItems.assignAll([]); // Assign an empty list to cattleItems
          return;
        } else if (jsonData is! List) {
          log('Error: Expected jsonData to be a list but got ${jsonData.runtimeType}');
          return;
        }
        final List<Cattle> items = jsonData.map<Cattle>((item) {
          return Cattle(
            id: item['id'],
            name: item['name'],
            breed: item['breed'] != null ? item['breed']['name'] : null,
            status: item['status'],
            breedId: item['breed']['id'],
            gender: item['gender'],
            type: item['type'],
            birthDate: item['birth_date'],
            birthWeight: item['birth_weight'],
            birthHeight: item['birth_height'],
            farmId: item['farm'] != null ? item['farm']['id'] : null,
            userId: item['farm'] != null ? item['farm']['user_id'] : null,
            iotDeviceId: item['iot_device_id'],
            image: item['image'],
            temperature: item['first_health_record'] != null
                ? item['first_health_record']['temperature']
                : null,
            healthStatus: item['first_health_record'] != null
                ? item['first_health_record']['status']
                : null,
            iotDevice: item['iot_device'] != null
                ? IoTDevice(
                    id: item['iot_device']['id'],
                    serialNumber: item['iot_device']['serial_number'],
                    status: item['iot_device']['status'],
                    installationDate: item['iot_device']['installation_date'],
                    qrImage: item['iot_device']['qr_image'],
                  )
                : null,
          );
        }).toList();
        cattleItems.assignAll(items);
        log('Cattle Items fetched successfully: $cattleItems');
      } else {
        log('Failed to load cattle items. Status code: ${response.statusCode}');
        cattleItems.assignAll([]);
      }
    } catch (e) {
      log('Error fetching cattle items: $e');
      cattleItems.assignAll([]);
    }
  }

  Future<Cattle?> fetchCattleDetail(int id) async {
    try {
      final response =
          await http.get(Uri.parse('${AppConstants.cattleUrl}/$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body)['data'];
        Cattle cattleItem = Cattle(
          id: jsonData['id'],
          name: jsonData['name'],
          breed: jsonData['breed'],
          status: jsonData['status'],
          gender: jsonData['gender'],
          birthDate: jsonData['birth_date'],
          birthWeight: jsonData['birth_weight'],
          birthHeight: jsonData['birth_height'],
          farmId: jsonData['farm_id'],
          userId: jsonData['user_id'],
          iotDeviceId: jsonData['iot_device_id'],
          image: jsonData['image'],
          temperature: jsonData['healthRecords'] != null
              ? jsonData['healthRecords']['temperature']
              : null,
          healthStatus: jsonData['healthRecords'] != null
              ? jsonData['healthRecords']['status']
              : null,
          iotDevice: jsonData['iot_device'] != null
              ? IoTDevice(
                  id: jsonData['iot_device']['id'],
                  serialNumber: jsonData['iot_device']['serial_number'],
                  status: jsonData['iot_device']['status'],
                  installationDate: jsonData['iot_device']['installation_date'],
                  qrImage: jsonData['iot_device']['qr_image'],
                )
              : null,
        );
        log('Cattle detail fetched successfully: $cattleItem');
        return cattleItem;
      } else {
        log('Failed to load cattle detail. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching cattle detail: $e');
    }
    return null;
  }

  // Add or update cattle information
  Future<void> saveCattle(Cattle cattle) async {
    log("MASUK SINI DL HRSNYA");
    try {
      final response = await http.post(
        Uri.parse(AppConstants.cattleUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authController.accessToken}',
        },
        body: jsonEncode({
          "name": cattle.name,
          "status": cattle.status,
          "birth_date": cattle.birthDate,
          "birth_weight": cattle.birthWeight,
          "birth_height": cattle.birthHeight,
          "breed_id": cattle.breedId,
          "gender": cattle.gender,
          "type": cattle.type,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Cattle saved successfully');
        fetchCattleItems(); // Refresh cattle list after saving
      } else {
        log('Failed to save cattle. Status code: ${response.body}');
      }
    } catch (e) {
      log('Error saving cattle: $e');
    }
  }

  Future<void> updateCattle(Cattle cattle) async {
    log("MASUK SINI S HRSNYA");
    log(cattle.breedId.toString());
    try {
      final response = await http.put(
        Uri.parse('${AppConstants.cattleUrl}/${cattle.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authController.accessToken}',
        },
        body: jsonEncode({
          "name": cattle.name,
          "status": cattle.status,
          "birth_date": cattle.birthDate,
          "birth_weight": cattle.birthWeight,
          "birth_height": cattle.birthHeight,
          "breed_id": cattle.breedId,
          "gender": cattle.gender,
          "type": cattle.type,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Cattle update successfully');
        fetchCattleItems(); // Refresh cattle list after saving
      } else {
        log('Failed to save cattle. Status code: ${response.body}');
      }
    } catch (e) {
      log('Error saving cattle: $e');
    }
  }

  Future<void> deleteCattle(int id) async {
    try {
      log("id: $id");
      final response = await http.delete(
          Uri.parse('${AppConstants.cattleUrl}/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${_authController.accessToken}',
          });
      if (response.statusCode == 200) {
        cattleItems.removeWhere((cattle) => cattle.id == id);
        log('Cattle deleted successfully');
        fetchCattleItems(); // Refresh cattle list after deletion
      } else {
        log('Failed to delete cattle. Status code: ${response.body}');
      }
    } catch (e) {
      log('Error deleting cattle: $e');
    }
  }

  Future<void> fetchBreedItems() async {
    try {
      final response = await http.get(
        Uri.parse(AppConstants.breedUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authController.accessToken}',
        },
      );
      if (response.statusCode == 200) {
        log('ada disini');
        // Decode and check if 'data' is indeed a list
        final jsonData = jsonDecode(response.body)['data'];
        if (jsonData is! List) {
          log('Error: Expected a list but got ${jsonData.runtimeType}');
          return;
        }
        log("MASOKZ:");
        // Map JSON data to a list of Cattle objects
        final List<Breed> items = jsonData.map((item) {
          return Breed(
            id: item['id'],
            name: item['name'],
          );
        }).toList();
        breedItems.assignAll(items);
        log('Breed Items fetched successfully: $cattleItems');
      } else {
        log('Failed to load breeds items. Status code: ${response.body}');
      }
    } catch (e) {
      log('Error fetching breeds items: $e');
    }
  }

  Future<void> assignIOTDevice(int id, String serialNumber) async {
    log("MASUK SINI DL HRSNYA");
    try {
      final response = await http.patch(
        Uri.parse('${AppConstants.cattleUrl}/assign-iot-devices/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authController.accessToken}',
        },
        body: jsonEncode({
          "iot_device_id": serialNumber,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('iot device saved successfully');
        fetchCattleItems();
      } else {
        log('Failed to save cattle. Status code: ${response.body}');
      }
    } catch (e) {
      log('Error saving cattle: $e');
    }
  }

  Future<void> removeIotDevice(int id) async {
    try {
      log("masuk sins");
      final response = await http.delete(
          Uri.parse('${AppConstants.cattleUrl}/remove-iot-devices/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${_authController.accessToken}',
          });
      if (response.statusCode == 200) {
        log('Cattle deleted successfully');
        fetchCattleItems(); // Refresh cattle list after deletion
      } else {
        log('Failed to delete cattle. Status code: ${response.body}');
      }
    } catch (e) {
      log('Error deleting cattle: $e');
    }
  }

  Future<Cattle?> getCattleById(int cattleId) async {
    try {
      log("Fetching cattle details...");
      final response = await http.get(
        Uri.parse('${AppConstants.cattleUrl}/$cattleId'),
        headers: <String, String>{
          'Authorization': 'Bearer ${_authController.accessToken}',
        },
      );
      if (response.statusCode == 200) {
        log('Successfully fetched cattle details.');
        final jsonResponse = jsonDecode(response.body);
        log('Response JSON: $jsonResponse');
        final jsonData = jsonResponse['data'];
        if (jsonData == null) {
          log('Cattle details not found.');
          return null;
        }
        final Cattle cattle = Cattle(
          id: jsonData['id'],
          diAngon: jsonData['diAngon'],
          name: jsonData['name'] ??
              'Unknown', // Provide a default value for safety
          breed: jsonData['breed'] != null
              ? jsonData['breed']['name']
              : 'Unknown', // Print if null
          status: jsonData['status'] ?? 'Unknown',
          breedId: jsonData['breed']?['id'] ??
              -1, // Use -1 or another default for null
          gender: jsonData['gender'] ?? 'Unknown',
          type: jsonData['type'] ?? 'Unknown',
          birthDate: jsonData['birth_date'] ?? 'Unknown',
          birthWeight: jsonData['birth_weight'] ??
              0, // Use 0 or another default for null
          birthHeight: jsonData['birth_height'] ??
              0, // Use 0 or another default for null
          image: "",
          iotDeviceId: jsonData['iot_device_id'],
          iotDevice: jsonData['iot_device'] != null &&
                  jsonData['iot_device']['id'] != null
              ? IoTDevice(
                  id: jsonData['iot_device']['id'],
                  serialNumber:
                      jsonData['iot_device']['serial_number'] ?? 'Unknown',
                  status: jsonData['iot_device']['status'] ?? 'Unknown',
                  installationDate:
                      jsonData['iot_device']['installation_date'] ?? 'Unknown',
                  qrImage: "",
                )
              : null,
          temperature: jsonData['healthRecords'] != null
              ? jsonData['healthRecords']['temperature']
              : null,
          healthStatus: jsonData['healthRecords'] != null
              ? jsonData['healthRecords']['status']
              : null,
        );
        return cattle;
      } else {
        log('Failed to fetch cattle details. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error fetching cattle details: $e');
      return null;
    }
  }
}
