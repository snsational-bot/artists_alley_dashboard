import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:get/get.dart';
import 'constants.dart';

class Pages {
  Pages._();

  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      preventDuplicates: true,
      participatesInRootNavigator: true,
    ),
  ];
}
