import 'package:app/src/common/widgets/loading_widget.dart';
import 'package:app/src/feature/search/viewmodel/search_view_model.dart';
import 'package:app/src/feature/search/widgets/search_image_countainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    super.key,
    required this.category,
    required this.title,
  });

  final String category;
  final String title;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (BuildContext context) => SearchViewModel(),
        builder: (BuildContext context, Widget? _) => _SearchPage(
          category: category,
          title: title,
        ),
      );
}

class _SearchPage extends StatefulWidget {
  const _SearchPage({
    required this.category,
    required this.title,
  });

  final String category;
  final String title;

  @override
  State<_SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<_SearchPage> {
  @override
  void initState() {
    super.initState();
    SearchViewModel viewModel = context.read();
    viewModel.search(search: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    final SearchViewModel viewModel = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                        viewModel.getMore(search: widget.category);
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
