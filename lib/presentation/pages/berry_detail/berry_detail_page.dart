import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/main.dart';

class BerryDetailPage extends ConsumerStatefulWidget {
  final String name;

  const BerryDetailPage({super.key, required this.name});

  @override
  ConsumerState createState() => _BerryDetailPageState();
}

class _BerryDetailPageState extends ConsumerState<BerryDetailPage> {

  @override
  Widget build(BuildContext context) {
    var berryDetailViewModel = ref.watch(berryDetailViewModelImp);

    return Scaffold();
  }
}
