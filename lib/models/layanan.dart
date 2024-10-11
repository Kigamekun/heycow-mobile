class LayananItem {
  final int id;
  final String name;
  final String logo;
  final String logoUrl;

  LayananItem({
    required this.id,
    required this.name,
    required this.logo,
    required this.logoUrl,
  });
}

class LayananDetail {
  final int id;
  final String name;
  final String logo;
  final String logoUrl;
  final String description;
  final String legalBasis;
  final String requirementAndService;
  final String systemMechanismAndProcedure;
  final String completionTimePeriod;
  final String feeRate;
  final String productService;

  LayananDetail({
    required this.id,
    required this.name,
    required this.logo,
    required this.logoUrl,
    required this.description,
    required this.legalBasis,
    required this.requirementAndService,
    required this.systemMechanismAndProcedure,
    required this.completionTimePeriod,
    required this.feeRate,
    required this.productService,
  });
}