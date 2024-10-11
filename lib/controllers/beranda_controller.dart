import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:heycowmobileapp/app/constants_variable.dart';
import 'package:heycowmobileapp/models/config.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:heycowmobileapp/models/slider.dart';

class BerandaController extends GetxController {
  final List<SliderItem> sliderItems = <SliderItem>[].obs;
  final List<ConfigItem> configItems = <ConfigItem>[];

  Future<void> fetchSliderItems() async {
    try {
      final response =
          await http.get(Uri.parse('${AppConstants.sliderUrl}?type=secondary'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)['data'];

        final List<SliderItem> items = jsonData.map((item) {
          return SliderItem(
            id: item['id'],
            title: item['title'],
            type: item['type'],
            picture: item['picture'],
            pictureUrl: item['picture_url'],
            createdAt: item['created_at'],
            updatedAt: item['updated_at'],
          );
        }).toList();

        sliderItems.assignAll(items);
        print(sliderItems);
      } else {
        // todo: Handle other status codes if needed
      }
    } catch (e) {
      // todo: Handle errors
    }
  }

  Future fetchConfigItems() async {
    try {
      final response = await http.get(Uri.parse(AppConstants.configUrl));
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        return ConfigItem.fromJson(
            (responseJson as Map<String, dynamic>)["data"]);
      } else {
        // todo: Handle other status codes if needed
      }
    } catch (e) {
      // todo: Handle errors
    }
  }
}
