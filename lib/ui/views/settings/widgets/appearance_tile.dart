import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:steps_tracker/app/utils/colors.dart';

class AppearanceTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function() onTap;
  final bool isActive;

  const AppearanceTile({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(text),
      trailing: isActive
          ? Icon(
              Icons.check,
              color: KColors.orange,
            )
          : null,
      onTap: onTap,
    );
  }
}
