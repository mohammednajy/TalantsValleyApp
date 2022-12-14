import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanlants_valley_application/data/controller/user_management_controller/transfers_controller.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/transfers_screens/transfer_bank_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/transfers_screens/transfer_cash_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/user_details_screen.dart';
import 'package:provider/provider.dart';

class TransfersScreen extends StatefulWidget {
  const TransfersScreen({super.key});

  @override
  State<TransfersScreen> createState() => _TransfersScreenState();
}

class _TransfersScreenState extends State<TransfersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
      appBar: CustomAppBarWithBack(
        title: 'Transfers',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
              height: 50.h,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColor.lightgrey,
                  borderRadius: BorderRadius.circular(20.sp)),
              child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.sp),
                    color: Colors.white,
                  ),
                  tabs: [
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
                  children: [TransfersCashScreen(), TransfersBankScreen()]),
            )
          ],
        ),
      ),
    );
  }
}
