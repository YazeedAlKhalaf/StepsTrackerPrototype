import 'dart:math';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:steps_tracker/app/models/k_reward.dart';
import 'package:steps_tracker/app/utils/colors.dart';
import 'package:steps_tracker/app/utils/flash_helper.dart';
import 'package:steps_tracker/ui/views/rewards/rewards_view_model.dart';

class RewardsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => RewardsViewModel(),
      onModelReady: (RewardsViewModel model) async {
        await model.init(
          context: context,
        );
      },
      builder: (
        BuildContext context,
        RewardsViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Rewards",
            ),
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Health Points: ${(model.currentUser.stepsCount / 100).floor()}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await model.getRewards();
                      await model.refreshUserData();
                    },
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: model.rewardList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final KReward reward = model.rewardList[index];
                        _buildRewardContainer() {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.network(
                                  reward.images[0],
                                  height: 75,
                                ),
                                FittedBox(
                                  child: Text(
                                    reward.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  ),
                                ),
                                Text(
                                  "${reward.price} health points",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () async {
                                      if ((model.currentUser.stepsCount / 100)
                                              .floor() <
                                          reward.price) {
                                        FlashHelper.errorBar(
                                          context,
                                          message:
                                              "You don't have enough health points!",
                                        );
                                        return;
                                      }
                                      await FlashHelper.simpleDialog(
                                        context,
                                        title: "Are you sure?",
                                        message:
                                            "Are you sure you want to spend ${reward.price} health points on ${reward.name}?",
                                        negativeAction: (
                                          BuildContext context,
                                          FlashController controller,
                                          void Function(void Function())
                                              setState,
                                        ) {
                                          return TextButton(
                                            style: TextButton.styleFrom(
                                              primary: Colors.red,
                                            ),
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                            onPressed: () {
                                              controller.dismiss();
                                            },
                                          );
                                        },
                                        positiveAction: (
                                          BuildContext context,
                                          FlashController controller,
                                          void Function(void Function())
                                              setState,
                                        ) {
                                          return TextButton(
                                            child: Text(
                                              'Yes, Sure!',
                                            ),
                                            onPressed: () {
                                              controller.dismiss();
                                              // TODO: do transaction and give user coupon code
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: _buildRewardContainer(),
                                    ),
                                  );
                                },
                              ),
                              if (reward.isSold)
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: KColors.blue.withOpacity(0.5),
                                  child: Opacity(
                                    opacity: 0,
                                    child: _buildRewardContainer(),
                                  ),
                                ),
                              if (reward.isSold)
                                Transform.rotate(
                                  angle: -pi / 8,
                                  child: Text(
                                    "Sold Out",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.5, 0.5),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
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
