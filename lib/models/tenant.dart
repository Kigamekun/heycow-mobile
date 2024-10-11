class TenantItem {
  final int id;
  final String name;
  final int hasChild;
  final String logo;
  final String logoUrl;

  TenantItem({
    required this.id,
    required this.name,
    required this.hasChild,
    required this.logo,
    required this.logoUrl,
  });
}

class TenantDetail {
  final int id;
  final String name;
  final String logo;
  final String logoUrl;
  final String mainTask;
  final String purpose;
  final String vision;
  final String mission;
  final String motto;

  TenantDetail({
    required this.id,
    required this.name,
    required this.logo,
    required this.logoUrl,
    required this.mainTask,
    required this.purpose,
    required this.vision,
    required this.mission,
    required this.motto,
  });
}
