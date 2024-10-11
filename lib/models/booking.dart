class BookingItem {
  final int id;
  final int userMobileId;
  final int departmentId;
  final String departementName;
  final String departementPhotoUrl;
  final int countersId;
  final String countersName;
  final int verificationCode;
  final String name;
  final String email;
  final String photo;
  final String photoUrl;
  final bool reviewed;
  final String date;
  final String dateId;
  final int timeId;
  final String timeName;
  final bool printed;
  final bool verified;
  final bool cancelled;
  final String createdAt;
  final String updatedAt;

  BookingItem({
    required this.id,
    required this.userMobileId,
    required this.departmentId,
    required this.departementName,
    required this.departementPhotoUrl,
    required this.countersId,
    required this.countersName,
    required this.verificationCode,
    required this.name,
    required this.email,
    required this.photo,
    required this.photoUrl,
    required this.reviewed,
    required this.date,
    required this.dateId,
    required this.timeId,
    required this.timeName,
    required this.printed,
    required this.verified,
    required this.cancelled,
    required this.createdAt,
    required this.updatedAt,
  });
}
