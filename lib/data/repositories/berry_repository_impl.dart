import 'package:flutter_tdd_clean_architecture_mvvm/data/models/berries/berry_list_model.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_list_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/repositories/berry_repository.dart';

import '../datasources/remote_datasource/remote_datasource.dart';

class BerryRepositoryImpl implements BerryRepository{
  final RemoteDataSource remoteDataSourceImp;

  const BerryRepositoryImpl({
    required this.remoteDataSourceImp,
  });
  @override
  Future<BerryListEntity> getBerry({
    required String? url,
  }) async {
    BerryListModel pokemonListModel = await remoteDataSourceImp.getBerry(url);
    return pokemonListModel.convertToEntity();
  }

}