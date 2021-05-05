import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import 'package:steps_tracker/app/global/validators.dart';
import 'package:steps_tracker/app/translations/locale_keys.g.dart';
import 'package:steps_tracker/app/utils/colors.dart';

import 'bmi_calculator_view_model.dart';

class BmiCalculatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BmiCalculatorViewModel(),
      builder: (
        BuildContext context,
        BmiCalculatorViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.views_bmi_calculator_bmi_calculator.tr(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: model.bmiCalculatorFormKey,
                autovalidateMode: model.autoValidate
                    ? AutovalidateMode.onUserInteraction
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${LocaleKeys.views_bmi_calculator_bmi.tr()}: ${model.bmi.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${model.bmiDescription}",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _CustomTextFormFieldBMI(
                              controller: model.weightController,
                              label:
                                  LocaleKeys.views_bmi_calculator_weight.tr(),
                              suffix: LocaleKeys.views_bmi_calculator_kg.tr(),
                              validator: (String? weight) {
                                return validateWeight(weight!);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _CustomTextFormFieldBMI(
                              controller: model.heightController,
                              label:
                                  LocaleKeys.views_bmi_calculator_height.tr(),
                              suffix: LocaleKeys.views_bmi_calculator_cm.tr(),
                              validator: (String? height) {
                                return validateHeight(height!);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () async {
                          await model.calculateBMI();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: KColors.orange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            LocaleKeys.views_bmi_calculator_calculate.tr(),
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CustomTextFormFieldBMI extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String suffix;
  final String? Function(String?)? validator;

  const _CustomTextFormFieldBMI({
    Key? key,
    required this.controller,
    required this.label,
    required this.suffix,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: label,
        suffixText: suffix,
      ),
      inputFormatters: <TextInputFormatter>[
        /// this regular expression allows only
        /// two decimal places and digits.
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d+\.?\d{0,2}'),
        ),
      ],
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
      ),
      validator: validator,
    );
  }
}
