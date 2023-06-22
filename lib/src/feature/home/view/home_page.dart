import 'package:app/src/common/utils/build_context_x.dart';
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
      appBar: AppBar(scrolledUnderElevation: 0),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => context.pushNamed(SearchPage.routeName),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Find wallpaper...',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(CupertinoIcons.search),
                  )
                ],
              ),
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                child: Text(
                  'Best of the month',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (viewModel.trending.isNotEmpty)
            CarouselSlider.builder(
              itemCount: viewModel.trending.length,
              itemBuilder: (context, index, realIndex) {
                return ContainerWidget(
                  imageUrl: viewModel.trending[index].src.original,
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                height: 210,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 1000,
                ),
              ),
            )
          else
            const SizedBox(),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => NaturePage(),
                      //   ),
                      // );
                    },
                    title: 'Nature',
                    imageUrl: viewModel.nature.src.original,
                  ),
                  if (viewModel.cars.id != -1)
                    ImageContainer(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SportCarsPage(),
                        //   ),
                        // );
                      },
                      title: 'Cars',
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
                  //item one.
                  ImageContainer(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => AnimalsPage(),
                      //   ),
                      // );
                    },
                    title: 'Animals',
                    imageUrl: viewModel.animals.src.original,
                  ),
                  if (viewModel.anime.id != -1)
                    ImageContainer(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => AnimePage(),
                        //   ),
                        // );
                      },
                      title: 'Anime',
                      imageUrl: viewModel.anime.src.original,
                    ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
