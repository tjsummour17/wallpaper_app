import 'dart:io';

import 'package:app/src/common/resources/app_colors.dart';
import 'package:app/src/common/utils/build_context_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.textColor,
    this.isText = false,
    this.color,
    this.icon,
    this.borderRadius = 8,
    super.key,
  });

  factory AppButton.icon({
    required String label,
    required Widget icon,
    required VoidCallback? onPressed,
    Color? textColor,
    Color? color,
  }) =>
      AppButton(
        label: label,
        textColor: textColor,
        onPressed: onPressed,
        color: color,
        icon: icon,
      );

  factory AppButton.secondary({
    required String label,
    required VoidCallback? onPressed,
    Color textColor = Colors.black,
    double borderRadius = 8,
    Color color = const Color(0xffe3effb),
    Widget? icon,
  }) =>
      AppButton(
        label: label,
        onPressed: onPressed,
        borderRadius: borderRadius,
        color: color,
        textColor: textColor,
        icon: icon,
      );

  factory AppButton.text({
    required String label,
    required VoidCallback? onPressed,
    Color? textColor,
    Color? color,
    Widget? icon,
  }) =>
      AppButton(
        label: label,
        onPressed: onPressed,
        isText: true,
        color: color,
        textColor: textColor,
        icon: icon,
      );

  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final Widget? icon;
  final bool isText;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final Widget? icon = this.icon;
    final textWidget = Text(
      label,
      textAlign: TextAlign.center,
      style: context.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: isText
            ? (onPressed == null
                ? AppColors.disabled
                : color ?? context.colorScheme.primary)
            : textColor ?? Colors.white,
      ),
    );
    final Widget text = icon == null
        ? textWidget
        : Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              textWidget,
              const SizedBox(width: 5, height: 5),
              IconTheme(
                data: IconThemeData(
                  color: isText
                      ? (onPressed == null
                          ? AppColors.disabled
                          : color ?? context.colorScheme.primary)
                      : Colors.white,
                ),
                child: icon,
              ),
            ],
          );
    if (Platform.isIOS) {
      return CupertinoButton(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: isText ? 0 : 15,
        ),
        disabledColor: isText ? Colors.transparent : AppColors.disabled,
        color: (isText
            ? Colors.transparent
            : color ?? context.colorScheme.primary),
        borderRadius: BorderRadius.circular(borderRadius),
        child: text,
        onPressed: onPressed,
      );
    } else {
      if (isText) {
        return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          ),
          onPressed: onPressed,
          child: text,
        );
      } else {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(40, 40),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 15,
            ),
            backgroundColor: onPressed == null
                ? AppColors.disabled
                : color ?? context.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: onPressed,
          child: text,
        );
      }
    }
  }
}
