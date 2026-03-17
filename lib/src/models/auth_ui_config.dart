import 'package:flutter/material.dart';

class AuthUiConfig {
  final Widget logo;
  final String title;
  final String titleApp;
  final String subtitle;
  final TextStyle? titleStyle;
  final Color backgroundColor;
  final bool showSocialLogins;
  final String loginButtonText;
  final Color loginButtonColor;
  final TextStyle? subtitleStyle;
  final TextStyle? titleAppStyle;
  final VoidCallback? onCreateAccount;

  AuthUiConfig({
    this.titleStyle,
    this.titleAppStyle,
    this.subtitleStyle,
    this.onCreateAccount,
    this.titleApp = "My App",
    this.title = "Welcome Back",
    this.showSocialLogins = true,
    this.loginButtonText = "Sign in",
    this.logo = const SizedBox.shrink(),
    this.loginButtonColor = Colors.red,
    this.backgroundColor = const Color.fromARGB(255, 35, 37, 36),
    this.subtitle = "Enter your credentials to access your account",
  });
}