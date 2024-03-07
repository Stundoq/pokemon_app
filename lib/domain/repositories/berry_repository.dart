import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_item_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_list_entity.dart';

abstract class BerryRepository {
  Future<BerryListEntity> getBerry({
    required String? url,
  });

  Future<int> clearAllFavoriteBerry();

  List<BerryItemEntity> getFavoriteBerryList();

  BerryItemEntity? isBerryInFavorites({
    required String key,
  });

  Future<BerryItemEntity?> addBerryByName({required BerryItemEntity berryItemEntity});

  Future<BerryItemEntity?> removeBerryByName({required String key});


}