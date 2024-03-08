import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/core/api_helper/api_response.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/core/extension/response_event.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/main.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/pages/berry_detail/berry_detail_viewmodel.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/widget/custom_loading_widget.dart';

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
      appBar: AppBar(),
      body: _getBerryByName(berryDetailViewModel: berryDetailViewModel),
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
          return Column(
            children: [
              Text(berryDetailViewModel.getFirmnessType()),
              Text('${berryDetailViewModel.getBerryAttributes().bitter}'),
              Text('${berryDetailViewModel.getBerryAttributes().dry}'),
              Text('${berryDetailViewModel.getBerryAttributes().sour}'),
              Text('${berryDetailViewModel.getBerryAttributes().spicy}'),
              Text('${berryDetailViewModel.getBerryAttributes().sweet}'),
            ],
          );
        }

      default:
        {
          return const SizedBox();
        }
    }
  }
}
