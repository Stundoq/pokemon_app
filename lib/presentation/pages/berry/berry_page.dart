import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/core/constants/assets.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/main.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/pages/berry/berry_viewmodel.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/pages/berry/components/all_berry_widget.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/pages/berry/components/favorite_berry_widget.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/widget/custom_sliver_appbar.dart';

import '../../../core/enums/snack_bar_type.dart';
import '../../../core/utils/utils.dart';
import '../../../translations/locale_keys.g.dart';
import '../../widget/custom_floating_action_button.dart';
import '../../widget/visibility_widget.dart';
import '../pokemon/pokemon_viewmodel.dart';

class BerriesPage extends ConsumerStatefulWidget {
  const BerriesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BerriesPageState();
}

class _BerriesPageState extends ConsumerState<BerriesPage> with SingleTickerProviderStateMixin {
  late int _clickTabIndex;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _clickTabIndex = 0;
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var berryViewModel = ref.watch(berryViewModelImp);
    return Scaffold(
      floatingActionButton: _floatingActionButton(berryViewModel),
      body: Stack(
        children: [
          DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  CustomSliverAppBar(
                    customTitle: 'Berries',
                    path: Assets.pokeBerries,
                  ),
                  CustomSliverPersistentHeader(
                    tabController: _tabController,
                    onTap: (value) {
                      setState(() {
                        _clickTabIndex = value;
                      });
                    },
                    tabList: const [
                      CustomTab(customIcon: Icon(Icons.list), customText: 'All Berries'),
                      CustomTab(customIcon: Icon(Icons.lightbulb_outline), customText: 'Favorites'),
                    ],
                  ),
                ];
              },
              body: _getBody(berryViewModel),
            ),
          ),
          CustomVisibilityWidget(visible: berryViewModel.isDataFetching)

        ],
      ),
    );
  }

  StatefulWidget _getBody(BerryViewModel berryViewModel) {
    return _clickTabIndex == 0
        ? const AllBerryWidget()
        : FavoriteBerryWidget(favoriteBerryList: berryViewModel.getBerryItemList());
  }


  CustomFloatingActionButton? _floatingActionButton(BerryViewModel berryViewModel) {
    if (berryViewModel.isDataFetching) {
      return null;
    }

    final bool isTabIndexZero = _clickTabIndex == 0;
    return CustomFloatingActionButton(
      onPressed: isTabIndexZero
          ? () {
        berryViewModel.getBerry();
      }
          : () {
        berryViewModel.clearAllFavoriteBerry().then((value) {
          Utils.showMessage(
            message: LocaleKeys.pokemon_successful.tr(),
            context: context,
            snackBarType: SnackBarType.success,
          );
          _clickTabIndex = 0;
          _tabController.index = _clickTabIndex;
        });
      },
      title: isTabIndexZero ? LocaleKeys.pokemon_ekstra.tr() : LocaleKeys.pokemon_delete.tr(),
    );
  }

}