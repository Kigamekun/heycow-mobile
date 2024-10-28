class BookingItem {
  final int id;
  final int userMobileId;
  final int departmentId;
  final String departementName;
  final String departementPhotoUrl;
  final int countersId;
  final String countersName;

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
    required this.createdAt,
    required this.updatedAt,
  });
}
