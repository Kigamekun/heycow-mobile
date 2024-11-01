import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:heycowmobileapp/app/routes_manager.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:heycowmobileapp/controllers/beranda_controller.dart';
import 'package:heycowmobileapp/firebase_options.dart';
import 'package:heycowmobileapp/app/theme.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/screens/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: "This channel is used for important notifications.",
      importance: Importance.max,
      playSound: true,
      showBadge: true,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  String? tokenAdmin = await FirebaseMessaging.instance.getToken();
  saveToken(tokenAdmin);
  runApp(const MyApp());
}
void saveToken(String? tokenAdmin) {
  AuthController fcmController = Get.put(AuthController());
  fcmController.createFCM(tokenAdmin.toString());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HeyCow Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MPPColorTheme.orangeColor),
        useMaterial3: true,
        textTheme: textTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      initialRoute: SplashScreen.routeName,
      initialBinding: initBinding(),
      getPages: RoutesManager.routes,
    );
  }
  BindingsBuilder<dynamic> initBinding() {
    return BindingsBuilder(() {
      Get.put(AuthController());
      Get.put(BerandaController());
    });
  }
}
