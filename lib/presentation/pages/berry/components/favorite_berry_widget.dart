import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_item_entity.dart';
import '../../../../core/helper/keyboard_unfocus.dart';
import '../../../../domain/entities/pokemon_item_entity.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../widget/custom_grid_delegate.dart';
import '../../../widget/favorite_item_widget.dart';


class FavoriteBerryWidget extends StatefulWidget {
  final List<BerryItemEntity> favoriteBerryList;

  const FavoriteBerryWidget({Key? key, required this.favoriteBerryList}) : super(key: key);

  @override
  State<FavoriteBerryWidget> createState() => _FavoriteBerryWidgetState();
}

class _FavoriteBerryWidgetState extends State<FavoriteBerryWidget> {
  late final TextEditingController _searchController;
  late List<BerryItemEntity> _filteredBerry;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredBerry = [];
    _filteredBerry = widget.favoriteBerryList;
    _searchController.addListener(_filterPokemonList);
  }

  void _filterPokemonList() {
    String searchText = _searchController.text.toLowerCase();
    setState(() {
      _filteredBerry =
          widget.favoriteBerryList.where((berry) => berry.name.toLowerCase().contains(searchText)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardFocus.unFocus(
      child: Column(
        children: [
          _searchPokemonWidget(),
          _buildExpanded(),
        ],
      ),
    );
  }

  Expanded _buildExpanded() {
    return Expanded(
      child: GridView.builder(
        itemCount: _filteredBerry.length,
        padding: const EdgeInsets.all(12),
        scrollDirection: Axis.horizontal,
        gridDelegate: CustomGridDelegate(),
        itemBuilder: (context, index) {
          return FavoriteItemWidget(
            name: _filteredBerry[index].name,
            index: index.toString(),
            url: _filteredBerry[index].url,
          );
        },
      ),
    );
  }

  Padding _searchPokemonWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: LocaleKeys.pokemon_search_pokemon.tr(),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
