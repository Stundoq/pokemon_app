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
