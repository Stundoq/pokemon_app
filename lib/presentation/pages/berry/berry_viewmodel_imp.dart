import 'package:flutter/cupertino.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_list_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/usecases/berries/berry_usecases.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/pages/berry/berry_viewmodel.dart';

import '../../../core/api_helper/api_response.dart';
import '../../../injection.dart';

class BerryViewModelImp with ChangeNotifier implements BerryViewModel{
  ApiResponse<BerryListEntity> _berryListResponse = ApiResponse.loading('loading');

  @override
  ApiResponse<BerryListEntity> get berryListResponse => _berryListResponse;

  @override
  set berryListResponse(ApiResponse<BerryListEntity> value) {
    _berryListResponse = value;
    notifyListeners();
  }

  String? _nextPage;

  bool _isDataFetching = false;

  @override
  bool get isDataFetching => _isDataFetching;

  @override
  set isDataFetching(bool value) {
    _isDataFetching = value;
    notifyListeners();
  }

  @override
  Future<void> getBerry() async {
    isDataFetching = true;


    try {
      BerryListEntity berryListEntity;

      if (_nextPage != null) {
        berryListEntity = await injector<GetBerry>().execute(
          ParamsForBerry(_nextPage),
        );

        berryListResponse.data.berries.addAll(berryListEntity.berries);
        _nextPage = berryListEntity.next;
      } else {
        berryListResponse = ApiResponse.loading("loading");
        berryListEntity = await injector<GetBerry>().execute(
          ParamsForBerry(_nextPage),
        );
        _nextPage = berryListEntity.next;
        berryListResponse = ApiResponse.completed(berryListEntity);
      }
    } catch (e) {
      berryListResponse = ApiResponse.error(e);
    }

    isDataFetching = false;
  }

  @override
  int berryListLength() {
    return berryListResponse.data.berries.length;
  }
}