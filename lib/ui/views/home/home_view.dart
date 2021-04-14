import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:steps_tracker/app/utils/colors.dart';

import './home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (HomeViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Welcome ${model.currentUser?.firstName ?? ""},",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                StreamBuilder<int>(
                  stream: model.getStepsCountStream(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<int> snapshot,
                  ) {
                    /// this means there is an error.
                    if (snapshot.hasError) {
                      return Text(
                        "Something went wrong!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      );
                    }

                    /// this means there is data.
                    if (snapshot.hasData) {
                      final int stepsCount = snapshot.data;
                      return Text(
                        "Steps: ${stepsCount ?? 0}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      );
                    }

                    /// this means data is loading.
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    await model.signOut();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: KColors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(
                    Icons.exit_to_app_rounded,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
