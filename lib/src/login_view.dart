import 'package:flutter/material.dart';
import 'package:module_login/src/widgets/social_button.dart';

import 'models/auth_credentials.dart';
import 'models/auth_ui_config.dart';
import 'widgets/custom_input.dart';

class LoginView extends StatefulWidget {
  final AuthUiConfig config;
  final Function(AuthCredentials) onLogin;
  final Function(String type)? onSocialLogin;
  final bool isLoading;
  final String? errorMessage;

  const LoginView({
    super.key,
    required this.config,
    required this.onLogin,
    this.onSocialLogin,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.config.logo != null) ...[
            widget.config.logo!,
            const SizedBox(height: 32),
          ],
          Text(widget.config.title, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(widget.config.subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
          const SizedBox(height: 40),
          
          CustomInput(
            label: "Email address",
            hint: "name@example.com",
            controller: _emailController,
          ),
          const SizedBox(height: 20),
          
          CustomInput(
            label: "Password",
            hint: "••••••••",
            controller: _passwordController,
            isPassword: true,
          ),
          
          const SizedBox(height: 24),
          
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: widget.isLoading ? null : () => widget.onLogin(
                AuthCredentials(email: _emailController.text, password: _passwordController.text)
              ),
              child: widget.isLoading ? const CircularProgressIndicator(color: Colors.white) : Text(widget.config.loginButtonText),
            ),
          ),
          
          if (widget.config.showSocialLogins) ...[
            const SizedBox(height: 32),
            const Row(children: [Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Or continue with", style: TextStyle(color: Colors.grey, fontSize: 12))), Expanded(child: Divider())]),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: SocialButton(icon: 'assets/google.png', label: 'Google', onTap: () => widget.onSocialLogin?.call('google'))),
                const SizedBox(width: 16),
                Expanded(child: SocialButton(icon: 'assets/apple.png', label: 'Apple', onTap: () => widget.onSocialLogin?.call('apple'))),
              ],
            ),
          ],
          
          const SizedBox(height: 32),
          TextButton(
            onPressed: widget.config.onCreateAccount,
            child: const Text.rich(TextSpan(text: "Don't have an account? ", style: TextStyle(color: Colors.grey), children: [TextSpan(text: "Create account", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))])),
          ),
        ],
      ),
    );
  }
}