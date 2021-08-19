import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mgramseva/model/userProfile/user_profile.dart';
import 'package:mgramseva/providers/user_edit_profile_provider.dart';
import 'package:mgramseva/providers/user_profile_provider.dart';
import 'package:mgramseva/screeens/ChangePassword/Changepassword.dart';
import 'package:mgramseva/utils/Constants/I18KeyConstants.dart';
import 'package:mgramseva/utils/Locilization/application_localizations.dart';
import 'package:mgramseva/utils/constants.dart';
import 'package:mgramseva/utils/loaders.dart';
import 'package:mgramseva/utils/validators/Validators.dart';
import 'package:mgramseva/widgets/BaseAppBar.dart';
import 'package:mgramseva/widgets/BottonButtonBar.dart';
import 'package:mgramseva/widgets/FormWrapper.dart';
import 'package:mgramseva/widgets/HomeBack.dart';
import 'package:mgramseva/widgets/RadioButtonFieldBuilder.dart';
import 'package:mgramseva/widgets/TextFieldBuilder.dart';
import 'package:provider/provider.dart';
import 'package:mgramseva/utils/notifyers.dart';
import 'package:mgramseva/providers/common_provider.dart';

class EditProfile extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) => afterViewBuild());
    super.initState();
  }

  afterViewBuild() {
    var commonProvider = Provider.of<CommonProvider>(context, listen: false);
    print(commonProvider.userDetails!.userRequest!.tenantId);
    Provider.of<UserProfileProvider>(context, listen: false)
      ..formKey = GlobalKey<FormState>()
      ..autoValidation = false
      ..getUserProfileDetails(query, context);
  }

  saveInputandedit(context, profileDetails, User profile) async {
    var userProvider = Provider.of<UserProfileProvider>(context, listen: false);

    if (userProvider.formKey.currentState!.validate()) {
      var editProfileProvider =
          Provider.of<UserEditProfileProvider>(context, listen: false);
      editProfileProvider
          .editUserProfileDetails({"user": profile.toJson()}, context);
    } else {
      userProvider.autoValidation = true;
      userProvider.callNotfyer();
    }
  }

  Widget _builduserView(User profileDetails) {
    return Container(
        child: FormWrapper(
      Column(
        children: [
          HomeBack(),
          Consumer<UserProfileProvider>(
            builder: (_, userProvider, child) => Form(
              autovalidateMode: userProvider.autoValidation
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              key: userProvider.formKey,
              child: Card(
                  child: Column(
                children: [
                  BuildTextField(
                    i18.common.NAME,
                    profileDetails.nameCtrl,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
                    ],
                    isRequired: true,
                  ),
                  BuildTextField(
                    i18.common.PHONE_NUMBER,
                    profileDetails.phoneNumberCtrl,
                    prefixText: '+91',
                    isRequired: true,
                    isDisabled: true,
                    readOnly: true,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
                    maxLength: 10,
                    validator: Validators.mobileNumberValidator,
                    textInputType: TextInputType.phone,
                  ),
                  RadioButtonFieldBuilder(
                    context,
                    i18.common.GENDER,
                    profileDetails.gender,
                    '',
                    '',
                    false,
                    Constants.GENDER,
                    (val) => userProvider.onChangeOfGender(val, profileDetails),
                  ),
                  BuildTextField(
                    i18.common.EMAIL,
                    profileDetails.emailIdCtrl,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(
                          RegExp("[a-zA-Z0-9@. ]"))
                    ],
                    message: 'Invalid email format, example@mail.com',
                    pattern:
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ChangePassword())),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 25, top: 10, bottom: 10, right: 25),
                        child: new Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ApplicationLocalizations.of(context)
                                  .translate(i18.password.CHANGE_PASSWORD),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ))),
                  ),
                  BottomButtonBar(
                    i18.common.SAVE,
                    () => saveInputandedit(
                        context, profileDetails.getText(), profileDetails),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              )),
            ),
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProfileProvider>(context, listen: false);

    return Scaffold(
      appBar: BaseAppBar(
        Text(i18.common.MGRAM_SEVA),
        AppBar(),
        <Widget>[Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            child: StreamBuilder(
                stream: userProvider.streamController.stream,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return _builduserView(snapshot.data);
                  } else if (snapshot.hasError) {
                    return Notifiers.networkErrorPage(
                        context,
                        () =>
                            userProvider.getUserProfileDetails(query, context));
                  } else {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Loaders.CircularLoader();
                      case ConnectionState.active:
                        return Loaders.CircularLoader();
                      default:
                        return Container();
                    }
                  }
                })),
      ),
    );
  }

  Map get query {
    var commonProvider = Provider.of<CommonProvider>(context, listen: false);

    return {
      "tenantId": commonProvider.userDetails!.userRequest!.tenantId,
      "id": [commonProvider.userDetails!.userRequest!.id],
      "mobileNumber": commonProvider.userDetails!.userRequest!.mobileNumber
    };
  }
}