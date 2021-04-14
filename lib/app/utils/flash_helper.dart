import "package:flash/flash.dart";
import "package:flutter/material.dart";

class FlashHelper {
  static Color _backgroundColor(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.dialogTheme.backgroundColor ?? theme.dialogBackgroundColor;
  }

  static TextStyle _titleStyle(BuildContext context, [Color color]) {
    final ThemeData theme = Theme.of(context);
    return (theme.dialogTheme.titleTextStyle ?? theme.textTheme.headline6)
            ?.copyWith(color: color) ??
        const TextStyle(
          fontSize: 21.0,
          fontWeight: FontWeight.w700,
        );
  }

  static TextStyle _contentStyle(BuildContext context, [Color color]) {
    final ThemeData theme = Theme.of(context);
    return (theme.dialogTheme.contentTextStyle ?? theme.textTheme.bodyText2)
            ?.copyWith(color: color) ??
        const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        );
  }

  static Future<T> successBar<T>(
    BuildContext context, {
    String title,
    @required String message,
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
            message: Text(
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
            leftBarIndicatorColor: Colors.blue[300],
          ),
        );
      },
    );
  }

  static Future<T> errorBar<T>(
    BuildContext context, {
    String title,
    @required String message,
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
            message: Text(
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
            leftBarIndicatorColor: Colors.red[300],
          ),
        );
      },
    );
  }

  static Future<T> infoBar<T>(
    BuildContext context, {
    String title,
    @required String message,
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
            message: Text(
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
            leftBarIndicatorColor: Colors.green[300],
          ),
        );
      },
    );
  }

  static Future<T> simpleDialog<T>(
    BuildContext context, {
    @required String title,
    @required String message,
    Color messageColor,
    List<Widget> actions,
  }) {
    return showFlash<T>(
      context: context,
      persistent: false,
      builder: (
        BuildContext context,
        FlashController<T> controller,
      ) {
        return Flash<T>.dialog(
          controller: controller,
          backgroundColor: _backgroundColor(context),
          margin: const EdgeInsets.only(
            left: 40.0,
            right: 40.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: FlashBar(
            title: Text(
              title,
              style: _titleStyle(context),
            ),
            message: Text(
              message,
              style: _contentStyle(context, messageColor),
            ),
            actions: actions,
          ),
        );
      },
    );
  }
}
