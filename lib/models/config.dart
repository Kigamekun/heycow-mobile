class ConfigItem {
  final String about;
  final String aboutImage;
  final String address;
  final String appName;
  final String appShortName;
  final String email;
  final String logo;
  final String maps;
  final String phone;
  final String locationLat;
  final String locationLong;

  ConfigItem({
    required this.about,
    required this.aboutImage,
    required this.address,
    required this.appName,
    required this.appShortName,
    required this.email,
    required this.logo,
    required this.maps,
    required this.phone,
    required this.locationLat,
    required this.locationLong,
  });

  factory ConfigItem.fromJson(Map<String, dynamic> json) {
    return ConfigItem(
      about: json['about'] ?? '',
      aboutImage: json['about_image'] ?? '',
      address: json['address'] ?? '',
      appName: json['app_name'] ?? '',
      appShortName: json['app_short_name'] ?? '',
      email: json['email'] ?? '',
      logo: json['logo'] ?? '',
      maps: json['maps'] ?? '',
      phone: json['phone'] ?? '',
      locationLat: json['location_lat'] ?? '',
      locationLong: json['location_long'] ?? '',
    );
  }
}
