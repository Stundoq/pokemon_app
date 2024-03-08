import 'dart:convert';

import '../../../domain/entities/berry_entities/berry_detail_entity.dart';
import '../../../domain/entities/berry_entities/flavor_entity.dart';

class BerryDetailModel extends BerryDetailEntity {
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
  }) : super(
          id: id,
          name: name,
          growthTime: growthTime,
          naturalGiftPower: naturalGiftPower,
          size:size,
          smoothness: smoothness,
          soilDryness: soilDryness,
          firmness: firmness,
          flavor: getBaseFlavor(flavors),
        );

  static FlavorEntity getBaseFlavor(List<Flavor> stats) => FlavorEntity(
        sour: getFlavor(stats, 'sour'),
        spicy: getFlavor(stats, 'spicy'),
        dry: getFlavor(stats, 'dry'),
        sweet: getFlavor(stats, 'sweet'),
        bitter: getFlavor(stats, 'bitter'),
      );

  static int getFlavor(List<Flavor> stats, String statName) {
    return stats.firstWhere((s) => s.stat.name == statName).baseStat;
  }

  BerryDetailEntity convertToEntity() {
    return BerryDetailEntity(
      id: id,
      name: name,
      growthTime: growthTime,
      naturalGiftPower: naturalGiftPower,
      size: size,
      smoothness: smoothness,
      soilDryness: soilDryness,
      firmness: firmness,
      flavor: flavor,
    );
  }

  factory BerryDetailModel.fromJson(Map<String, dynamic> json) {
    return BerryDetailModel(
      id: json['id'] as int,
      name: json['name'] as String,
      growthTime: json['growth_time'] as int,
      maxHarvest: json['max_harvest'] as int,
      naturalGiftPower: json['natural_gift_power'] as int,
      size: json['size'] as int,
      smoothness: json['smoothness'] as int,
      soilDryness: json['soil_dryness'] as int,
      firmness: Firmness.fromJson(json['firmness'] as Map<String, dynamic>),
      flavors: (json['flavors'] as List<dynamic>)
          .map((e) => Flavor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Firmness {
  final String name;
  final String url;

  Firmness({
    required this.name,
    required this.url,
  });

  factory Firmness.fromJson(Map<String, dynamic> json) {
    return Firmness(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}

class Flavors {
  final int potency;
  final Flavor flavor;

  Flavors({
    required this.potency,
    required this.flavor,
  });

  factory Flavors.fromJson(Map<String, dynamic> json) {
    return Flavors(
      potency: json['potency'] as int,
      flavor: Flavor.fromJson(json['flavor'] as Map<String, dynamic>),
    );
  }
}

class Flavor {
  final String name;
  final String url;

  Flavor({
    required this.name,
    required this.url,
  });

  factory Flavor.fromJson(Map<String, dynamic> json) {
    return Flavor(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}

class Item {
  final String name;
  final String url;

  Item({
    required this.name,
    required this.url,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}

class NaturalGiftType {
  final String name;
  final String url;

  NaturalGiftType({
    required this.name,
    required this.url,
  });

  factory NaturalGiftType.fromJson(Map<String, dynamic> json) {
    return NaturalGiftType(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}
