import 'package:steps_tracker/app/global/custom_base_view_model.dart';

class MainViewModel extends CustomBaseViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void setCurrentIndex(int newValue) {
    _currentIndex = newValue;
    notifyListeners();
  }
}
