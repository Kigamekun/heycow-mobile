import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CommunityDetailScreen extends StatefulWidget {
  static const routeName = '/beranda';
  final int id;

  const CommunityDetailScreen({super.key, required this.id});

  @override
  // ignore: library_private_types_in_public_api
  _CommunityDetailScreenState createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  dynamic blog;
  bool isLoading = true;
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBlog();
  }

  Future<void> fetchBlog() async {
    final url = Uri.parse(
      'https://heycow.my.id/api/blog-posts/${widget.id}',
    );
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer ${_authController.accessToken}',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          blog = data['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load blog data')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
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
        fetchBlog(); // Refresh blog data
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

  Future<void> submitComment() async {
    if (_commentController.text.isEmpty) return;

    final url = Uri.parse(
      'https://heycow.my.id/api/blog-posts/${widget.id}/comments',
    );
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer ${_authController.accessToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode({'content': _commentController.text}),
      );

      if (response.statusCode == 201) {
        _commentController.clear();
        fetchBlog(); // Refresh comments
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comment submitted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit comment')),
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
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Detail Community',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF20A577),
                Color(0xFF64CFAA),
              ],
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : blog != null
              ? SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Color(0xFFEAEBED),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://heycow.my.id/storage/${blog['user']['avatar']}',
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth:
                                        MediaQuery.of(context).size.width *
                                            0.75,
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.75,
                                    minHeight: 0.0,
                                    maxHeight: 150.0,
                                  ),
                                  child: AutoSizeText(
                                    blog['title'],
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  'By ${blog['user']['name']} - ${blog['published_at']}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Html(
                          data: blog['content'],
                          style: {
                            "p": Style(fontSize: FontSize(16)),
                          },
                        ),
                        const SizedBox(height: 16),
                        if (blog['image'] != null && blog['image'].isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              blog['full_image_url'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (blog != null &&
                                    (blog['isLiked'] ??
                                        false)) // Use ?? false to handle null cases
                                  TextButton(
                                    onPressed: () => {
                                      // Aksi tombol pertama
                                      likeBlog(blog['id'])
                                    },
                                    child: const Icon(Icons.favorite,
                                        color: Colors.red),
                                  ),
                                if (blog != null && !(blog['isLiked'] ?? false))
                                  TextButton(
                                    onPressed: () => {
                                      // Aksi tombol pertama
                                      likeBlog(blog['id'])
                                    },
                                    child: const Icon(Icons.favorite_border,
                                        color: Colors.black),
                                  ),
                                const SizedBox(width: 8),
                                Text(
                                  '${blog['likes_count']} Likes',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.comment, color: Colors.black),
                                const SizedBox(width: 8),
                                Text(
                                  '${blog['comments_count']} Comments',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        if (blog['price'] != null &&
                            blog['category'] ==
                                'jual') // Check if price is not null
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                  color: Colors
                                      .blue, // Background color for the badge
                                  borderRadius: BorderRadius.circular(
                                      12.0), // Rounded corners
                                ),
                                child: Text(
                                  blog['price'],
                                  style: const TextStyle(
                                    color: Colors
                                        .white, // Text color for the badge
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5), // Rounded corners
                                  ),
                                ),
                                onPressed: () {
                                  // Aksi tombol kedua
                                },
                                child: const Text(
                                  'Beli',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors
                                        .white, // Mengubah warna teks menjadi putih
                                  ),
                                ),
                              )
                            ],
                          ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: submitComment,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Comments",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            itemCount: blog['comments'].length,
                            itemBuilder: (context, index) {
                              final comment = blog['comments'][index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.7),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(comment['content'] ?? ''),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(child: Text('Blog data not available')),
    );
  }
}
