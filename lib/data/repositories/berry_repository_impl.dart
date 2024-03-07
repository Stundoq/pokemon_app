import 'package:flutter_tdd_clean_architecture_mvvm/data/datasources/local_datasource/local_datasource.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/data/models/berries/berry_list_model.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_item_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_list_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/repositories/berry_repository.dart';

import '../datasources/remote_datasource/remote_datasource.dart';

class BerryRepositoryImpl implements BerryRepository {
  final RemoteDataSource remoteDataSourceImp;
  final LocalDataSource localDataSourceImp;

  const BerryRepositoryImpl(
      {required this.remoteDataSourceImp, required this.localDataSourceImp});

  @override
  Future<BerryListEntity> getBerry({
    required String? url,
  }) async {
    BerryListModel berryListModel = await remoteDataSourceImp.getBerry(url);
    return berryListModel.convertToEntity();
  }

  @override
  Future<int> clearAllFavoriteBerry() async {
    return await localDataSourceImp.clearAllFavoriteBerry();
  }

  @override
  List<BerryItemEntity> getFavoriteBerryList() {
    final berries = localDataSourceImp.getFavoriteBerryList();
    return berries
        .map((berry) => BerryItemEntity(name: berry.name, url: berry.url))
        .toList();
  }

  @override
  BerryItemEntity? isBerryInFavorites({
    required String key,
  }) {
    BerryItem? berryItem = localDataSourceImp.isBerryInFavorites(key);
    BerryItemEntity? berryItemEntity;
    if (berryItem != null) {
      berryItemEntity =
          BerryItemEntity(name: berryItem.name, url: berryItem.url);
    }
    return berryItemEntity;
  }

  @override
  Future<BerryItemEntity?> addBerryByName(
      {required BerryItemEntity berryItemEntity}) async {
    BerryItem? berryItem = await localDataSourceImp.addBerryByName(
        BerryItem(name: berryItemEntity.name, url: berryItemEntity.url));
    return berryItem?.convertToEntity();
  }

  @override
  Future<BerryItemEntity?> removeBerryByName({required String key}) async {
    BerryItem? berryItem=  await localDataSourceImp.removeBerryByName(key);
    return berryItem?.convertToEntity();
  }
}
