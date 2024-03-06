import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/core/extension/response_event.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/main.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/pages/berry/berry_viewmodel.dart';

import '../../../../core/api_helper/api_response.dart';
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

  late ApiResponse<BerryListEntity> _berryListResponse;

  @override
  void initState() {
    // TODO: implement initState
    _berryListResponse = ApiResponse.loading('loading');

    super.initState();
  }

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
              return _itemWidget(berryViewModel, context);
            },
          );
        }

      default:
        {
          return const SizedBox();
        }
    }
  }


  Widget _itemWidget(BerryViewModel berryViewModel, BuildContext context) {

    return ItemWidget(
      title: _berryListResponse.data.berries[0].name,
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
