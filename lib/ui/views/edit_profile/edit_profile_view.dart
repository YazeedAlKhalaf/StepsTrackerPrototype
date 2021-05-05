import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:steps_tracker/app/global/validators.dart';
import 'package:steps_tracker/app/translations/locale_keys.g.dart';
import 'package:steps_tracker/app/utils/colors.dart';
import 'package:steps_tracker/app/utils/utils.dart';
import 'package:steps_tracker/ui/views/edit_profile/edit_profile_view_model.dart';

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EditProfileViewModel(),
      onModelReady: (EditProfileViewModel model) async {
        await model.init(
          context: context,
        );
      },
      builder: (
        BuildContext context,
        EditProfileViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.views_edit_profile_edit_profile.tr(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: model.editProfileFormKey,
                autovalidateMode: model.autoValidate
                    ? AutovalidateMode.onUserInteraction
                    : null,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        model.isBusy
                            ? LinearProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(KColors.blue),
                              )
                            : SizedBox.shrink(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: model.pickedImage != null
                                  ? FileImage(
                                      model.pickedImage!,
                                    )
                                  : (model.currentUser!.photoUrl != null
                                      ? NetworkImage(
                                          model.currentUser!.photoUrl!)
                                      : AssetImage(
                                          "assets/images/placeholder_person.jpg",
                                        )) as ImageProvider<Object>?,
                              radius: 50,
                            ),
                            TextButton(
                              onPressed: () async {
                                final File? image = await Utils.pickImage();

                                if (image != null) {
                                  model.setPickedImage(image);
                                }
                              },
                              style: TextButton.styleFrom(
                                primary: KColors.orange,
                              ),
                              child: Text(
                                LocaleKeys
                                    .views_edit_profile_change_profile_image
                                    .tr(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  controller: model.firstNameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: LocaleKeys
                                        .views_edit_profile_first_name
                                        .tr(),
                                  ),
                                  validator: (String? firstName) {
                                    return validateName(firstName!, true);
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: model.lastNameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: LocaleKeys
                                        .views_edit_profile_last_name
                                        .tr(),
                                  ),
                                  validator: (String? lastName) {
                                    return validateName(lastName!, false);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                            child: Text(
                              LocaleKeys.views_edit_profile_update_profile.tr(),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: KColors.orange,
                            ),
                            onPressed: () async {
                              await model.updateUser();
                            },
                          ),
                        ),
                      ],
                    ),
                    if (model.isBusy)
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  KColors.orange,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                model.progressText,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
