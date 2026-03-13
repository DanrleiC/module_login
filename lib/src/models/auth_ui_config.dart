import 'package:flutter/material.dart';

class AuthUiConfig {
  final String title;
  final String subtitle;
  final Widget? logo;
  final String loginButtonText;
  final bool showSocialLogins;
  final VoidCallback? onCreateAccount;

  AuthUiConfig({
    this.title = "Welcome Back",
    this.subtitle = "Please enter your details to sign in",
    this.logo,
    this.loginButtonText = "Sign in",
    this.showSocialLogins = true,
    this.onCreateAccount,
  });
}