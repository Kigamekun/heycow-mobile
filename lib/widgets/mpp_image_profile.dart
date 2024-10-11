import 'package:flutter/material.dart';

class MPPImageProfile extends StatelessWidget {
  final String imageUrl;

  const MPPImageProfile({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('profile image: $imageUrl');
    return ClipOval(
      child: Image.network(imageUrl,fit: BoxFit.cover, loadingBuilder:
          (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Center(
              child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ));
        }
      }, errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48),
            SizedBox(height: 8),
            Text('Failed to load image',
                style: TextStyle(color: Colors.red, fontSize: 8))
          ],
        ));
      }),
    );
  }
}
