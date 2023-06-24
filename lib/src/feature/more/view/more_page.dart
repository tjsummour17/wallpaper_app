import 'package:app/src/common/providers/locale_provider.dart';
import 'package:app/src/common/providers/theme_provider.dart';
import 'package:app/src/common/resources/assets.dart';
import 'package:app/src/common/utils/build_context_x.dart';
import 'package:app/src/feature/favorites/view/favorites_page.dart';
import 'package:app/src/feature/language/view/select_language_page.dart';
import 'package:app/src/feature/theme/view/select_theme_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider = context.watch();
    ThemeProvider themeProvider = context.watch();
    return Scaffold(
      appBar: AppBar(title: Text(context.localizations.more)),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: context.colorScheme.surface,
            ),
            child: Material(
              color: Colors.transparent,
              elevation: 0,
              child: Column(
                children: [
                  ListTile(
                    leading: SvgPicture.asset(
                      AppSvg.bookmark,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      color: context.colorScheme.onBackground,
                    ),
                    title: Text(context.localizations.favorites),
                    onTap: () =>
                        context.pushNamed(FavoritesPage.routeName),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: context.colorScheme.surface,
            ),
            child: Material(
              color: Colors.transparent,
              elevation: 0,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.language,
                      color: context.colorScheme.primary,
                    ),
                    trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(localeProvider.localeName),
                        Icon(
                          Icons.navigate_next,
                          color: context.colorScheme.onBackground,
                        ),
                      ],
                    ),
                    title: Text(context.localizations.language),
                    onTap: () =>
                        context.pushNamed(SelectLanguagePage.routeName),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.brightness_6_rounded,
                      color: context.colorScheme.primary,
                    ),
                    trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(themeProvider.themeMode.name),
                        Icon(
                          Icons.navigate_next,
                          color: context.colorScheme.onBackground,
                        ),
                      ],
                    ),
                    title: Text(context.localizations.theme),
                    onTap: () => context.pushNamed(SelectThemePage.routeName),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
