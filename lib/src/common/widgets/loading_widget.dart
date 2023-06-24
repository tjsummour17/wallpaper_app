import 'package:app/src/common/resources/assets.dart';
import 'package:app/src/common/utils/build_context_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.color,
    this.indicatorColor,
    this.size,
  }) : super(key: key);

  final Color? color;
  final Color? indicatorColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.colorScheme.surface.withOpacity(0.3);
    return ColoredBox(
      color: color,
      child: Center(
        child: context.theme.platform == TargetPlatform.iOS
            ? CupertinoActivityIndicator(
                color: indicatorColor ?? context.colorScheme.onSurface,
              )
            : indicatorColor == null
                ? LottieBuilder.asset(
                    AppLottie.circularLoading,
                    width: size ?? 100,
                    height: size ?? 100,
                  )
                : CircularProgressIndicator(
                    color: indicatorColor ?? context.colorScheme.onSurface,
                  ),
      ),
    );
  }
}
