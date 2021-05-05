import 'package:flutter/cupertino.dart';
import 'package:steps_tracker/app/global/custom_base_view_model.dart';

class BmiCalculatorViewModel extends CustomBaseViewModel {
  final GlobalKey<FormState> bmiCalculatorFormKey = GlobalKey<FormState>();

  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  double _bmi = 0;
  double get bmi => _bmi;
  void setBmi(double newValue) {
    _bmi = newValue;
    notifyListeners();
  }

  String _bmiDescription = "";
  String get bmiDescription => _bmiDescription;
  void setBmiDescription(String newValue) {
    _bmiDescription = newValue;
    notifyListeners();
  }

  bool _autoValidate = false;
  bool get autoValidate => _autoValidate;
  void setAutoValidate(bool newValue) {
    _autoValidate = newValue;
    notifyListeners();
  }

  Future<void> calculateBMI() async {
    if (bmiCalculatorFormKey.currentState!.validate()) {
      setBusy(true);
      removeFocus();

      final double weightTrimmedDouble = double.parse(weightController.text);
      final double heightTrimmedDouble = double.parse(heightController.text);
      final double heightTrimmedDoubleInMeter = heightTrimmedDouble / 100;

      /// BMI formula:
      /// BMI = weight / (height^2)
      /// A BMI of 25.0 or more is overweight, while the healthy range is 18.5 to 24.9.

      final double _bmiTemp = weightTrimmedDouble /
          (heightTrimmedDoubleInMeter * heightTrimmedDoubleInMeter);

      setBmi(_bmiTemp);

      String? _bmiDescriptionTemp;
      if (_bmiTemp >= 25.0) {
        _bmiDescriptionTemp = "Overweight";
      }

      if (_bmiTemp < 18.5) {
        _bmiDescriptionTemp = "Below normal";
      }

      if (_bmiTemp >= 18.5 && _bmiTemp <= 24.9) {
        _bmiDescriptionTemp = "Normal";
      }

      setBmiDescription(_bmiDescriptionTemp!);
      setBusy(false);
      return;
    }

    setBmi(0);
    setBmiDescription("");
    setAutoValidate(true);
  }
}
