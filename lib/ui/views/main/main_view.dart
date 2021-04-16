import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:steps_tracker/ui/views/account/account_view.dart';
import 'package:steps_tracker/ui/views/home/home_view.dart';
import 'package:steps_tracker/ui/views/leaderboard/leaderboard_view.dart';
import 'package:steps_tracker/ui/views/rewards/rewards_view.dart';

import './main_view_model.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (
        BuildContext context,
        MainViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: model.currentIndex,
              children: <Widget>[
                HomeView(
                  onSeeLeaderboardPressed: () {
                    model.setCurrentIndex(1);
                  },
                ),
                LeaderboardView(),
                RewardsView(),
                AccountView(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: model.currentIndex,
            onTap: (int newIndex) {
              model.setCurrentIndex(newIndex);
            },
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.home,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.trophy,
                ),
                label: "Leaderboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.award,
                ),
                label: "Rewards",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.userAlt,
                ),
                label: "Account",
              ),
            ],
          ),
        );
      },
    );
  }
}
