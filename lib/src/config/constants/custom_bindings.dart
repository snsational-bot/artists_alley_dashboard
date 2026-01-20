import 'package:artists_alley_dashboard/src/communication/communication.dart';
import 'package:artists_alley_dashboard/src/utils/watchers/maintenance_watcher.dart';
import 'package:get/get.dart';

import '../../presentation/authentication/authentication.dart';

class CustomBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MaintenanceWatcher(), permanent: true);

    // Login
    Get.lazyPut<LoginViewController>(
      () => LoginViewControl(Get.find<LoginViewPresenter>()),
      fenix: true,
    );
    Get.lazyPut<LoginViewPresenter>(() => LoginViewPresentation(), fenix: true);
  }
}
