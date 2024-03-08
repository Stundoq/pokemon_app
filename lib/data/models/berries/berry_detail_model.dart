import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_detail_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/flavor_entity.dart';

class BerryDetailModel extends BerryDetailEntity {
  @override
  final int id;
  @override
  final String name;
  @override
  final int growthTime;
  final int maxHarvest;
  @override
  final int naturalGiftPower;
  @override
  final int size;
  @override
  final int smoothness;
  @override
  final int soilDryness;
  final Firmness firmness;
  final List<Flavors> flavors;
  final Item item;
  final NaturalGiftType naturalGiftType;

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
  }) : super(
            id: id,
            name: name,
            growthTime: growthTime,
            naturalGiftPower: naturalGiftPower,
            size: size,
            smoothness: smoothness,
            soilDryness: soilDryness,
            firmnessType: firmness.name,
            flavor: getBaseStat(flavors),
            naturalGiftName: naturalGiftType.name);

  factory BerryDetailModel.fromJson(Map<String, dynamic> json) {
    return BerryDetailModel(
      id: json['id'],
      name: json['name'],
      growthTime: json['growth_time'],
      maxHarvest: json['max_harvest'],
      naturalGiftPower: json['natural_gift_power'],
      size: json['size'],
      smoothness: json['smoothness'],
      soilDryness: json['soil_dryness'],
      firmness: Firmness.fromJson(json['firmness']),
      flavors:
          List<Flavors>.from(json["flavors"].map((x) => Flavors.fromJson(x))),
      item: Item.fromJson(json['item']),
      naturalGiftType: NaturalGiftType.fromJson(json['natural_gift_type']),
    );
  }

  static int getStat(List<Flavors> flavors, String flavorName) {
    return flavors.firstWhere((s) => s.flavor.name == flavorName).potency;
  }

  static FlavorEntity getBaseStat(List<Flavors> flavors) => FlavorEntity(
        sour: getStat(flavors, 'sour'),
        spicy: getStat(flavors, 'spicy'),
        dry: getStat(flavors, 'dry'),
        sweet: getStat(flavors, 'sweet'),
        bitter: getStat(flavors, 'bitter'),
      );

  BerryDetailEntity convertToEntity() {
    return BerryDetailEntity(
      id: id,
      name: name,
      growthTime: growthTime,
      naturalGiftPower: naturalGiftPower,
      size: size,
      smoothness: smoothness,
      soilDryness: soilDryness,
      firmnessType: firmnessType,
      flavor: flavor,
      naturalGiftName: naturalGiftName
    );
  }
}

class Firmness {
  String name;
  String url;

  Firmness({
    required this.name,
    required this.url,
  });

  factory Firmness.fromJson(Map<String, dynamic> json) {
    return Firmness(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Flavors {
  int potency;
  Flavor flavor;

  Flavors({
    required this.potency,
    required this.flavor,
  });

  factory Flavors.fromJson(Map<String, dynamic> json) {
    return Flavors(
      potency: json['potency'],
      flavor: Flavor.fromJson(json['flavor']),
    );
  }
}

class Flavor {
  String name;
  String url;

  Flavor({
    required this.name,
    required this.url,
  });

  factory Flavor.fromJson(Map<String, dynamic> json) {
    return Flavor(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Item {
  String name;
  String url;

  Item({
    required this.name,
    required this.url,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      url: json['url'],
    );
  }
}

class NaturalGiftType {
  String name;
  String url;

  NaturalGiftType({
    required this.name,
    required this.url,
  });

  factory NaturalGiftType.fromJson(Map<String, dynamic> json) {
    return NaturalGiftType(
      name: json['name'],
      url: json['url'],
    );
  }
}
