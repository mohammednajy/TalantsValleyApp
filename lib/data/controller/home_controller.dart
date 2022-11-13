import 'package:flutter/cupertino.dart';
import 'package:tanlants_valley_application/data/controller/user_management_controller/user_management_controller.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/home_page.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/user_management_page.dart';
import 'package:provider/provider.dart';
import '../../utils/constant_utils.dart';

class HomeController extends ChangeNotifier {
  int selectPage = 0;

  setSelectedPage(int index) {
    selectPage = index;
    notifyListeners();
  }

  List<Widget> bnbIcon() {
    List<Widget> bnbItem = [
      Image.asset(
        AssetPath.homeIcon,
        color: selectPage == 0 ? const Color.fromARGB(255, 11, 72, 242) : null,
      ),
      Image.asset(
        AssetPath.cashIcon,
        color: selectPage == 1 ? const Color.fromARGB(255, 11, 72, 242) : null,
      ),
      Image.asset(
        AssetPath.invoiceIcon,
        color: selectPage == 2 ? const Color.fromARGB(255, 11, 72, 242) : null,
      ),
      Image.asset(
        AssetPath.analyticsIcon,
        color: selectPage == 3 ? const Color.fromARGB(255, 11, 72, 242) : null,
      ),
      Image.asset(
        AssetPath.userIcon,
        color: selectPage == 4 ? const Color.fromARGB(255, 11, 72, 242) : null,
      ),
    ];
    return bnbItem;
  }

  List<Widget> pages = [
    HomePage(),
    Center(child: Text('index 1')),
    Center(child: Text('index 2')),
    Center(child: Text('index 3')),
    UserManagementPage()
  ];
}
