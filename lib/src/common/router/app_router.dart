import 'package:app/src/common/utils/build_context_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static Route pageRoute<T>({
    required BuildContext context,
    required Widget widget,
    required String routeName,
  }) {
    return context.theme.platform == TargetPlatform.iOS
        ? CupertinoPageRoute<T>(
      builder: (BuildContext context) => widget,
      settings: RouteSettings(
        name: routeName,
      ),
    )
        : MaterialPageRoute<T>(
      builder: (BuildContext context) => widget,
      settings: RouteSettings(
        name: routeName,
      ),
    );
  }

  static Route dialogRoute<T>({
    required BuildContext context,
    required Widget widget,
  }) {
    return context.theme.platform == TargetPlatform.iOS
        ? CupertinoDialogRoute<T>(
      context: context,
      builder: (BuildContext context) => widget,
    )
        : DialogRoute<T>(
      context: context,
      builder: (BuildContext context) => widget,
    );
  }
}
