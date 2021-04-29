import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:easy_localization/easy_localization.dart';

import 'package:steps_tracker/app/global/validators.dart';
import 'package:steps_tracker/app/translations/locale_keys.g.dart';
import 'package:steps_tracker/app/utils/colors.dart';

class VerificationUI extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onPressed;

  const VerificationUI({
    Key key,
    @required this.controller,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 35),
          Text(
            LocaleKeys.widgets_verification_ui_verify_phone_number.tr(),
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            LocaleKeys.widgets_verification_ui_be_patient_sms_code_sent.tr(),
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          const SizedBox(height: 25),
          TextFormField(
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              labelText:
                  LocaleKeys.widgets_verification_ui_verification_code.tr(),
              errorMaxLines: 2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (String verificationCode) {
              return validateVerificationCode(verificationCode);
            },
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: KColors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                LocaleKeys.widgets_verification_ui_verify.tr(),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
