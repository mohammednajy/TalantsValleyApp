import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/transfers_screens/transfer_cash_screen.dart';
import '../../../../../../data/controller/user_management_controller/transfers_controller.dart';
import '../../../../../../utils/constant_utils.dart';

class TransfersBankScreen extends StatelessWidget {
  const TransfersBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Consumer<TransfersController>(
        builder: (context, transferProvider, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            transferProvider.transferBankList.isEmpty
                ? const SizedBox(
                    height: 100,
                    child: Text(
                      'No Bank',
                      style: TextStyle(fontSize: 25),
                    ))
                : Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transferProvider
                                      .transferBankList[index].bank["bankName"],
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                    transferProvider.transferBankList[index].id,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontSize: 11)),
                                Text(
                                    '\$${transferProvider.transferBankList[index].amount}'),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: TansferDDBWidget(
                                date: transferProvider
                                    .transferBankList[index].createdAt,
                                status: transferProvider
                                    .transferBankList[index].status,
                              ))
                        ],
                      ),
                      itemCount: transferProvider.transferBankList.length,
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 2,
                      ),
                    ),
                  ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.blue, fontSize: 20.sp),
              ),
              style: ButtonStyle(
                side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(color: AppColor.lightgrey)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                elevation: MaterialStateProperty.all(0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
