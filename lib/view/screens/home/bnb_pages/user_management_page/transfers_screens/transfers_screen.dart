import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanlants_valley_application/data/controller/user_management_controller/transfers_controller.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/transfers_screens/transfer_bank_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/transfers_screens/transfer_cash_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/user_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/user_managment_shared/custom_appBar_back.dart';

class TransfersScreen extends StatefulWidget {
  const TransfersScreen({
    super.key,
    this.initialIndex = 0,
  });
  final int initialIndex;
  @override
  State<TransfersScreen> createState() => _TransfersScreenState();
}

class _TransfersScreenState extends State<TransfersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        initialIndex: widget.initialIndex, length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWithBack(
        title: 'Transfers',
        backWithClear: IconButton(
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerRight,
          onPressed: () {
            context.read<TransfersController>().clear();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
              height: 50.h,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColor.lightgrey,
                  borderRadius: BorderRadius.circular(20.sp)),
              child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.sp),
                    color: Colors.white,
                  ),
                  tabs: const [
                    Text(
                      'Cash',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Bank',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  ]),
            ),
            Expanded(
              child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: _tabController,
                  children: const [
                    TransfersCashScreen(),
                    TransfersBankScreen()
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
