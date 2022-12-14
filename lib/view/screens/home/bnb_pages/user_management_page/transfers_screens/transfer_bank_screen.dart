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
          children: [
            Expanded(
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
                          Text('NORHAN MOHAMMED KHUDAIR'),
                          Text('0452 1044664 001 3000 000'),
                          Text('\$500'),
                        ],
                      ),
                    ),
                    Expanded(flex: 5, child: TansferDDBWidget())
                  ],
                ),
                itemCount: 10,
                separatorBuilder: (context, index) => Divider(
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
                    BorderSide(color: AppColor.lightgrey)),
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
