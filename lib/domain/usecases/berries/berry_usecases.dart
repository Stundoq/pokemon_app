import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_detail_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_item_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_list_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/repositories/berry_repository.dart';
import '../../../core/usecase/base_usecase.dart';

class GetBerry extends BaseUseCase<Future<BerryListEntity>, ParamsForBerry> {
  final BerryRepository berryRepository;

  const GetBerry(this.berryRepository);

  @override
  Future<BerryListEntity> execute(ParamsForBerry params) async {
    return await berryRepository.getBerry(url: params.url);
  }

}

class ParamsForBerry {
  final String? url;

  const ParamsForBerry(
      this.url,
      );
}

class Params {
  const Params();
}

class ClearAllFavoriteBerry extends BaseUseCase<Future<int>, Params> {
  final BerryRepository berryRepository;

  const ClearAllFavoriteBerry(this.berryRepository);

  @override
  Future<int> execute(Params params) async {
    return await berryRepository.clearAllFavoriteBerry();
  }
}

class ParamsGetFavoriteBerryList {

  const ParamsGetFavoriteBerryList();
}

class GetBerryItemList extends BaseUseCase<List<BerryItemEntity>, ParamsGetFavoriteBerryList> {
  final BerryRepository berryRepository;

  const GetBerryItemList(this.berryRepository);

  @override
  List<BerryItemEntity> execute(ParamsGetFavoriteBerryList params) {
    return berryRepository.getFavoriteBerryList();
  }

}

class ParamsForIsBerryInFavorites {
  final String key;

  const ParamsForIsBerryInFavorites(
      this.key,
      );
}

class IsBerryInFavorites extends BaseUseCase<BerryItemEntity?, ParamsForIsBerryInFavorites> {
  final BerryRepository berryRepository;

  const IsBerryInFavorites(this.berryRepository);

  @override
  BerryItemEntity? execute(ParamsForIsBerryInFavorites params) {
    return berryRepository.isBerryInFavorites(key: params.key);
  }
}

class ParamsAddBerry {
  final BerryItemEntity berryItemEntity;

  const ParamsAddBerry(this.berryItemEntity,);
}

class AddBerryByName extends BaseUseCase<Future<BerryItemEntity?>, ParamsAddBerry> {
  final BerryRepository berryRepository;

  const AddBerryByName(this.berryRepository);

  @override
  Future<BerryItemEntity?> execute(ParamsAddBerry params) async {
    return await berryRepository.addBerryByName(berryItemEntity: params.berryItemEntity);
  }
}

class ParamsKey {
  final String key;

  const ParamsKey(
      this.key,
      );
}

class RemoveBerryByName extends BaseUseCase<Future<BerryItemEntity?>, ParamsKey> {
  final BerryRepository berryRepository;

  const RemoveBerryByName(this.berryRepository);

  @override
  Future<BerryItemEntity?> execute(ParamsKey params) async {
    return await berryRepository.removeBerryByName(key: params.key);
  }
}

class GetBerryByName extends BaseUseCase<Future<BerryDetailEntity>, ParamsForBerryByName> {
  final BerryRepository berryRepository;

  const GetBerryByName(this.berryRepository);

  @override
  Future<BerryDetailEntity> execute(ParamsForBerryByName params) async {
    return await berryRepository.getBerryByName(params.name);
  }
}

class ParamsForBerryByName {
  final String name;

  const ParamsForBerryByName({
    required this.name,
  });
}



