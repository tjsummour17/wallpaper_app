import 'package:app/src/common/utils/build_context_x.dart';
import 'package:app/src/feature/categories/view/category_page.dart';
import 'package:app/src/feature/home/viewmodel/home_view_model.dart';
import 'package:app/src/feature/home/widgets/container_widget.dart';
import 'package:app/src/feature/home/widgets/image_container.dart';
import 'package:app/src/feature/search/view/search_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (BuildContext context) => HomeViewModel(),
        builder: (BuildContext context, Widget? _) => const _HomePage(),
      );
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => context.pushNamed(SearchPage.routeName),
          child: Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    context.localizations.findMoreWallpapers,
                    style: context.textTheme.titleSmall,
                  ),
                ),
                const Icon(CupertinoIcons.search)
              ],
            ),
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text(
                  context.localizations.trendingTitle,
                  style: context.textTheme.titleMedium,
                ),
              ),
            ],
          ),
          if (viewModel.trending.isNotEmpty)
            CarouselSlider.builder(
              itemCount: viewModel.trending.length,
              itemBuilder: (context, index, realIndex) {
                return ContainerWidget(
                  photo: viewModel.trending[index],
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayAnimationDuration: const Duration(seconds: 1),
              ),
            )
          else
            const SizedBox(),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text(
                  context.localizations.categories,
                  style: context.textTheme.titleMedium,
                ),
              ),
            ],
          ),
          if (viewModel.nature.id != -1)
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageContainer(
                    onTap: () => context.push(
                      CategoryPage(
                        category: 'nature',
                        title: context.localizations.nature,
                      ),
                    ),
                    title: context.localizations.nature,
                    imageUrl: viewModel.nature.src.original,
                  ),
                  if (viewModel.cars.id != -1)
                    ImageContainer(
                      onTap: () => context.push(
                        CategoryPage(
                          category: 'Cars',
                          title: context.localizations.cars,
                        ),
                      ),
                      title: context.localizations.cars,
                      imageUrl: viewModel.cars.src.original,
                    ),
                ],
              ),
            ),
          if (viewModel.animals.id != -1)
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageContainer(
                    onTap: () => context.push(
                      CategoryPage(
                        category: 'Animals',
                        title: context.localizations.animal,
                      ),
                    ),
                    title: context.localizations.animal,
                    imageUrl: viewModel.animals.src.original,
                  ),
                  if (viewModel.lifeStyle.id != -1)
                    ImageContainer(
                      onTap: () => context.push(
                        CategoryPage(
                          category: 'Life Style',
                          title: context.localizations.lifeStyle,
                        ),
                      ),
                      title: context.localizations.lifeStyle,
                      imageUrl: viewModel.lifeStyle.src.original,
                    ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
