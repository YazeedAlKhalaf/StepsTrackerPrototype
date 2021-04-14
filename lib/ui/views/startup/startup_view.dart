import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './startup_view_model.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (StartupViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        StartupViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
