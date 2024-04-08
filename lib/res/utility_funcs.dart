import 'package:flutter_mosharkaty/classes/admin.dart';
import 'package:flutter_mosharkaty/classes/credentials.dart';
import 'package:flutter_mosharkaty/res/constants.dart';
import 'dart:math';

bool emptyField(String val) {
  return val.trim().isEmpty;
}

bool isAdmin(String email, String password) {
  if ((password.trim().toLowerCase().compareTo(Admin.adminDetails.password) !=
      0)) return false;
  // check emails
  if (email.trim().toLowerCase().compareTo(Admin.adminDetails.mohandseen) ==
      0) {
    Credentials.userCredentials.branch = branches[0];
    return true;
  } else if (email.trim().toLowerCase().compareTo(Admin.adminDetails.maadi) ==
      0) {
    Credentials.userCredentials.branch = branches[1];
    return true;
  } else if (email.trim().toLowerCase().compareTo(Admin.adminDetails.faisal) ==
      0) {
    Credentials.userCredentials.branch = branches[2];
    return true;
  } else if (email.trim().toLowerCase().compareTo(Admin.adminDetails.mnasr) ==
      0) {
    Credentials.userCredentials.branch = branches[3];
    return true;
  } else if (email
          .trim()
          .toLowerCase()
          .compareTo(Admin.adminDetails.msrelgdida) ==
      0) {
    Credentials.userCredentials.branch = branches[4];
    return true;
  } else if (email.trim().toLowerCase().compareTo(Admin.adminDetails.october) ==
      0) {
    Credentials.userCredentials.branch = branches[5];
    return true;
  } else if (email.trim().toLowerCase().compareTo(Admin.adminDetails.helwan) ==
      0) {
    Credentials.userCredentials.branch = branches[6];
    return true;
  } else if (email.trim().toLowerCase().compareTo(Admin.adminDetails.alex) ==
      0) {
    Credentials.userCredentials.branch = branches[7];
    return true;
  } else if (email
          .trim()
          .toLowerCase()
          .compareTo(Admin.adminDetails.mokattam) ==
      0) {
    Credentials.userCredentials.branch = branches[8];
    return true;
  } else if (email.trim().toLowerCase().compareTo(Admin.adminDetails.mrkzy) ==
      0) {
    Credentials.userCredentials.branch = branches[BRANCHES_COUNT];
    return true;
  } else {
    return false;
  }
}

String generateVolunteerCode(List<String> allCodes) {
  bool isDuplicate = false;
  do {
    // Generate a random 4-digit number
    int randomNumber = Random().nextInt(9000) + 1000;

    // Generate a random capital letter (ASCII code 65 to 90)
    String randomLetter = String.fromCharCode(Random().nextInt(26) + 65);

    // Concatenate the random number and letter
    String generatedCode = '$randomNumber$randomLetter';
    if (allCodes.contains(generatedCode)) {
      isDuplicate = true;
    } else {
      return generatedCode;
    }
  } while (isDuplicate);
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return "Email already used. Go to login page.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong email/password combination.";
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No user found with this email.";
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "User disabled.";
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
    case "ERROR_OPERATION_NOT_ALLOWED":
    case "operation-not-allowed":
      return "Server error, please try again later.";
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email address is invalid.";
    case 'weak-password':
      return "The password provided is too weak";
    default:
      return "Login failed. Please try again.";
  }
}
