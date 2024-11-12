// import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:heycowmobileapp/app/constants_variable.dart';
import 'package:heycowmobileapp/screens/auth_module/reset_password_failed_screen.dart';
import 'package:heycowmobileapp/screens/auth_module/reset_password_success_screen.dart';
import 'package:heycowmobileapp/screens/auth_module/success_register_screen.dart';
import 'package:heycowmobileapp/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:http_parser/http_parser.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var accessToken = ''.obs;
  var refreshToken = ''.obs;
  var tokenExpireAt = ''.obs;

  var nama = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var address = ''.obs;
  var gender = ''.obs;
  var farm = 0.obs;
  var farmName = ''.obs;
  var farmAddress = ''.obs;
  var isPengangon = 0.obs;
  var upah = ''.obs;
  var nik = ''.obs;

  var password = ''.obs;
  var ulangiPassword = ''.obs;
  var avatar = ''.obs;
  var avatarUrl = ''.obs;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  void updateUserProfile() async {
    try {
      final fields = generateFieldsMapUpdate();
      final response = await http.put(
        Uri.parse(AppConstants.userUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(fields),
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Update Profile Berhasil');
        getUser();
      } else {
        handleErrorResponse(response.body);
      }
    } catch (e) {
      handleNetworkError(e);
    }
  }

  Map<String, String> generateFieldsMapUpdate() {
    return {
      'name': nama.value,
      'email': email.value,
      'provider': 'mobile',
      'phone_number': phone.value,
    };
  }

  void getUser() async {
    try {
      final response = await http.get(
        Uri.parse(AppConstants.userUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        handleSuccessfulGetUser(response.body);
      } else {
        log(response.body);
        handleErrorResponse(response.body);
      }
    } catch (e) {
      log("ini e");
      log(e.toString());

      handleNetworkError(e);
    }
  }

  void login() async {
    final fields = {
      'email': email.value,
      'password': password.value,
    };

    try {
      final response = await http.post(
        Uri.parse(AppConstants.loginUrl),
        body: jsonEncode(fields),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        handleSuccessfulLogin(response.body);
        Get.offAll(() => const MainScreen());
      } else {
        Get.snackbar('Error', 'Username atau Password salah.');

        // // Parse the response body in case of error
        // var errorData = jsonDecode(response.body);

        // handleErrorResponse(errorData);
      }
    } catch (e) {
      handleNetworkError(e);
    }
  }

  void register() async {
    // if (!validate()) return;

    generateFieldsMap();

    try {
      log(nama.value);
      log(email.value);
      log(password.value);
      final response = await http.post(
        Uri.parse(AppConstants.registerUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': nama.value,
          'email': email.value,
          'password': password.value,
        }),
      );

      if (response.statusCode == 200) {
        log("MASUK SINI DULU");
        handleSuccessfulRegistration(response.body);
      } else {
        handleErrorResponse(response.body);
      }
    } catch (e) {
      handleNetworkError(e);
    }
  }

  void activation(int digits) async {
    try {
      final response = await http.post(
        Uri.parse(AppConstants.activationUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({'activation_code': digits}),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Registrasi Berhasil');
        Get.offAll(() => const MainScreen());
      } else {
        handleErrorResponse(response.body);
      }
    } catch (e) {
      handleNetworkError(e);
    }
  }

  Future<void> uploadAvatar(image) async {
    final uri = Uri.parse(AppConstants.avatarUrl);

    var request = http.MultipartRequest('PUT', uri)
      ..headers['Authorization'] = 'Bearer $accessToken'
      ..files.add(
        http.MultipartFile(
          'avatar',
          image.readAsBytes().asStream(),
          await image.length(),
          filename: 'avatar.jpg',
          contentType: MediaType('image', image.mimeType.toString()),
        ),
      );

    try {
      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar('success', 'Avatar successfully updated');
        getUser();
      } else {
        handleErrorResponse(response.body);
      }
    } catch (e) {
      handleNetworkError(e);
    }
  }

  void reset() async {
    final fields = {
      'email': email.value,
    };

    try {
      final response = await http.post(
        Uri.parse(AppConstants.resetpasswordUrl),
        body: jsonEncode(fields),
      );

      if (response.statusCode == 200) {
        Get.to(() => const ResetPasswordSuccessScreen());
      } else {
        handleErrorResponse(response.body);
        Get.to(() => const ResetPasswordFailedScreen());
      }
    } catch (e) {
      handleNetworkError(e);
      Get.to(() => const ResetPasswordFailedScreen());
    }
  }

  Future<bool> getRefreshToken() async {
    try {
      final box = GetStorage();
      final data = box.read('refresh_token');
      final response = await http.post(
        Uri.parse(AppConstants.refreshTokenUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $data',
        },
      );
      if (response.statusCode == 200) {
        handleSuccessfulLogin(response.body);
        return true;
      } else {
        await logout();
        return false;
      }
    } catch (e) {
      await logout();
      return false;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut(); // logout login by google
    await GetStorage().erase();
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }

  void createFCM(String token) async {
    try {
      final fields = {
        'platform': 'mobile',
        'fcm_token': token,
      };

      final response = await http.post(Uri.parse(AppConstants.firebaseUrl),
          headers: <String, String>{'Authorization': 'Bearer $accessToken'},
          body: jsonEncode(fields));

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      handleNetworkError('A network error occurred: $e');
    }
  }

  Map<String, String> generateFieldsMap() {
    return {
      'name': nama.value,
      'email': email.value,
      'password': password.value,
      'password_confirmation': password.value,
      'provider': 'mobile',
      'phone_number': phone.value,
    };
  }

  void sendActivation() async {
    try {
      final response = await http.get(
        Uri.parse(AppConstants.sendActivationUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        Get.to(() => const SuccessRegisterScreen());
        return;
      } else {
        handleErrorResponse(response.body);
      }
    } catch (e) {
      handleNetworkError(e);
    }
  }

  void handleSuccessfulGetUser(String responseBody) {
    try {
      final dynamic jsonResponse = jsonDecode(responseBody);
      if (jsonResponse != null) {
        final dynamic data = jsonResponse;
        if (data != null && data is Map<String, dynamic>) {
          nama.value = data['name']?.toString() ?? '';
          email.value = data['email']?.toString() ?? '';
          phone.value = data['phone_number']?.toString() ?? '';
          address.value = data['address']?.toString() ?? '';
          isPengangon.value = data['is_pengangon'] ?? 0;
          upah.value = data['upah']?.toString() ?? '';
          nik.value = data['nik']?.toString() ?? '';

          if (data['farm'] != null) {
            farm.value = 1;

            farmName.value = data['farm']['name']?.toString() ?? '-';
            farmAddress.value = data['farm']['address']?.toString() ?? '-';
          } else {
            farm.value = 0;
          }

          avatarUrl.value = (data['avatar'] != null && data['avatar'] != '')
              ? data['avatar'].toString()
              : '';
          return;
        }
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', 'An error occurred while processing data');
    }

    Get.snackbar('Error', 'Failed to parse the response');
  }

  void handleSuccessfulLogin(String responseBody) {
    try {
      final dynamic jsonResponse = jsonDecode(responseBody);

      if (jsonResponse != null) {
        if (jsonResponse != null && jsonResponse is Map<String, dynamic>) {
          final dynamic user = jsonResponse['user'];

          if (user != null && user is Map<String, dynamic>) {
            accessToken.value = jsonResponse['access_token'] ?? '';
            refreshToken.value = jsonResponse['refresh_token'] ?? '';
            tokenExpireAt.value = jsonResponse['token_expire_at'] ?? '';

            nama.value = user['name'] ?? '';
            email.value = user['email'] ?? '';
            phone.value = user['phone_number'] ?? '';
            farmName.value = user['farmName'] ?? '';

            isLoggedIn.value = true;
            storeToken();
            Get.snackbar('Success', 'Login Berhasil');
            return;
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while processing data');
    }

    Get.snackbar('Error', 'Failed to parse the response');
  }

  void handleSuccessfulRegistration(String responseBody) {
    try {
      log(responseBody);
      final dynamic jsonResponse = jsonDecode(responseBody);

      if (jsonResponse != null && jsonResponse is Map<String, dynamic>) {
        final dynamic data =
            jsonResponse['data']; // Access the 'data' directly from the root

        if (data != null && data is Map<String, dynamic>) {
          // Access tokens and user details
          accessToken.value = jsonResponse['access_token'] ??
              ''; // Access token is at the root level
          // No refresh_token or token_expire_at in your response

          // Extract user details
          nama.value = data['name'] ?? '';
          email.value = data['email'] ?? '';
          // You may want to extract phone or other user details if available in the response
          phone.value =
              ''; // If phone is not included, you can leave it empty or handle it appropriately

          isLoggedIn.value = true; // Update login status
          Get.to(() =>
              const SuccessRegisterScreen()); // Navigate to the success screen
          return;
        }
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', 'An error occurred while processing data');
    }

    Get.snackbar('Error', 'Failed to parse the response');
  }

  void handleErrorResponse(String responseBody) {
    try {
      final dynamic errorResponse = jsonDecode(responseBody);
      if (errorResponse != null && errorResponse is Map<String, dynamic>) {
        final errorMessage = errorResponse['message'];
        final List<dynamic> errorData = errorResponse['data'] ?? [];
        String snackBarMessage = '';

        if (errorData.isNotEmpty && errorData.first is Map<String, dynamic>) {
          final firstError = errorData.first.entries.first;
          snackBarMessage = '${firstError.key}: ${firstError.value}';
        } else {
          snackBarMessage = 'No more detail';
        }

        Get.snackbar(errorMessage, snackBarMessage);
      } else {
        Get.snackbar('Error', 'Unknown error occurred');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  void handleNetworkError(dynamic error) {
    Get.snackbar('Error', 'A network error occurred: $error');
  }

  void storeToken() {
    final box = GetStorage();
    box.write('token', accessToken.value);
    box.write('refresh_token', refreshToken.value);
    box.write('expired_token', tokenExpireAt.value);
    box.write('isLogin', isLoggedIn.value);
    return;
  }
}
