import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:steps_tracker/app/models/k_reward.dart';
import 'package:steps_tracker/app/translations/locale_keys.g.dart';
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
              LocaleKeys.views_rewards_rewards.tr(),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "${LocaleKeys.views_rewards_health_points.tr()}: ${model.currentUser.healthPoints}",
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
                                  "${reward.price} ${LocaleKeys.views_rewards_health_points.tr()}",
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
                                      await model.refreshUserData();
                                      if (model.currentUser.healthPoints <
                                          reward.price) {
                                        FlashHelper.errorBar(
                                          context,
                                          message: LocaleKeys
                                              .views_rewards_not_enough_health_points
                                              .tr(),
                                        );
                                        return;
                                      }
                                      await FlashHelper.simpleDialog(
                                        context,
                                        title: LocaleKeys
                                            .views_rewards_are_you_sure
                                            .tr(),
                                        message: LocaleKeys
                                            .views_rewards_are_you_sure_spend
                                            .tr(
                                          namedArgs: {
                                            "rewardPrice": "${reward.price}",
                                            "rewardName": "${reward.name}",
                                          },
                                        ),
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
                                              LocaleKeys.views_rewards_cancel
                                                  .tr(),
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
                                              LocaleKeys.views_rewards_yes_sure
                                                  .tr(),
                                            ),
                                            onPressed: () async {
                                              await model.refreshUserData();

                                              if (model.currentUser
                                                      .healthPoints <
                                                  reward.price) {
                                                FlashHelper.errorBar(
                                                  context,
                                                  message: LocaleKeys
                                                      .views_rewards_not_enough_health_points
                                                      .tr(),
                                                );
                                                return;
                                              }

                                              await model.buyReward(
                                                reward: reward,
                                              );

                                              await model.refreshUserData();
                                              await model.getRewards();

                                              controller.dismiss();

                                              FlashHelper.simpleDialog(
                                                context,
                                                title: LocaleKeys
                                                    .views_rewards_congrats
                                                    .tr(),
                                                message: LocaleKeys
                                                    .views_rewards_congrats_coupon_code
                                                    .tr(
                                                  namedArgs: {
                                                    "rewardCouponCode":
                                                        "${reward.couponCode}",
                                                  },
                                                ),
                                                negativeAction: (
                                                  BuildContext context,
                                                  FlashController controller,
                                                  void Function(void Function())
                                                      setState,
                                                ) {
                                                  return TextButton(
                                                    child: Text(
                                                      LocaleKeys
                                                          .views_rewards_yes_sure
                                                          .tr(),
                                                    ),
                                                    onPressed: () {
                                                      controller.dismiss();
                                                    },
                                                  );
                                                },
                                              );
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
                                GestureDetector(
                                  onTap: () {
                                    if (reward.isSold &&
                                        reward.ownerId ==
                                            model.currentUser.id) {
                                      FlashHelper.simpleDialog(
                                        context,
                                        title: LocaleKeys.views_rewards_congrats
                                            .tr(),
                                        message: LocaleKeys
                                            .views_rewards_congrats_coupon_code
                                            .tr(
                                          namedArgs: {
                                            "rewardCouponCode":
                                                "${reward.couponCode}",
                                          },
                                        ),
                                        negativeAction: (
                                          BuildContext context,
                                          FlashController controller,
                                          void Function(void Function())
                                              setState,
                                        ) {
                                          return TextButton(
                                            child: Text(
                                              LocaleKeys.views_rewards_yes_sure
                                                  .tr(),
                                            ),
                                            onPressed: () {
                                              controller.dismiss();
                                            },
                                          );
                                        },
                                      );
                                      return;
                                    }
                                  },
                                  child: Card(
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
                                ),
                              if (reward.isSold)
                                Transform.rotate(
                                  angle: -pi / 8,
                                  child: Text(
                                    LocaleKeys.views_rewards_sold_out.tr(),
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
                              if (reward.isSold &&
                                  reward.ownerId == model.currentUser.id)
                                Positioned(
                                  bottom: 32.5,
                                  child: Text(
                                    LocaleKeys.views_rewards_view_coupon_code
                                        .tr(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.5, 0.5),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
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
