import 'package:flutter/material.dart';

class CommunityDetailScreen extends StatelessWidget {
  static const routeName = '/beranda';
  final dynamic blog;

  const CommunityDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.userName ?? 'Detail'),
        backgroundColor: const Color(0xff20A577),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              blog.content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            if (blog.image.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  blog.image,
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
                    const Icon(Icons.favorite_border, color: Colors.black),
                    const SizedBox(width: 8),
                    Text(
                      '${blog.likesCount} Likes',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.comment, color: Colors.black),
                    const SizedBox(width: 8),
                    Text(
                      '${blog.commentsCount} Comments',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
