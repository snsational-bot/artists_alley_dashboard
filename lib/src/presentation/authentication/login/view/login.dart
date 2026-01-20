import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/presentation/authentication/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends CustomGetView<LoginViewController, LoginViewPresenter> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFF2E8), Color(0xFFFFD6B8)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Obx(
                  () => Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Form(
                        key: presenter.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Welcome back',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: CustomColors.primaryText,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Sign in to continue to Artists Alley.',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: const Color(0xFF6C5F52)),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: presenter.emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.alternate_email),
                                filled: true,
                                fillColor: Color(0xFFF8F4F1),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                final trimmed = value?.trim() ?? '';
                                if (trimmed.isEmpty) {
                                  return 'Email is required';
                                }
                                if (!trimmed.contains('@')) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: presenter.passwordController,
                              obscureText: !presenter.isPasswordVisible,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  onPressed:
                                      controller.togglePasswordVisibility,
                                  icon: Icon(
                                    presenter.isPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF8F4F1),
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                final trimmed = value ?? '';
                                if (trimmed.isEmpty) {
                                  return 'Password is required';
                                }
                                if (trimmed.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) => _submitLogin(),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Checkbox(
                                  value: presenter.isRememberMeChecked,
                                  onChanged: controller.onCheckRememberMe,
                                  activeColor: CustomColors.primary,
                                ),
                                const Text('Remember me'),
                                const Spacer(),
                                TextButton(
                                  onPressed: controller.goToRecoverPassword,
                                  child: const Text('Forgot password?'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: presenter.isLoading
                                    ? null
                                    : _submitLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColors.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: presenter.isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    : const Text('Sign in'),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Need access? Contact your administrator.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: const Color(0xFF6C5F52)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitLogin() {
    if (presenter.formKey.currentState?.validate() ?? false) {
      controller.onLogin();
    }
  }
}
