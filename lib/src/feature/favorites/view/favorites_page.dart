import 'package:app/src/common/resources/assets.dart';
import 'package:app/src/common/utils/build_context_x.dart';
import 'package:app/src/common/widgets/loading_widget.dart';
import 'package:app/src/feature/favorites/viewmodel/favorites_view_model.dart';
import 'package:app/src/feature/search/widgets/search_image_countainer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  static const String routeName = '/Favorites';

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    FavoritesViewModel viewModel = context.read();
    viewModel.fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final FavoritesViewModel viewModel = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.favorites),
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          if (viewModel.isLoading)
            const Expanded(child: LoadingWidget())
          else if (viewModel.photos.isNotEmpty)
            Expanded(
              child: NotificationListener(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!viewModel.noMoreItems) {
                    if (!viewModel.isLoadingNextPage) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                        viewModel.getMore(search: '');
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
            )
          else
            Expanded(
              child: Center(
                child: Lottie.asset(
                  AppLottie.emptyBox,
                  repeat: false,
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
