import 'package:app/src/common/lang/lang.dart';
import 'package:app/src/common/providers/locale_provider.dart';
import 'package:app/src/common/providers/theme_provider.dart';
import 'package:app/src/common/resources/app_theme.dart';
import 'package:app/src/common/router/app_router.dart';
import 'package:app/src/feature/dashboard/view/dashboard_page.dart';
import 'package:app/src/feature/favorites/view/favorites_page.dart';
import 'package:app/src/feature/favorites/viewmodel/favorites_view_model.dart';
import 'package:app/src/feature/language/view/select_language_page.dart';
import 'package:app/src/feature/search/view/search_page.dart';
import 'package:app/src/feature/theme/view/select_theme_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class ApplicationMaterial extends StatelessWidget {
  const ApplicationMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => LocaleProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => FavoritesViewModel(),
        ),
      ],
      builder: (BuildContext context, Widget? _) {
        return const _ApplicationMaterial();
      },
    );
  }
}

class _ApplicationMaterial extends StatefulWidget {
  const _ApplicationMaterial();

  @override
  State<_ApplicationMaterial> createState() => _ApplicationMaterialState();
}

class _ApplicationMaterialState extends State<_ApplicationMaterial> {
  @override
  void initState() {
    final ThemeProvider themeProvider = context.read();
    final LocaleProvider localeProvider = context.read();
    themeProvider.init();
    localeProvider.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LocaleProvider localeProvider = context.watch();
    final ThemeProvider themeProvider = context.watch();
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: MaterialApp(
        supportedLocales: Lang.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        debugShowCheckedModeBanner: false,
        locale: localeProvider.locale,
        themeMode: themeProvider.themeMode,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        onGenerateRoute: (RouteSettings routeSettings) {
          switch (routeSettings.name) {
            case DashboardPage.routeName:
              return AppRouter.pageRoute<void>(
                context: context,
                routeName: DashboardPage.routeName,
                widget: const DashboardPage(),
              );
            case SearchPage.routeName:
              return AppRouter.pageRoute<void>(
                context: context,
                routeName: SearchPage.routeName,
                widget: const SearchPage(),
              );
            case SelectLanguagePage.routeName:
              return AppRouter.pageRoute<void>(
                context: context,
                routeName: SelectLanguagePage.routeName,
                widget: const SelectLanguagePage(),
              );
            case SelectThemePage.routeName:
              return AppRouter.pageRoute<void>(
                context: context,
                routeName: SelectThemePage.routeName,
                widget: const SelectThemePage(),
              );
            case FavoritesPage.routeName:
              return AppRouter.pageRoute<void>(
                context: context,
                routeName: FavoritesPage.routeName,
                widget: const FavoritesPage(),
              );
            default:
              return AppRouter.pageRoute<void>(
                context: context,
                routeName: DashboardPage.routeName,
                widget: const DashboardPage(),
              );
          }
        },
      ),
    );
  }
}
