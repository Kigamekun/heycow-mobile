import 'package:flutter/material.dart';
import 'package:heycowmobileapp/controllers/community_controller.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/screens/community_module/community_create_screen.dart';
import 'package:heycowmobileapp/screens/community_module/community_detail_screen.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:http/http.dart' as http;

class CommunityScreen extends StatefulWidget {
  static const routeName = '/beranda';

  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final CommunityController communitycontroller =
      Get.put(CommunityController());
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    communitycontroller.fetchBlogItems();
    searchController.addListener(() {
      communitycontroller.fetchBlogItems(query: searchController.text);
    });
  }

 @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  Future<void> likeBlog(int id) async {
    final url = Uri.parse(
      'https://heycow.my.id/api/blog-posts/$id/likes',
    );
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer ${_authController.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        communitycontroller.fetchBlogItems();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to like blog')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEBED),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 90),
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
                                  Color(0xff20A577),
                                  Color(0xff64CFAA),
                                ],
                                stops: [0.1, 0.5],
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            height: 250,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 55),
                        ],
                      ),
                      Positioned(
                          top: 145,
                          left: 16,
                          right: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(() => const CommunityCreateScreen());
                                  // Get.to(() => zconst AddCattleScreen());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF20A577),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Text('POST',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Positioned(
                        top: 200,
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
                          child:  Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: searchController,
                                        decoration: const InputDecoration(
                                          hintText:
                                              "Search Blog Title", // Search hint text
                                          hintStyle: TextStyle(
                                            color: Colors.grey, // Text color
                                          ),
                                          border: InputBorder
                                              .none, // Remove the underline border
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.search,
                                      color: Colors.black, // Search icon color
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Obx(() {
                      // Listen to changes in blogItems using Obx
                      if (communitycontroller.blogItems.isEmpty) {
                        return const Center(child: Text("No blogs available"));
                      }
                      return Column(
                        children: [
                          for (var blog in communitycontroller.blogItems)
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CommunityDetailScreen(
                                        id: blog.id
                                            as int), // Pindah ke layar detail
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                margin: const EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header (Profile picture, name, time)
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 24,
                                                backgroundColor: Colors.black,
                                                child: Icon(Icons.person,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(width: 12),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    blog.userName ?? '',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    blog.publishedAt ?? '',
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          if (blog.category ==
                                              'jual') // Check if price is not null
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 10.0),
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .green, // Background color for the badge
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0), // Rounded corners
                                              ),
                                              child: Text(
                                                blog.price,
                                                style: const TextStyle(
                                                  color: Colors
                                                      .white, // Text color for the badge
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                    // Blog content
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Aligns children to the left
                                        children: [
                                          Text(
                                            blog.title,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 10),
                                    // Blog Image
                                    if (blog.image.isNotEmpty)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Image.network(
                                          blog.image,
                                          fit: BoxFit.cover,
                                          height: 200,
                                          width: double.infinity,
                                        ),
                                      ),
                                    // Like and comment row
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              if ((blog
                                                  .isLiked)) // Use ?? false to handle null cases
                                                TextButton(
                                                  onPressed: () => {
                                                    // Aksi tombol pertama
                                                    likeBlog(blog.id as int)
                                                  },
                                                  child: const Icon(
                                                      Icons.favorite,
                                                      color: Colors.red),
                                                ),
                                              if (!(blog.isLiked))
                                                TextButton(
                                                  onPressed: () => {
                                                    // Aksi tombol pertama
                                                    likeBlog(blog.id as int)
                                                  },
                                                  child: const Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.black),
                                                ),
                                              const SizedBox(width: 8),
                                              Text(
                                                '${blog.likesCount} Likes',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.comment,
                                                  color: Colors.black),
                                              const SizedBox(width: 8),
                                              Text(
                                                '${blog.commentsCount} Comments',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 100),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          // Floating Bottom Navigation Bar
        ],
      ),
    );
  }
}
