import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/core/constants/assets.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/pages/berry/components/all_berry_widget.dart';
import 'package:flutter_tdd_clean_architecture_mvvm/presentation/widget/custom_sliver_appbar.dart';

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
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
              body: AllBerryWidget(),
            ),
          ),
        ],
      ),
    );
  }
}