import "package:flutter/material.dart";
import 'package:steps_tracker/app/utils/colors.dart';

class LanguageTile extends StatelessWidget {
  final String title;
  final String emoji;
  final bool showCheck;
  final Function() onTap;

  const LanguageTile({
    Key? key,
    required this.title,
    required this.emoji,
    required this.showCheck,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(emoji),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      trailing: showCheck
          ? Icon(
              Icons.check,
              color: KColors.orange,
            )
          : null,
      onTap: onTap,
    );
  }
}
