import 'package:equatable/equatable.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/flavor_entity.dart';

import '../../../data/models/berries/berry_detail_model.dart';

class BerryDetailEntity extends Equatable {
  final int id;
  final String name;
  final int growthTime;
  final int naturalGiftPower;
  final int size;
  final int smoothness;
  final int soilDryness;
  final String firmnessType;
  final FlavorEntity flavor;
  final String naturalGiftName;

  const BerryDetailEntity({
    required this.id,
    required this.name,
    required this.growthTime,
    required this.naturalGiftPower,
    required this.size,
    required this.smoothness,
    required this.soilDryness,
    required this.firmnessType,
    required this.flavor,
    required this.naturalGiftName
  });

  @override
  List<Object?> get props => [id, name];
}
