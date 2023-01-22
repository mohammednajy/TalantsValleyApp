import 'package:get_it/get_it.dart';
import 'package:tanlants_valley_application/data/controller/user_management_controller/user_details_controller.dart';

final getIt = GetIt.instance;
void setUp() {
  getIt.registerLazySingleton<UserDetailsController>(
      () => UserDetailsController());
}
