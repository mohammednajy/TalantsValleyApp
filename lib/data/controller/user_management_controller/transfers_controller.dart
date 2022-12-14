import 'package:flutter/cupertino.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';

class TransfersController with ChangeNotifier {
  TransferDropDownButtonModel? selectedStatus;

  List<TransferDropDownButtonModel> statusDDBList = [
    TransferDropDownButtonModel(color: AppColor.orange, status: 'Pending'),
    TransferDropDownButtonModel(color: AppColor.blueDark, status: 'Ready'),
    TransferDropDownButtonModel(color: AppColor.black, status: 'Complete'),
    TransferDropDownButtonModel(color: AppColor.red, status: 'Canceled'),
    TransferDropDownButtonModel(
        color: AppColor.orange, status: 'Pending Approval'),
  ];

  setSelectedStatus(TransferDropDownButtonModel? tm) {
    selectedStatus = tm;
    notifyListeners();
  }
}

class TransferDropDownButtonModel {
  String status;
  Color color;
  TransferDropDownButtonModel({
    required this.color,
    required this.status,
  });
}
