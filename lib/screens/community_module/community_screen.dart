import 'package:flutter/material.dart';
import 'package:heycowmobileapp/controllers/community_controller.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/screens/community_module/community_detail_screen.dart';

class CommunityScreen extends StatefulWidget {
  static const routeName = '/beranda';

  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final CommunityController communitycontroller =
      Get.put(CommunityController());

  @override
  void initState() {
    super.initState();
    communitycontroller.fetchBlogItems();
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
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.white, // Set background to white
                                  shape:
                                      const CircleBorder(), // Circle shape without border
                                  padding: const EdgeInsets.all(
                                      0), // Adjust padding to control the size
                                ),
                                child: const Icon(
                                    Icons.video_camera_back_outlined,
                                    color:
                                        Colors.black), // Icon inside the button
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.white, // Set background to white
                                  shape:
                                      const CircleBorder(), // Circle shape without border
                                  padding: const EdgeInsets.all(
                                      0), // Adjust padding to control the size
                                ),
                                child: const Icon(Icons.image_outlined,
                                    color:
                                        Colors.black), // Icon inside the button
                              ),
                              ElevatedButton(
                                onPressed: () {
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
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText:
                                              "Search Cattle Name or Device ID",
                                          hintStyle: TextStyle(
                                            color: Colors.grey, // Text color
                                          ),
                                          border: InputBorder
                                              .none, // Remove the underline border
                                        ),
                                      ),
                                    ),
                                    Icon(
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
                                    builder: (context) => CommunityDetailScreen(blog: blog), // Pindah ke layar detail
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
                                                  fontWeight: FontWeight.bold,
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
                                    ),
                                    // Blog content
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        blog.content,
                                        style: const TextStyle(fontSize: 14),
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
                                              const Icon(Icons.favorite_border,
                                                  color: Colors.black),
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
