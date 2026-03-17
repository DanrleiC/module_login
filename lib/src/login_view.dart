import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'models/auth_credentials.dart';
import 'models/auth_ui_config.dart';
import 'widgets/custom_input.dart';
import 'widgets/social_button.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.config.logo,
              const SizedBox(width: 3),
              Column(
                children: [
                  Text(
                    widget.config.titleApp,
                    style: widget.config.titleAppStyle ??
                        const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ],
          ),
    
          Container(
            constraints: const BoxConstraints(maxWidth: 450),
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            decoration: BoxDecoration(
              color: widget.config.backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.config.title,
                  style: widget.config.titleStyle ??
                      const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.config.subtitle,
                  style: widget.config.subtitleStyle ??
                      const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                ),
          
                const SizedBox(height: 32),
          
                if (widget.errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.errorMessage!,
                            style: const TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
          
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
          
                const SizedBox(height: 32),
          
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.config.loginButtonColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: widget.isLoading
                        ? null
                        : () => widget.onLogin(
                              AuthCredentials(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            ),
                    child: widget.isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            widget.config.loginButtonText,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
          
                if (widget.config.showSocialLogins) ...[
                  const SizedBox(height: 32),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: SocialButton(
                          icon: Icons.g_mobiledata_outlined,
                          label: 'Google',
                          onTap: () => widget.onSocialLogin?.call('google'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SocialButton(
                          icon: Icons.apple,
                          label: 'Apple',
                          onTap: () => widget.onSocialLogin?.call('apple'),
                        ),
                      ),
                    ],
                  ),
                ],
          
                const SizedBox(height: 32),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                      children: [
                        TextSpan(
                          text: "Sign up",
                          style: const TextStyle(
                            color: Color.fromRGBO(38, 201, 81, 1),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.config.onCreateAccount,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}