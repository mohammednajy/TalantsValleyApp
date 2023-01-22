import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../../../../../../data/controller/user_management_controller/transfers_controller.dart';
import '../../../../../../data/models/transfer_dropdown_button_model.dart';
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            transferProvider.transferCashList.isEmpty
                ? const SizedBox(
                    height: 100,
                    child: Text(
                      'No Cash',
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
                            flex: 1,
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.content_copy,
                                  size: 35.sp,
                                )),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  transferProvider
                                      .transferCashList[index].office["name"],
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        '\$${transferProvider.transferCashList[index].amount} ',
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                    Flexible(
                                      child: Text(
                                        transferProvider.transferCashList[index]
                                            .recipientName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: TansferDDBWidget(
                                date: transferProvider
                                    .transferCashList[index].createdAt,
                                // index: index,
                                status: transferProvider
                                    .transferCashList[index].status),
                          )
                        ],
                      ),
                      itemCount: transferProvider.transferCashList.length,
                      separatorBuilder: (context, index) => Divider(
                        thickness: 2,
                        indent: 50.w,
                      ),
                    ),
                  ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(color: AppColor.lightgrey)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                elevation: MaterialStateProperty.all(0),
              ),
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.blue, fontSize: 20.sp),
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
    // required this.index,
    required this.status,
    required this.date,
  }) : super(key: key);
  // final int index;
  final String status;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Consumer<TransfersController>(
        builder: (context, transferProvider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 45.h,
                  child: DropdownButtonFormField<TransferDropDownButtonModel>(
                      icon: const Icon(
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
                      value: transferProvider.statusDDBList[
                          transferProvider.statusDDBList.indexWhere((element) =>
                              element.status.toLowerCase() ==
                              status.toLowerCase())],
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
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: FittedBox(
                                child: Text(
                                  e.status,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        transferProvider.setSelectedStatus(value);
                      }),
                ),
                addVerticalSpace(10),
                Text(
                  '${DateFormat.MMMd().format(
                    DateTime.parse(
                      date,
                    ),
                  )}, ${DateFormat.jm().format(
                    DateTime.parse(
                      date,
                    ),
                  )}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 11),
                ),
              ],
            ));
  }
}
