import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:stacked/stacked.dart';

import 'package:steps_tracker/app/models/k_history_item.dart';
import 'package:steps_tracker/app/translations/locale_keys.g.dart';
import 'package:steps_tracker/app/utils/colors.dart';
import 'package:steps_tracker/app/utils/flash_helper.dart';

import 'history_view_model.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HistoryViewModel(),
      onModelReady: (HistoryViewModel model) async {
        await model.init(
          context: context,
        );
      },
      builder: (
        BuildContext context,
        HistoryViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.views_history_history.tr(),
            ),
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await model.getHistoryItems();
              },
              child: Column(
                children: <Widget>[
                  model.isBusy ? LinearProgressIndicator() : SizedBox.shrink(),
                  Expanded(
                    child: model.historyItems.isEmpty
                        ? Center(
                            child: Text(
                              LocaleKeys.views_history_no_history.tr(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: model.historyItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              final KHistoryItem historyItem =
                                  model.historyItems[index];

                              return ListTile(
                                leading:
                                    historyItem.rewardAtTimeOfTransaction ==
                                            null
                                        ? Icon(
                                            FontAwesomeIcons.coins,
                                            color: historyItem.isIncrease
                                                ? Colors.green
                                                : Colors.red,
                                          )
                                        : Image.network(
                                            historyItem
                                                .rewardAtTimeOfTransaction
                                                .images[0],
                                          ),
                                title: Text(
                                  historyItem.rewardAtTimeOfTransaction == null
                                      ? LocaleKeys
                                          .views_history_reward_null_title
                                          .tr(
                                          namedArgs: {
                                            "sign":
                                                "${historyItem.isIncrease ? "+" : "-"}",
                                            "amount": "${historyItem.amount}",
                                          },
                                        )
                                      : LocaleKeys
                                          .views_history_reward_nonull_title
                                          .tr(
                                          namedArgs: {
                                            "sign":
                                                "${historyItem.isIncrease ? "+" : "-"}",
                                            "amount": "${historyItem.amount}",
                                            "rewardName":
                                                "${historyItem.rewardAtTimeOfTransaction.name}",
                                            "rewardVendor":
                                                "${historyItem.rewardAtTimeOfTransaction.vendor}",
                                          },
                                        ),
                                  style: TextStyle(
                                    color: historyItem.isIncrease
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                subtitle: Text(
                                  intl.DateFormat("hh:mm a - dd MMM, yyyy")
                                      .format(
                                    historyItem.createdAt.toDate(),
                                  ),
                                ),
                                onTap: () {
                                  if (historyItem.rewardAtTimeOfTransaction ==
                                      null) return;

                                  FlashHelper.simpleDialog(
                                    context,
                                    title: LocaleKeys.views_history_coupon_code
                                        .tr(),
                                    message: LocaleKeys
                                        .views_history_your_coupon_code_is
                                        .tr(
                                      namedArgs: {
                                        "couponCode":
                                            "${historyItem.rewardAtTimeOfTransaction.couponCode}",
                                      },
                                    ),
                                    negativeAction: (
                                      BuildContext context,
                                      FlashController controller,
                                      void Function(void Function()) setState,
                                    ) {
                                      return TextButton(
                                        style: TextButton.styleFrom(
                                          primary: KColors.orange,
                                        ),
                                        child: Text(
                                          LocaleKeys.views_history_ok.tr(),
                                          style: TextStyle(
                                            color: KColors.orange,
                                          ),
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
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
