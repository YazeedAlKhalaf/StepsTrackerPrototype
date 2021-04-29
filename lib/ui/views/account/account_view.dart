import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

import 'package:steps_tracker/app/translations/locale_keys.g.dart';
import 'package:steps_tracker/app/utils/colors.dart';

import 'account_view_model.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
      viewModelBuilder: () => AccountViewModel(),
      builder: (
        BuildContext context,
        AccountViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 7.5,
                    ),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  model.currentUser?.photoUrl == null
                                      ? AssetImage(
                                          "assets/images/placeholder_person.jpg",
                                        )
                                      : NetworkImage(
                                          model.currentUser.photoUrl,
                                        ),
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  LocaleKeys.views_account_welcome.tr(
                                    namedArgs: {
                                      "name":
                                          "${model.currentUser?.firstName ?? ""}",
                                    },
                                  ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
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
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      LocaleKeys.views_account_sign_out.tr(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 7.5,
                    ),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                FontAwesomeIcons.userEdit,
                                color: KColors.orange,
                              ),
                              title: Text(
                                LocaleKeys.views_account_edit_profile.tr(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () async {
                                await model.navigateToEditProfileView();
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                FontAwesomeIcons.history,
                                color: KColors.orange,
                              ),
                              title: Text(
                                LocaleKeys.views_account_transaction_history
                                    .tr(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () async {
                                await model.navigateToHistoryView();
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                FontAwesomeIcons.cog,
                                color: KColors.orange,
                              ),
                              title: Text(
                                LocaleKeys.views_account_settings.tr(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () async {
                                await model.navigateToSettingsView();
                              },
                            ),
                          ],
                        ),
                      ),
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
