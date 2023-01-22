import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tanlants_valley_application/data/controller/user_management_controller/user_details_controller.dart';
import 'package:tanlants_valley_application/data/models/transfers_model.dart';
import 'package:tanlants_valley_application/data/network/api/locator/serviceLocator.dart';
import 'package:tanlants_valley_application/data/network/api/user_management_api/transfer_api.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:provider/provider.dart';
import '../../../router/router.dart';
import '../../../router/routes_name.dart';
import '../../../utils/helper.dart';
import '../../models/transfer_dropdown_button_model.dart';
import 'package:get_it/get_it.dart';

class TransfersController with ChangeNotifier {
  TransferDropDownButtonModel? selectedStatus;
  List<TransferBankModel> transferBankList = [];
  List<TransferCashModel> transferCashList = [];
  String? branch;
  String? ledger;
  usrTransferCashBank(
      {required String token,
      required String id,
      required int initialPage}) async {
    Response response =
        await TransferApi.transferBankCash(token: token, id: id);
    if (response.statusCode == 200) {
      List data = response.data["data"];
      // print(data.length);
      if (data.isNotEmpty) {
        for (var e in data) {
          e.containsKey("office")
              ? transferCashList.add(TransferCashModel.fromJson(e))
              : transferBankList.add(TransferBankModel.fromJson(e));
        }
        notifyListeners();
      }
      AppRouter.goTo(ScreenName.transfersScreen, object: initialPage);
    }
  }

  addBankAccount({
    required String token,
    required String freelancerId,
    required String accountName,
    required String accountNumber,
    required String bankBranch,
    required String ledger,
  }) async {
    Response response = await TransferApi.addBankAccount(
        token: token,
        freelancerId: freelancerId,
        accountName: accountName,
        accountNumber: accountNumber,
        bankBranch: bankBranch,
        ledger: ledger);

    if (response.statusCode == 200) {
      print(response.data);
      getIt<UserDetailsController>()
          .refreshEditedUser(token: token, id: freelancerId);
      UtilsConfig.showSnackBarMessage(
          message: 'Edited Sucessfully', status: true);
      notifyListeners();
      AppRouter.back();
    }
  }

  clear() {
    transferBankList.clear();
    transferCashList.clear();
    notifyListeners();
  }

// transfer status for drop down button
  List<TransferDropDownButtonModel> statusDDBList = [
    TransferDropDownButtonModel(color: AppColor.orange, status: 'Pending'),
    TransferDropDownButtonModel(color: AppColor.blueDark, status: 'Ready'),
    TransferDropDownButtonModel(color: AppColor.black, status: 'Completed'),
    TransferDropDownButtonModel(color: AppColor.red, status: 'Canceled'),
  ];

  setSelectedStatus(TransferDropDownButtonModel? tm) {
    selectedStatus = tm;
    notifyListeners();
  }

  List<String> branchList = [
    "0446 - Naser",
    "0448 - Nussairat",
    "0451 - Main Branch",
    "0452 - Khan Younis",
    "0453 - Jabalia",
    "0454 - Rimal",
    "0454 - Rafah",
  ];

  List<String> ledgerList = [
    "3000 - Current",
    "3100 - Saving",
    "3102 - Saving For Every Citizen",
  ];

  onSelecteBranch(String? value) {
    branch = value;
    notifyListeners();
  }

  onSelecteLedger(String? value) {
    ledger = value;
    notifyListeners();
  }
}
