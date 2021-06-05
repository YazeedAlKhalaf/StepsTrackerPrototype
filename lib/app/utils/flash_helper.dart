import "package:flash/flash.dart";
import "package:flutter/material.dart";

class FlashHelper {
  static Color _backgroundColor(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.dialogTheme.backgroundColor ?? theme.dialogBackgroundColor;
  }

  static TextStyle _titleStyle(BuildContext context, [Color? color]) {
    final ThemeData theme = Theme.of(context);
    return (theme.dialogTheme.titleTextStyle ?? theme.textTheme.headline6)
            ?.copyWith(color: color) ??
        const TextStyle(
          fontSize: 21.0,
          fontWeight: FontWeight.w700,
        );
  }

  static TextStyle _contentStyle(BuildContext context, [Color? color]) {
    final ThemeData theme = Theme.of(context);
    return (theme.dialogTheme.contentTextStyle ?? theme.textTheme.bodyText2)
            ?.copyWith(color: color) ??
        const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        );
  }

  static Future<T?> successBar<T>(
    BuildContext context, {
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (
        BuildContext context,
        FlashController<T> controller,
      ) {
        return Flash<T>(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          child: FlashBar(
            title: title == null
                ? null
                : Text(
                    title,
                    style: _titleStyle(
                      context,
                      Colors.white,
                    ),
                  ),
            content: Text(
              message,
              style: _contentStyle(
                context,
                Colors.white,
              ),
            ),
            icon: Icon(
              Icons.check_circle,
              color: Colors.blue[300],
            ),
            indicatorColor: Colors.blue[300],
          ),
        );
      },
    );
  }

  static Future<T?> errorBar<T>(
    BuildContext context, {
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (
        BuildContext context,
        FlashController<T> controller,
      ) {
        return Flash<T>(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          child: FlashBar(
            title: title == null
                ? null
                : Text(
                    title,
                    style: _titleStyle(
                      context,
                      Colors.white,
                    ),
                  ),
            content: Text(
              message,
              style: _contentStyle(
                context,
                Colors.white,
              ),
            ),
            icon: Icon(
              Icons.warning,
              color: Colors.red[300],
            ),
            indicatorColor: Colors.red[300],
          ),
        );
      },
    );
  }

  static Future<T?> infoBar<T>(
    BuildContext context, {
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (
        BuildContext context,
        FlashController<T> controller,
      ) {
        return Flash<T>(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          child: FlashBar(
            title: title == null
                ? null
                : Text(
                    title,
                    style: _titleStyle(
                      context,
                      Colors.white,
                    ),
                  ),
            content: Text(
              message,
              style: _contentStyle(
                context,
                Colors.white,
              ),
            ),
            icon: Icon(
              Icons.info_outline,
              color: Colors.green[300],
            ),
            indicatorColor: Colors.green[300],
          ),
        );
      },
    );
  }

  static Future<T?> simpleDialog<T>(
    BuildContext context, {
    String? title,
    required String message,
    Color? messageColor,
    ChildBuilder<T>? negativeAction,
    ChildBuilder<T>? positiveAction,
  }) {
    return showFlash<T>(
      context: context,
      persistent: true,
      builder: (context, controller) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Flash.dialog(
              controller: controller,
              boxShadows: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(0, 0),
                  blurRadius: 10,
                  spreadRadius: 3,
                ),
              ],
              backgroundColor: _backgroundColor(context),
              margin: const EdgeInsets.only(left: 40.0, right: 40.0),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: FlashBar(
                title: title == null
                    ? null
                    : Text(title, style: _titleStyle(context)),
                content:
                    Text(message, style: _contentStyle(context, messageColor)),
                actions: <Widget>[
                  if (negativeAction != null)
                    negativeAction(context, controller, setState),
                  if (positiveAction != null)
                    positiveAction(context, controller, setState),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

typedef ChildBuilder<T> = Widget Function(
    BuildContext context, FlashController<T> controller, StateSetter setState);
