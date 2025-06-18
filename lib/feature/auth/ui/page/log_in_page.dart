import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/feature/auth/ui/page/sing_up_page.dart';
import 'package:kaban_frontend/feature/auth/ui/widget/auth_widget.dart';
import 'package:kaban_frontend/feature/auth/ui/widget/text_field_widget.dart';
import 'package:kaban_frontend/feature/board/ui/page/settings_page.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  static const String name = 'Login';
  static const String path = '/auth/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthWidget(
        mode: AuthMode.login,
        onPressed: () => context.go(SettingsPage.path),
        onSwitchMode: () => context.go(SignUpPage.path),
        fields: [
          TextFieldWidget(
            text: 'E-mail',
            icon: Icons.mail,
            hintText: 'Enter your address...',
          ),
          SizedBox(height: AppSize.p12),
          TextFieldWidget(
            text: 'Password',
            icon: Icons.lock,
            hintText: 'Enter your password...',
            isPassword: true,
          ),
        ],
      ),
    );
  }
}
