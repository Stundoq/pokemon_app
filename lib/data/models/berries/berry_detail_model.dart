class BerryDetailModel {
  final int id;
  final String name;
  final int growthTime;
  final int maxHarvest;
  final int naturalGiftPower;
  final int size;
  final int smoothness;
  final int soilDryness;
  final Firmness firmness;
  final List<Flavor> flavors;
  final Firmness item;
  final Firmness naturalGiftType;

  BerryDetailModel({
    required this.id,
    required this.name,
    required this.growthTime,
    required this.maxHarvest,
    required this.naturalGiftPower,
    required this.size,
    required this.smoothness,
    required this.soilDryness,
    required this.firmness,
    required this.flavors,
    required this.item,
    required this.naturalGiftType,
  });

  factory BerryDetailModel.fromJson(Map<String, dynamic> json) =>
      BerryDetailModel(
        id: json['id'],
        name: json['name'],
        growthTime: json['growthTime'],
        maxHarvest: json['maxHarvest'],
        naturalGiftPower: json['naturalGiftPower'],
        size: json['size'],
        smoothness: json['smoothness'],
        soilDryness: json['soilDryness'],
        firmness: json['firmness'],
        flavors: json['flavors'],
        item: json['item'],
        naturalGiftType: json['naturalGiftType'],
      );
}

class Firmness {
  final String name;
  final String url;

  Firmness({
    required this.name,
    required this.url,
  });

  factory Firmness.fromJson(Map<String, dynamic> json) => Firmness(
        name: json['name'],
        url: json['url'],
      );
}

class Flavor {
  final int potency;
  final Firmness flavor;

  Flavor({
    required this.potency,
    required this.flavor,
  });

  factory Flavor.fromJson(Map<String, dynamic> json) => Flavor(
        potency: json['potency'],
        flavor: json['flavor'],
      );
}
