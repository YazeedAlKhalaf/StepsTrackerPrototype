import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:steps_tracker/app/global/validators.dart';
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
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Edit Profile",
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
                                      model.pickedImage,
                                    )
                                  : model.currentUser.photoUrl != null
                                      ? NetworkImage(model.currentUser.photoUrl)
                                      : AssetImage(
                                          "assets/images/placeholder_person.jpg",
                                        ),
                              radius: 50,
                            ),
                            TextButton(
                              onPressed: () async {
                                final File image = await Utils.pickImage();

                                if (image != null) {
                                  model.setPickedImage(image);
                                }
                              },
                              style: TextButton.styleFrom(
                                primary: KColors.orange,
                              ),
                              child: Text(
                                "Change profile image",
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
                                    labelText: "First Name",
                                  ),
                                  validator: (String firstName) {
                                    return validateName(firstName, true);
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
                                    labelText: "Last Name",
                                  ),
                                  validator: (String lastName) {
                                    return validateName(lastName, false);
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
                              "Update Profile",
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
