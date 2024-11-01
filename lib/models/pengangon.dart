class Pengangon {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String role;
  final String? phoneNumber;
  final String? address;
  final String? bio;
  final String? avatar;
  final int isPengangon;
  final String createdAt;
  final String updatedAt;

  Pengangon({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.role,
    this.phoneNumber,
    this.address,
    this.bio,
    this.avatar,
    required this.isPengangon,
    required this.createdAt,
    required this.updatedAt,
  });
}
