import 'package:flutter_tdd_clean_architecture_mvvm/data/models/berries/berry_detail_model.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/data/models/berries/berry_list_model.dart';

import '../../models/pokemon_detail_model.dart';
import '../../models/pokemon_list_model.dart';

abstract class RemoteDataSource {
  Future<PokemonListModel> getPokemon(String? url);

  Future<PokemonDetailModel> getPokemonByName(String name);

  Future<BerryListModel> getBerry(String? url);

  Future<BerryDetailModel> getBerryByName(String name);


}
