import 'dart:async';

import 'package:app/src/common/resources/assets.dart';
import 'package:app/src/common/utils/build_context_x.dart';
import 'package:app/src/common/widgets/loading_widget.dart';
import 'package:app/src/feature/search/viewmodel/search_view_model.dart';
import 'package:app/src/feature/search/widgets/search_image_countainer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static const String routeName = '/Search';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (BuildContext context) => SearchViewModel(),
        builder: (BuildContext context, Widget? _) => const _SearchPage(),
      );
}

class _SearchPage extends StatefulWidget {
  const _SearchPage();

  @override
  State<_SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<_SearchPage> {
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  void onSearchChanged(String searchKey) {
    final SearchViewModel viewModel = context.read();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      viewModel.search(
        search: searchKey,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    SearchViewModel viewModel = context.read();
    viewModel.search(search: '');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SearchViewModel viewModel = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.search),
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
              onChanged: onSearchChanged,
              controller: searchController,
              decoration: InputDecoration(
                hintText: context.localizations.findMoreWallpapers,
              ),
            ),
          ),
          if (viewModel.isLoading)
            Expanded(
              child: Center(
                child: Lottie.asset(
                  AppLottie.photoSearch,
                  width: 150,
                  height: 150,
                ),
              ),
            )
          else if (viewModel.photos.isNotEmpty)
            Expanded(
              child: NotificationListener(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!viewModel.noMoreItems) {
                    if (!viewModel.isLoadingNextPage) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                        viewModel.getMore(search: searchController.text);
                      }
                    }
                  }
                  return false;
                },
                child: MasonryGridView.count(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  physics: const BouncingScrollPhysics(),
                  itemCount: viewModel.photos.length,
                  itemBuilder: (context, index) {
                    return SearchImageContainer(
                      photo: viewModel.photos[index],
                    );
                  },
                ),
              ),
            ),
          if (viewModel.isLoadingNextPage)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: LoadingWidget(),
            )
        ],
      ),
    );
  }
}
