import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

import 'package:steps_tracker/app/translations/locale_keys.g.dart';
import 'package:steps_tracker/app/utils/colors.dart';
import 'package:steps_tracker/ui/widgets/custom_ring.dart';

import './home_view_model.dart';

class HomeView extends StatelessWidget {
  final void Function()? onSeeLeaderboardPressed;

  const HomeView({
    Key? key,
    required this.onSeeLeaderboardPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (HomeViewModel model) async {
        await model.init(
          context: context,
        );
      },
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            KColors.orange,
                            KColors.orange,
                            Theme.of(context).scaffoldBackgroundColor,
                          ],
                          stops: [
                            0.0,
                            0.55,
                            1.0,
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 20,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                LocaleKeys.views_home_hello.tr(
                                  namedArgs: {
                                    "name":
                                        "${model.currentUser?.firstName ?? ""}",
                                  },
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
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
                                snapshot.error is PlatformException
                                    ? LocaleKeys.views_home_not_supported.tr()
                                    : LocaleKeys.views_home_unknown_error.tr(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              );
                            }

                            /// this means there is data.
                            if (snapshot.hasData) {
                              final int stepsCount = snapshot.data ?? 0;
                              final int stepsGoal = model.stepsGoal;

                              model.stepsCountLocal.add(stepsCount);

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: <Widget>[
                                              Stack(
                                                alignment: Alignment.center,
                                                children: <Widget>[
                                                  CustomRing(
                                                    diameter: 100,
                                                    strokeWidth: 5,
                                                    color: KColors.orange,
                                                    backgroundColor: KColors
                                                        .blue
                                                        .withOpacity(0.3),
                                                    value: (stepsGoal -
                                                            stepsCount) /
                                                        stepsGoal,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .shoePrints,
                                                        size: 18,
                                                        color: KColors.orange,
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      FittedBox(
                                                        child: Text(
                                                          "$stepsCount",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .certificate,
                                                      color: KColors.orange,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          "${model.stepsGoal - stepsCount}",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        Text(
                                                          LocaleKeys
                                                              .views_home_to_reach_your_goal
                                                              .tr(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Text(
                                                              "${LocaleKeys.views_home_total_steps.tr()}: ",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            Text(
                                                              "$stepsCount",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Text(
                                                              "${LocaleKeys.views_home_total_distance.tr()}: ",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            Text(
                                                              "${(stepsCount * 0.000762).toStringAsFixed(2)}",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            Text(
                                                              " ${LocaleKeys.views_home_km_kilotmeter.tr()}",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  onTap:
                                                      onSeeLeaderboardPressed,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      5,
                                                    ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .trophy,
                                                          size: 20,
                                                          color: KColors.blue,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: FittedBox(
                                                            fit: BoxFit.contain,
                                                            child: Text(
                                                              LocaleKeys
                                                                  .views_home_see_leaderboard
                                                                  .tr(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }

                            /// this means data is loading.
                            return CircularProgressIndicator();
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        LocaleKeys.views_home_tools.tr(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // bmi calculator
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.tachometerAlt,
                    color: KColors.orange,
                  ),
                  title: Text(
                    LocaleKeys.views_home_bmi_calculator.tr(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    await model.navigateToBmiCalculatorView();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
