import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:heycowmobileapp/app/constants_variable.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:heycowmobileapp/models/blog.dart';
import 'package:heycowmobileapp/models/breed.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';

class CommunityController extends GetxController {
  final List<Blog> blogItems = <Blog>[].obs;
  final List<Breed> breedItems = <Breed>[].obs;

  final AuthController _authController = Get.find<AuthController>();

  Future<void> fetchBlogItems() async {
    try {
      final response = await http.get(
        Uri.parse(AppConstants.blogUrl),
        headers: <String, String>{
          'Authorization': 'Bearer ${_authController.accessToken}',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        log('Response JSON: $jsonResponse');
        final jsonData = jsonResponse['data']?['data'];
        if (jsonData == null || jsonData.isEmpty) {
          log('No cattle items found or jsonData is empty.');
          blogItems.assignAll([]); // Assign an empty list to blogItems
          return;
        } else if (jsonData is! List) {
          log('Error: Expected jsonData to be a list but got ${jsonData.runtimeType}');
          return;
        }
        final List<Blog> items = jsonData.map<Blog>((item) {
          return Blog(
            id: item['id'],
            title: item['title'],
            userId: item['user_id'],
            userName : item['user']['name'],
            content: item['content'],
            category: item['category'],
            image: item['full_image_url'],
            published: item['published'],
            likesCount: item['likes_count'],
            commentsCount: item['comments_count'],
            publishedAt : item['published_at'],
            createdAt: DateTime.parse(item['created_at']),
          );
        }).toList();
        blogItems.assignAll(items);
        log('Blog Items fetched successfully: $blogItems');
      } else {
        log('Failed to load cattle items. Status code: ${response.statusCode}');
        blogItems.assignAll([]);
      }
    } catch (e) {
      log('Error fetching cattle items: $e');
      blogItems.assignAll([]);
    }
  }

}
