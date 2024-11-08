class Pengangon {
  final int id;
  final String name;
  final String farm;
  final String address;
  final String upah;
  final String? avatar;
  final int rate;

  Pengangon({
    required this.id,
    required this.name,
    required this.farm,
    required this.address,
    required this.upah,
    this.avatar,
    required this.rate,
  });
}
