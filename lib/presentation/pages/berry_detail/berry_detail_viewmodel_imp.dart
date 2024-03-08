import 'package:flutter/cupertino.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_detail_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/flavor_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/usecases/berries/berry_usecases.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/pages/berry_detail/berry_detail_viewmodel.dart';

import '../../../core/api_helper/api_response.dart';
import '../../../injection.dart';

class BerryDetailViewModelImp with ChangeNotifier implements BerryDetailViewModel{

  ApiResponse<BerryDetailEntity> _getBerryByNameResponse = ApiResponse.loading('loading');

  @override
  ApiResponse<BerryDetailEntity> get getBerryByNameResponse => _getBerryByNameResponse;

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
      BerryDetailEntity berryDetailEntity = await injector<GetBerryByName>().execute(
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
  String getBerryName(){
    return getBerryByNameResponse.data.name;
  }

  @override
  String getFirmness(){
    return getBerryByNameResponse.data.firmness.name;
  }

  @override
  String getFlavorImage(){
    final FlavorEntity flavors = getBerryByNameResponse.data.flavors;

  }
}