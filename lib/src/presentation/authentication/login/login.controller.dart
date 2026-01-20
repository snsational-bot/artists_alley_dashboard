abstract class LoginViewController {
  void togglePasswordVisibility();
  void onCheckRememberMe(bool? value);
  void goToRecoverPassword();
  Future<void> onLogin();
}
