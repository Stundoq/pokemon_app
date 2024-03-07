import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/core/extension/response_event.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/main.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/pages/berry/berry_viewmodel.dart';

import '../../../../core/api_helper/api_response.dart';
import '../../../../core/enums/snack_bar_type.dart';
import '../../../../core/utils/utils.dart';
import '../../../../domain/entities/berry_entities/berry_list_entity.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../widget/custom_loading_widget.dart';
import '../../../widget/error_widget.dart';
import '../../../widget/item_widget.dart';

class AllBerryWidget extends ConsumerStatefulWidget {
  const AllBerryWidget({super.key});

  @override
  ConsumerState createState() => _AllBerryWidgetState();
}

class _AllBerryWidgetState extends ConsumerState<AllBerryWidget> {
  Widget _getBerry({required BerryViewModel berryViewModel}) {
    switch (berryViewModel.berryListResponse.status) {
      case Status.loading:
        {
          return const CustomLoadingWidget();
        }
      case Status.completed:
        {
          return ListView.builder(
            itemCount: berryViewModel.berryListLength(),
            itemBuilder: (context, index) {
              return _itemWidget(berryViewModel, index, context);
            },
          );
        }

      default:
        {
          return const SizedBox();
        }
    }
  }

  Widget _itemWidget(
      BerryViewModel berryViewModel, int index, BuildContext context) {
    var berryNameByIndex = berryViewModel.getBerryNameByIndex(index);
    var berryInFavorites = berryViewModel.isBerryInFavorites(berryNameByIndex);


    return ItemWidget(
      onTap: () {},
      title: berryNameByIndex,
      subtitle: index.toString(),
      isActive: berryInFavorites,
        favoriteButton: () {
          if (!berryInFavorites) {
            berryViewModel
                .addBerryByName(index)
                .then((value) => _showMessage(context, LocaleKeys.pokemon_saved_to_favorites.tr()));
          } else {
            berryViewModel
                .removeBerryByName(index)
                .then((value) => _showMessage(context, LocaleKeys.pokemon_deleted_from_favorites.tr()));
          }
        }
    );
  }

  void _showMessage(BuildContext context, String message) {
    return Utils.showMessage(
      message: message,
      context: context,
      snackBarType: SnackBarType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    BerryViewModel berryViewModel = ref.watch(berryViewModelImp);

    return berryViewModel.berryListResponse.isError()
        ? CustomErrorWidget(
            title: LocaleKeys.pokemon_an_error_occurred.tr(),
            description: LocaleKeys.pokemon_try_again.tr(),
            onTap: () {
              berryViewModel.getBerry();
            },
          )
        : _getBerry(berryViewModel: berryViewModel);
  }
}
