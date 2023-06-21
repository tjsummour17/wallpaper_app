import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

extension BuildContextX on BuildContext {
  AppLocalizations get localizations =>
      AppLocalizations.of(this) ?? AppLocalizationsEn();

  String get localeName => AppLocalizations.of(this)?.localeName ?? 'en';

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  OverlayState get overlay => Overlay.of(this);

  Future<T?> push<T>(Widget widget, {String? routeName}) =>
      Navigator.of(this).push<T?>(
        theme.platform == TargetPlatform.iOS
            ? CupertinoPageRoute(
                settings: RouteSettings(name: routeName),
                builder: (BuildContext context) => widget,
              )
            : MaterialPageRoute(
                settings: RouteSettings(name: routeName),
                builder: (BuildContext context) => widget,
              ),
      );

  void pushReplacement(Widget widget, {String? routeName}) =>
      Navigator.of(this).pushReplacement(
        theme.platform == TargetPlatform.iOS
            ? CupertinoPageRoute(
                settings: RouteSettings(name: routeName),
                builder: (BuildContext context) => widget,
              )
            : MaterialPageRoute(
                settings: RouteSettings(name: routeName),
                builder: (BuildContext context) => widget,
              ),
      );

  Future<dynamic> pushNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);

  Future<dynamic> pushReplacementNamed(String routeName) =>
      Navigator.of(this).pushReplacementNamed(routeName);

  Future<dynamic> openPopUp({
    required Widget popUpWidget,
    bool barrierDismissible = true,
  }) =>
      Navigator.push(
        this,
        theme.platform == TargetPlatform.iOS
            ? CupertinoDialogRoute(
                context: this,
                barrierDismissible: barrierDismissible,
                builder: (context) => popUpWidget,
              )
            : DialogRoute(
                context: this,
                barrierDismissible: barrierDismissible,
                builder: (context) => popUpWidget,
              ),
      );

  Future<T?> openBottomSheet<T>({
    required bool isScrollControlled,
    required Widget bottomSheet,
  }) {
    if (theme.platform == TargetPlatform.iOS) {
      return showCupertinoModalPopup<T>(
        context: this,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Material(
            color: Colors.transparent,
            elevation: 0,
            child: bottomSheet,
          ),
        ),
      );
    } else {
      return showModalBottomSheet<T>(
        context: this,
        isScrollControlled: isScrollControlled,
        clipBehavior: Clip.hardEdge,
        backgroundColor: Colors.transparent,
        elevation: 0,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: bottomSheet,
        ),
      );
    }
  }

  void showSnackBar({required String message, SnackBarAction? action}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void pop([dynamic result]) => Navigator.of(this).pop(result);

  void popUntil(bool Function(Route<dynamic>) predicate) =>
      Navigator.of(this).popUntil(predicate);
}
