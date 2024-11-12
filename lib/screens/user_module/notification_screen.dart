import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List notifications = [];
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    const String url = 'https://heycow.my.id/api/notifications';

    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer ${_authController.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          notifications = responseData['data'];
        });
    } else {
    }
  }

  Future<void> markAsRead(int notificationId) async {
    final String url = 'https://heycow.my.id/api/notifications/$notificationId/read';

    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer ${_authController.accessToken}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        notifications = notifications.map((notification) {
          if (notification['id'] == notificationId) {
            notification['is_read'] = 1;
          }
          return notification;
        }).toList();
      });
    } else {
    }
  }

  IconData getIcon(String type) {
    switch (type) {
      case 'success':
        return Icons.check_circle;
      case 'warning':
        return Icons.warning;
      case 'error':
        return Icons.error;
      default:
        return Icons.notifications;
    }
  }

  Color getIconColor(String type) {
    switch (type) {
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'error':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Notifications',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF20A577), // Start color
                Color(0xFF64CFAA), // End color
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFEAEBED),
      body: notifications.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationItem(
                  date: notification['created_at'] ?? 'Unknown Date',
                  title: notification['title'] ?? 'Notification',
                  message: notification['message'] ?? '',
                  icon: getIcon(notification['type']),
                  iconColor: getIconColor(notification['type']),
                  isRead: notification['is_read'] == 1,
                  onTap: () {
                    if (notification['is_read'] == 0) {
                      markAsRead(notification['id']);
                    }
                  },
                );
              },
            ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String date;
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final bool isRead;
  final VoidCallback onTap;

  const NotificationItem({
    super.key,
    required this.date,
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isRead ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      if (!isRead)
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(Icons.circle, color: Colors.red, size: 8),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
