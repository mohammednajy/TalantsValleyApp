import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../router/router.dart';
import '../../../router/routes_name.dart';
import '../../../storage/sherd_perf.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 90.h,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Home',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
          ),
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.reorder,
                  color: Colors.black,
                  size: 25,
                ));
          }),
        ),
        drawer: Container(
          width: 200,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    SharedPrefController().clear();
                    AppRouter.goAndRemove(ScreenName.loginScreen);
                  },
                  child: const Text(
                    'log out',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
        // bottomNavigationBar: ,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Text(
                'Hello, ${SharedPrefController().getUser().userInfo.firstName.toString()}',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
              )
            ],
          ),
        ));
  }
}
