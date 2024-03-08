import 'package:flutter/cupertino.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_detail_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/flavor_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/usecases/berries/berry_usecases.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/pages/berry_detail/berry_detail_viewmodel.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/pages/berry_detail/flavor_attributes.dart';

import '../../../core/api_helper/api_response.dart';
import '../../../injection.dart';

class BerryDetailViewModelImp
    with ChangeNotifier
    implements BerryDetailViewModel {
  ApiResponse<BerryDetailEntity> _getBerryByNameResponse =
      ApiResponse.loading('loading');

  @override
  ApiResponse<BerryDetailEntity> get getBerryByNameResponse =>
      _getBerryByNameResponse;

  @override
  set getBerryByNameResponse(ApiResponse<BerryDetailEntity> value) {
    _getBerryByNameResponse = value;
    notifyListeners();
  }

  @override
  Future<void> getBerryByName({
    required String name,
  }) async {
    try {
      BerryDetailEntity berryDetailEntity =
          await injector<GetBerryByName>().execute(
        ParamsForBerryByName(
          name: name,
        ),
      );
      getBerryByNameResponse = ApiResponse.completed(berryDetailEntity);
    } catch (e) {
      getBerryByNameResponse = ApiResponse.error(e);
    }
  }

  @override
  String getBerryName() {
    return getBerryByNameResponse.data.name;
  }

  @override
  FlavorAttributes getBerryAttributes() {
    final FlavorEntity baseStat = getBerryByNameResponse.data.flavor;
    final stats = FlavorAttributes(
      sour: baseStat.sour * 0.01,
      spicy: baseStat.spicy * 0.01,
      dry: baseStat.dry * 0.01,
      sweet: baseStat.sweet * 0.01,
      bitter: baseStat.bitter * 0.01,
    );
    return stats;
  }

  @override
  String getFirmnessType() {
    return getBerryByNameResponse.data.firmnessType;
  }

  @override
  int getBerrySize() {
    return getBerryByNameResponse.data.size;
  }

  @override
  int getSmoothness() {
    return getBerryByNameResponse.data.smoothness;
  }

  @override
  String getNaturalGiftName() {
    return getBerryByNameResponse.data.naturalGiftName;
  }
  @override
  double getNaturalGiftPower(){
    return getBerryByNameResponse.data.naturalGiftPower * 0.01;
  }

}
