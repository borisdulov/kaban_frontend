import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/auth/ui/widget/auth_button_widget.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({
    super.key,
    required this.mode,
    this.onPressed,
    this.onSwitchMode,
    required this.fields,
  });

  final AuthMode mode;
  final VoidCallback? onPressed;
  final VoidCallback? onSwitchMode;
  final List<Widget> fields;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(AppSize.p16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppAssets.logoKabanPng,
                  width: 128,
                  height: 128,
                  color: context.colorScheme.onSurface,
                ),
                Text('Kaban', style: context.textTheme.displayMedium),
                SizedBox(height: AppSize.p20),
                Text(
                  mode == AuthMode.login ? 'Log in' : 'Sign Up',
                  style: const TextStyle(fontSize: 32),
                ),
                SizedBox(height: AppSize.p8),
                Text(
                  mode == AuthMode.login
                      ? 'Continue work'
                      : 'Welcome to Kaban - Lets create account',
                  style: TextStyle(
                    color: context.colorScheme.onSurface.withOpacity(0.4),
                  ),
                ),
                SizedBox(height: AppSize.p40),
                ...fields,
                SizedBox(height: AppSize.p20),
                AuthButtonWidget(
                  text: mode == AuthMode.login ? 'Log In' : 'Create account',
                  onPressed: onPressed!,
                ),
                SizedBox(height: AppSize.p24),
                Text(
                  mode == AuthMode.login
                      ? 'Don\'t have an account?'
                      : 'Already registered?',
                ),
                SizedBox(height: AppSize.p12),
                TextButton(
                  onPressed: onSwitchMode,
                  style: TextButton.styleFrom(
                    foregroundColor: context.colorScheme.onSurface,
                  ),
                  child: Text(
                    mode == AuthMode.login
                        ? 'Register for free'
                        : 'Login to account',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: context.colorScheme.onSurface,
                      decorationThickness: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum AuthMode { login, signup }
