import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:heycowmobileapp/app/constants_variable.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:heycowmobileapp/models/pengangon.dart';
import 'package:heycowmobileapp/models/breed.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';

class PengangonController extends GetxController {
  final List<Pengangon> pengangonItems = <Pengangon>[].obs;
  final List<Breed> breedItems = <Breed>[].obs;

  final AuthController _authController = Get.find<AuthController>();

  Future<void> fetchPengangonItems({String? query}) async {
    try {
      final url = Uri.parse(AppConstants.pengangonUrl).replace(
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
          log('No pengangon items found or jsonData is empty.');
          pengangonItems
              .assignAll([]); // Assign an empty list to pengangonItems
          return;
        } else if (jsonData is! List) {
          log('Error: Expected jsonData to be a list but got ${jsonData.runtimeType}');
          return;
        }
        final List<Pengangon> items = jsonData.map<Pengangon>((item) {

          log('item: $item');

          return Pengangon(
            id: item['id'],
            name: item['name'],
            farm: item['farm'],
            address: item['address'],
            upah: item['upah'],
            avatar: item['avatar'],
            rate : item['rate'],
          );
        }).toList();
        pengangonItems.assignAll(items);
        log('Pengangon Items fetched successfully: $pengangonItems');
      } else {
        log('Failed to load pengangon items. Status code: ${response.statusCode}');
        pengangonItems.assignAll([]);
      }
    } catch (e) {
      log('Error fetching pengangon items: $e');
      pengangonItems.assignAll([]);
    }
  }
}
