import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanlants_valley_application/data/controller/auth_controller.dart';
import 'package:tanlants_valley_application/data/controller/user_management_controller.dart';
import 'package:tanlants_valley_application/storage/sherd_perf.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();

  static const List<String> filterText = [
    'Team members',
    'Bloched',
    'Oldest to newest',
    'All',
  ];
}

class _UserManagementPageState extends State<UserManagementPage> {
  int? selectedIndex;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context
        .read<UserManagementController>()
        .getUser(token: SharedPrefController().getUser().accessToken);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.h,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'User Management',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
        ),
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerRight,
          onPressed: () {
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
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Consumer<UserManagementController>(
            builder: (context, userProvider, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      userProvider.getUser(
                          token: SharedPrefController().getUser().accessToken,
                          search: value,
                          isBlocked: userProvider.filterValues[1]!,
                          isTeam: userProvider.filterValues[0]!,
                          sort: userProvider.filterValues[2]!
                              ? "+createdAt"
                              : "-createdAt");
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: const TextStyle(fontSize: 14),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: PopupMenuButton(
                          constraints: BoxConstraints(
                            minWidth: 100.w,
                            maxWidth: 170.w,
                          ),
                          icon: Icon(Icons.tune),
                          offset: Offset(0, 45),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context) => UserManagementPage
                              .filterText
                              .map((e) => PopupMenuItem(
                                    padding: EdgeInsets.zero,
                                    child: StatefulBuilder(
                                      builder: (context, setState) =>
                                          CheckboxListTile(
                                        value: userProvider.filterValues[
                                            UserManagementPage.filterText
                                                .indexOf(e)],
                                        onChanged: (value) {
                                          userProvider.changeFilterValues(
                                              index: UserManagementPage
                                                  .filterText
                                                  .indexOf(e));
                                          userProvider.getUser(
                                              token: SharedPrefController()
                                                  .getUser()
                                                  .accessToken,
                                              search: searchController.text,
                                              isBlocked:
                                                  userProvider.filterValues[1]!,
                                              isTeam:
                                                  userProvider.filterValues[0]!,
                                              sort:
                                                  userProvider.filterValues[2]!
                                                      ? "+createdAt"
                                                      : "-createdAt");

                                          setState(
                                            () {},
                                          );
                                        },
                                        title: Text(
                                          e,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                      ),
                                    ),
                                  ))
                              .toList())

                      
                      ),
                ),
                addVerticalSpace(10),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 243.h,
                  child: context.watch<AuthController>().cnacelResendLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: userProvider.users.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        userProvider.users[index].isBlocked
                                            ? AppColor.grey
                                            : const Color(0xFF8C8C8C),
                                    child: Text(
                                      userProvider.users[index].firstName[0],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${userProvider.users[index].firstName} ${userProvider.users[index].lastName}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: userProvider
                                                      .users[index].isBlocked
                                                  ? AppColor.grey
                                                  : Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      userProvider.users[index].role == 1
                                          ? const Icon(
                                              Icons.circle,
                                              size: 10,
                                              color: Colors.blue,
                                            )
                                          : const SizedBox(),
                                      userProvider.users[index].isBlocked
                                          ? const Icon(
                                              Icons.block_sharp,
                                              size: 15,
                                              color: Colors.black,
                                            )
                                          : const SizedBox(),
                                      addHorizontalSpace(5),
                                      selectedIndex == index
                                          ? SizedBox(
                                              height: 10,
                                              width: 10,
                                              child: context
                                                      .watch<AuthController>()
                                                      .loading
                                                  ? const CircularProgressIndicator(
                                                      color: Colors.blue,
                                                      strokeWidth: 2,
                                                    )
                                                  : null,
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                  subtitle: Text(
                                    userProvider.users[index].email,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: userProvider.users[index].isBlocked
                                          ? AppColor.grey
                                          : null,
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: 90.h,
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  '\$${userProvider.users[index].balance}.00',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: userProvider
                                                              .users[index]
                                                              .isBlocked
                                                          ? AppColor.grey
                                                          : null),
                                                ),
                                              ),
                                              Flexible(
                                                child: PopupMenuButton(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 25, left: 25),
                                                  iconSize: 20,
                                                  splashRadius: 30,
                                                  offset: Offset(0.w, 25.h),
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                        value: 1,
                                                        height: 28,
                                                        child: const Text(
                                                          'Set as Team',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            selectedIndex =
                                                                index;
                                                          });
                                                          userProvider.setAsTeam(
                                                              token: SharedPrefController()
                                                                  .getUser()
                                                                  .accessToken,
                                                              id: userProvider
                                                                  .users[index]
                                                                  .id
                                                                  .toString());
                                                        },
                                                      ),
                                                      PopupMenuItem(
                                                        value: 2,
                                                        height: 28,
                                                        child: Text(
                                                          userProvider
                                                                  .users[index]
                                                                  .isBlocked
                                                              ? 'Unblock'
                                                              : 'Block',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            selectedIndex =
                                                                index;
                                                          });
                                                          userProvider.blockUnBlock(
                                                              token: SharedPrefController()
                                                                  .getUser()
                                                                  .accessToken,
                                                              id: userProvider
                                                                  .users[index]
                                                                  .id
                                                                  .toString());
                                                        },
                                                      ),
                                                      PopupMenuItem(
                                                          value: 3,
                                                          height: 28,
                                                          child: const Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              selectedIndex =
                                                                  index;
                                                            });
                                                            userProvider.deleteUser(
                                                                token: SharedPrefController()
                                                                    .getUser()
                                                                    .accessToken,
                                                                id: userProvider
                                                                    .users[
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                          }),
                                                    ];
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        userProvider.users[index].role == 0 &&
                                                (userProvider.users[index]
                                                                .verifiedId[
                                                            "status"] ==
                                                        "not_uploaded" ||
                                                    userProvider.users[index]
                                                                .verificationAddress[
                                                            "status"] ==
                                                        "not_uploaded")
                                            ? const Text(
                                                'Not Verified',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.red,
                                                ),
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
