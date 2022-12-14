import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../data/controller/user_management_controller/transfers_controller.dart';
import '../../../../../../utils/constant_utils.dart';

class TransfersCashScreen extends StatelessWidget {
  const TransfersCashScreen({
    Key? key,
  }) : super(key: key);

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
                      flex: 1,
                      child: Icon(
                        Icons.content_copy,
                        size: 35.sp,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('غزة - مكتب الدانا',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            Text(
                              '\$500 إيناس كمال موسى ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: TansferDDBWidget(),
                    )
                  ],
                ),
                itemCount: 10,
                separatorBuilder: (context, index) => Divider(
                  thickness: 2,
                  indent: 50.w,
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

class TansferDDBWidget extends StatelessWidget {
  const TansferDDBWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransfersController>(
        builder: (context, transferProvider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 45.h,
                  child: DropdownButtonFormField<TransferDropDownButtonModel>(
                      icon: Icon(
                        Icons.expand_more,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.zero,
                        fillColor: AppColor.lightgrey,
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                      ),
                      isExpanded: true,
                      menuMaxHeight: 150,
                      selectedItemBuilder: (context) {
                        return transferProvider.statusDDBList
                            .map((e) => FittedBox(
                                  child: Text(
                                    e.status,
                                    style: TextStyle(
                                        color: e.color,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                            .toList();
                      },
                      items: transferProvider.statusDDBList
                          .map((e) => DropdownMenuItem(
                                child: FittedBox(
                                  child: Text(
                                    e.status,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        transferProvider.setSelectedStatus(value);
                      }),
                ),
                addVerticalSpace(10),
                Text(
                  '17 Aug, 12:30 AM',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 11),
                ),
              ],
            ));
  }
}
