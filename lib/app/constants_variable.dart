class AppConstants {
  // static const String baseURL = 'https://192.168.43.9:8000/api/'; //production
  static const String baseURL = 'https://heycow.my.id/api/'; //production
  // auth module
  static const String loginUrl = '${baseURL}auth/login';
  static const String refreshTokenUrl = '${baseURL}auth/refresh_token';
  static const String loginWithGoogleUrl = '${baseURL}auth/google';
  // static const String loginWithGoogleUrl = '${baseURL}auth/google?key=G00GL3JwtH4ruu555KU4t';
  static const String registerUrl = '${baseURL}auth/register';
  static const String activationUrl = '${baseURL}auth/activated';
  static const String resetpasswordUrl = '${baseURL}auth/resetpassword';
  static const String userUrl = '${baseURL}me';
  static const String avatarUrl = '${baseURL}user/avatar';
  static const String dashboardUrl = '${baseURL}dashboard';
  // FCM
  static const String firebaseUrl = '${baseURL}firebase';
  // beranda
  static const String sliderUrl = '${baseURL}webslider';
  static const String configUrl = '${baseURL}webconfig';
  // cattle
  static const String cattleUrl = '${baseURL}cattle';
  static const String blogUrl = '${baseURL}blog-posts';
  static const String breedUrl = '${baseURL}breeds';
  static const String searchIOTDevices = '${baseURL}cattle/iot-devices/search';
  // berita




  // pengangon
  static const String pengangonUrl = '${baseURL}users/pengangon';










  static const String beritaHomeUrl = '${baseURL}webpost/home';
  static const String beritaDetailUrl = '${baseURL}webpost';
  // tenant
  static const String tenantUrl = '${baseURL}department';
  static const String beritaDetalUrl = '${baseURL}webpost';
  // layanan
  static const String layananlUrl = '${baseURL}counter';
  // pengaduan
  static const String pengaduanlUrl = '${baseURL}contact';
  // booking
  static const String bookinglUrl = '${baseURL}booking';
  // review
  static const String reviewUrl = '${baseURL}review';

  // send activation
  static const String sendActivationUrl = '${baseURL}auth/activation/resend';

  // constant data
  static const String googleToken = 'G00GL3JwtH4ruu555KU4t';
}
