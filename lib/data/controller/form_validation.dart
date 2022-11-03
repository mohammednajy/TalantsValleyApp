import 'package:flutter/material.dart';

class FormValidation extends ChangeNotifier {
  bool strongPasswordMessage = false;
  Map<String, String?> errorMessages = {
    "email": null,
    "password": null,
    "firsName": null,
    "lastName": null,
    "phoneNumber": null,
    "confirmPassword": null,
    "address1": null,
    "address2": null,
    "city": null,
    "country": null,
  };

  setErrorMessage(String key, String? value) {
    errorMessages[key] = value;
    notifyListeners();
  }
}
