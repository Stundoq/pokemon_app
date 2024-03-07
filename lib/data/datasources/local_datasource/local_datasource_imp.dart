import 'package:hive_flutter/hive_flutter.dart';
import '../../models/berries/berry_list_model.dart';
import '../../models/pokemon_list_model.dart';
import 'local_datasource.dart';

class LocalDataSourceImp implements LocalDataSource {
  final Box box;

  LocalDataSourceImp({required this.box});

  @override
  PokemonItem? isPokemonInFavorites(String key) {
    PokemonItem? pokemonItem = box.get(key);
    return pokemonItem;
  }

  @override
  Future<PokemonItem?> addPokemonByName(PokemonItem pokemonItem) async {
    await box.put(pokemonItem.name, pokemonItem);
    return box.get(pokemonItem.name);
  }

  @override
  Future<PokemonItem?> removePokemonByName(String key) async {
    await box.delete(key);
    return box.get(key);
  }

  @override
  List<PokemonItem> getFavoritePokemonList() {
    List<PokemonItem> pokemonList = [];
    for (var key in box.keys) {
      final pokemonItem = box.get(key);
      if (pokemonItem is PokemonItem) {
        pokemonList.add(pokemonItem);
      }
    }
    return pokemonList;
  }

  @override
  Future<int> clearAllFavoritePokemon() async {
    return await box.clear();
  }

  @override
  Future<int> clearAllFavoriteBerry() async {
    return await box.clear();
  }

  @override
  List<BerryItem> getFavoriteBerryList() {
    List<BerryItem> berryList = [];
    for (var key in box.keys) {
      final berryItem = box.get(key);
      if (berryItem is BerryItem) {
        berryList.add(berryItem);
      }
    }
    return berryList;
  }

  @override
  BerryItem? isBerryInFavorites(String key) {
    BerryItem? berryItem = box.get(key);
    return berryItem;
  }

  @override
  Future<BerryItem?> addBerryByName(BerryItem berryItem) async {
    await box.put(berryItem.name, berryItem);
    return box.get(berryItem.name);
  }

  @override
  Future<BerryItem?> removeBerryByName(String key) async {
    await box.delete(key);
    return box.get(key);
  }
}
