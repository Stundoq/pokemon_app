import 'package:flutter/cupertino.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_detail_entity.dart';

import '../../../core/api_helper/api_response.dart';

abstract class BerryDetailViewModel with ChangeNotifier{

  ApiResponse<BerryDetailEntity> get getBerryByNameResponse;

  set getBerryByNameResponse(ApiResponse<BerryDetailEntity> value);

  Future<void> getBerryByName({
    required String name,
  });

  String getBerryName();

  String getFirmness();

  String getBerryFlavor();
}