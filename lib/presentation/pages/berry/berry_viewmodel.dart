import 'package:flutter/cupertino.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_item_entity.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_list_entity.dart';
import '../../../core/api_helper/api_response.dart';

abstract class BerryViewModel with ChangeNotifier{
  ApiResponse<BerryListEntity> get berryListResponse;

  set berryListResponse(ApiResponse<BerryListEntity> value);

  Future<void> getBerry();

  int berryListLength();

  String getBerryNameByIndex(int pokemonIndex);

  bool get isDataFetching;

  set isDataFetching(bool value);

  Future clearAllFavoriteBerry();

  List<BerryItemEntity> getBerryItemList();

  bool isBerryInFavorites(String key);

  Future<void> addBerryByName(int index);

  Future<void> removeBerryByName(int index);
}