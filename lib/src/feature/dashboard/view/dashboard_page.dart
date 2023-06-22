import 'package:app/src/common/utils/build_context_x.dart';
import 'package:app/src/feature/home/view/home_page.dart';
import 'package:app/src/feature/more/view/more_page.dart';
import 'package:app/src/feature/search/view/search_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentPage = 0;

  void onPageChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  final List _pages = const [
    HomePage(),
    SearchPage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: onPageChange,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: context.localizations.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: context.localizations.search,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.density_medium_rounded),
            label: context.localizations.more,
          ),
        ],
      ),
    );
  }
}
