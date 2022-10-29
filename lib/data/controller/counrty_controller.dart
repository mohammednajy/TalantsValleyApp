import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../models/country_model.dart';

class CounteryController with ChangeNotifier {
  List<CounteryModel> result = [];
  CounteryModel? selectedPhoneNumber;
  String? selectedCounrty;
  countries() async {
    final String response =
        await rootBundle.loadString('assets/files/country.json');
    List<dynamic> jsonList = jsonDecode(response);
    for (var element in jsonList) {
      result.add(CounteryModel.fromJson(element));
    }
    notifyListeners();
  }

  setSelectedPhone(CounteryModel selectedValue) {
    selectedPhoneNumber = selectedValue;
    notifyListeners();
  }

  setSelectedCounrty(String? selectedValue) {
    selectedCounrty = selectedValue;
    notifyListeners();
  }

 
}
