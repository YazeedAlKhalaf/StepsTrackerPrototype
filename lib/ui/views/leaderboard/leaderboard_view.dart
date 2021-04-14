import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:steps_tracker/app/models/k_user.dart';

import './leaderboard_view_model.dart';

class LeaderboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeaderboardViewModel>.reactive(
      viewModelBuilder: () => LeaderboardViewModel(),
      onModelReady: (LeaderboardViewModel model) async {
        await model.init(
          context: context,
        );
      },
      builder: (
        BuildContext context,
        LeaderboardViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Leaderboard",
            ),
          ),
          body: SafeArea(
            child: FutureBuilder<List<KUser>>(
              future: model.getLeaderboard(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<KUser>> snapshot,
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
                  final List<KUser> usersList = snapshot.data;

                  return RefreshIndicator(
                    onRefresh: () async {
                      model.notifyListeners();
                    },
                    child: ListView.builder(
                      itemCount: usersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final KUser user = usersList[index];

                        return ListTile(
                          leading: Text("${index + 1}."),
                          title: Text(
                            "${user.firstName} ${user.lastName} ${model.currentUser.id == user.id ? "(You)" : ""}",
                          ),
                          trailing: Text(
                            "${user.stepsCount}",
                          ),
                        );
                      },
                    ),
                  );
                }

                /// this means data is loading.
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
