import 'package:artists_alley_dashboard/src/presentation/presentation.dart';

class LoginViewControl implements LoginViewController {
  final LoginViewPresenter _presenter;

  LoginViewControl(this._presenter);

  @override
  void togglePasswordVisibility() {
    _presenter.isPasswordVisible = !_presenter.isPasswordVisible;
  }

  @override
  void onCheckRememberMe(bool? value) {
    _presenter.isRememberMeChecked = value ?? false;
  }

  @override
  void goToRecoverPassword() {
    // Implement navigation to recover password view
  }

  @override
  Future<void> onLogin() async {
    _presenter.isLoading = true;
    try {
      // Handle successful login (e.g., navigate to dashboard)
    } catch (e) {
      // Handle login error (e.g., show error message)
    } finally {
      _presenter.isLoading = false;
    }
  }
}
