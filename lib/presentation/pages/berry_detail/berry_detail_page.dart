import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/core/api_helper/api_response.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/core/extension/response_event.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/main.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/pages/berry_detail/berry_detail_viewmodel.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/widget/custom_loading_widget.dart';

import '../../../core/constants/assets.dart';
import '../../../translations/locale_keys.g.dart';
import '../../widget/animated_percentage_indicator.dart';
import '../../widget/error_widget.dart';

class BerryDetailPage extends ConsumerStatefulWidget {
  final String name;

  const BerryDetailPage({super.key, required this.name});

  @override
  ConsumerState createState() => _BerryDetailPageState();
}

class _BerryDetailPageState extends ConsumerState<BerryDetailPage> {
  @override
  void deactivate() {
    super.deactivate();
    ref.read(berryDetailViewModelImp).getBerryByNameResponse.toLoading();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var berryDetailViewModel = ref.watch(berryDetailViewModelImp);

    return Scaffold(
      appBar: berryDetailViewModel.getBerryByNameResponse.isError()
          ? _errorAppBar()
          : null,
      body: _body(berryDetailViewModel),
    );
  }

  Widget _getBerryByName({required BerryDetailViewModel berryDetailViewModel}) {
    switch (berryDetailViewModel.getBerryByNameResponse.status) {
      case Status.loading:
        {
          berryDetailViewModel.getBerryByName(name: widget.name);
          return const CustomLoadingWidget();
        }
      case Status.completed:
        {
          return CustomScrollView(
            slivers: [
              _sliverAppBar(berryDetailViewModel),
              _sliverPadding(berryDetailViewModel)
            ],
          );
        }

      default:
        {
          return const SizedBox();
        }
    }
  }

  SliverAppBar _sliverAppBar(BerryDetailViewModel berryDetailViewModel) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: _richText(berryDetailViewModel),
        background: _stack(berryDetailViewModel),
      ),
    );
  }

  RichText _richText(BerryDetailViewModel berryDetailViewModel) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: "${berryDetailViewModel.getBerryName()} ",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          TextSpan(
            text: berryDetailViewModel.getNaturalGiftName(),
            style: TextStyle(
                fontWeight: FontWeight.w200,
                color: Colors.grey.shade200,
                fontSize: 12),
          ),
        ],
      ),
    );
  }

  Stack _stack(BerryDetailViewModel berryDetailViewModel) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const FadeInImage(
          placeholder: AssetImage(Assets.loading),
          image: AssetImage(Assets.pokeBerries),
          fadeInDuration: Duration(milliseconds: 200),
          fadeOutDuration: Duration(milliseconds: 200),
          fit: BoxFit.cover,
          placeholderFit: BoxFit.cover,
        ),
        Positioned(
          bottom: 0,
          top: 0,
          right: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _getText("Büyüklük: ${berryDetailViewModel.getBerrySize()}"),
              _getText("Pürüzsüzlük: ${berryDetailViewModel.getSmoothness()}"),
              _getText("Sertlik: ${berryDetailViewModel.getFirmnessType()}"),
            ],
          ),
        )
      ],
    );
  }

  Text _getText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 12,
      ),
    );
  }

  SliverPadding _sliverPadding(BerryDetailViewModel berryDetailViewModel) {
    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverGrid(
        delegate: SliverChildListDelegate(
          [
            AnimatedPercentageIndicator(
              percent:
                  berryDetailViewModel.getNaturalGiftPower(),
              txt: 'Doğal Güç:',
            ),
            AnimatedPercentageIndicator(
              percent:
                  berryDetailViewModel.getBerryAttributes().sweet,
              txt: 'Tatlılık',
            ),
            AnimatedPercentageIndicator(
              percent:
                  berryDetailViewModel.getBerryAttributes().bitter,
              txt: 'Bitter',
            ),
            AnimatedPercentageIndicator(
              percent:
                  berryDetailViewModel.getBerryAttributes().sour,
              txt: 'Ekşilik:',
            ),
            AnimatedPercentageIndicator(
              percent: berryDetailViewModel.getBerryAttributes().dry,
              txt: 'Kuruluk:',
            ),
            AnimatedPercentageIndicator(
              percent:
                  berryDetailViewModel.getBerryAttributes().spicy,
              txt: 'Acılık:',
            ),
          ],
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }

  Widget _body(BerryDetailViewModel berryDetailViewModel) {
    if (berryDetailViewModel.getBerryByNameResponse.isError()) {
      return CustomErrorWidget(
        title: LocaleKeys.pokemon_occurred_pokemon,
        description: LocaleKeys.pokemon_try_again.tr(),
        onTap: () {
          berryDetailViewModel.getBerryByName(name: widget.name);
        },
      );
    } else {
      return _getBerryByName(berryDetailViewModel: berryDetailViewModel);
    }
  }

  AppBar _errorAppBar() {
    return AppBar(
      title: Text(LocaleKeys.pokemon_detail_page.tr()),
    );
  }
}
