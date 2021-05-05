import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:steps_tracker/app/models/k_user.dart';
import 'package:steps_tracker/app/translations/locale_keys.g.dart';

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
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.views_leaderboard_leaderboard.tr(),
            ),
          ),
          body: SafeArea(
            child: FutureBuilder<List<KUser>?>(
              future: model.getLeaderboard(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<KUser>?> snapshot,
              ) {
                /// this means there is an error.
                if (snapshot.hasError) {
                  return Text(
                    LocaleKeys.views_home_unknown_error.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  );
                }

                /// this means there is data.
                if (snapshot.hasData) {
                  final List<KUser> usersList = snapshot.data!;

                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          LocaleKeys.views_leaderboard_top_50.tr(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: RefreshIndicator(
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
                                  "${user.firstName} ${user.lastName} ${model.currentUser!.id == user.id ? "(${LocaleKeys.views_leaderboard_you.tr()})" : ""}",
                                ),
                                trailing: Text(
                                  "${user.stepsCount}",
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
