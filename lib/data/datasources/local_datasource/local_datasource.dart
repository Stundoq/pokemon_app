import 'package:flutter_tdd_clean_architecture_mvvm/data/models/berries/berry_list_model.dart';

import '../../../domain/entities/pokemon_item_entity.dart';
import '../../models/pokemon_list_model.dart';

abstract class LocalDataSource {


  PokemonItem? isPokemonInFavorites(String key);

  Future<PokemonItem?> addPokemonByName(PokemonItem pokemonItem);

  Future<PokemonItem?> removePokemonByName(String key);

  List<PokemonItem> getFavoritePokemonList();

  Future<int>  clearAllFavoritePokemon();

  Future<int>  clearAllFavoriteBerry();

  List<BerryItem> getFavoriteBerryList();

  BerryItem? isBerryInFavorites(String key);

  Future<BerryItem?> addBerryByName(BerryItem berryItem);

  Future<BerryItem?> removeBerryByName(String key);
}
