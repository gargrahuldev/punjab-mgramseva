import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mgramseva/model/userProfile/user_profile.dart';
import 'package:mgramseva/repository/user_profile_repo.dart';
import 'package:mgramseva/utils/custom_exception.dart';
import 'package:mgramseva/utils/error_logging.dart';
import 'package:mgramseva/utils/global_variables.dart';

class UserProfileProvider with ChangeNotifier {
  var streamController = StreamController.broadcast();
  var formKey = GlobalKey<FormState>();
  var autoValidation = false;

  dispose() {
    streamController.close();
    super.dispose();
  }

  Future<void> getUserProfileDetails(body, BuildContext context) async {
    try {
      var userResponse = await UserProfileRepository().getProfile(body);
      if (userResponse != null) {
        streamController.add(userResponse.user?.first);
      }
    }catch (e,s) {
      ErrorHandler().allExceptionsHandler(context, e, s);
      streamController.addError('error');
    }
  }

  void onChangeOfGender(String gender, User user) {
    user.gender = gender;
    notifyListeners();
  }
  void callNotfyer() {
    notifyListeners();
  }
}