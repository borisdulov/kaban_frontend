import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/feature/auth/bloc/auth_cubit.dart';
import 'package:kaban_frontend/feature/auth/ui/page/log_in_page.dart';
import 'package:kaban_frontend/feature/auth/ui/widget/auth_widget.dart';
import 'package:kaban_frontend/feature/auth/ui/widget/text_field_widget.dart';
import 'package:kaban_frontend/feature/board/ui/page/settings_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const String name = 'Register';
  static const String path = '/auth/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthWidget(
        mode: AuthMode.signup,
        onPressed: () {
          context.authBloc.register();
          context.go(SettingsPage.path);
        },
        onSwitchMode: () => context.go(LogInPage.path),
        fields: [
          TextFieldWidget(
            text: 'Username',
            icon: Icons.person,
            hintText: 'Enter your username...',
          ),
          SizedBox(height: AppSize.p12),
          TextFieldWidget(
            text: 'E-mail',
            icon: Icons.mail,
            hintText: 'Enter your address...',
          ),
          SizedBox(height: AppSize.p12),
          TextFieldWidget(
            text: 'Password',
            icon: Icons.lock,
            hintText: 'Create your password...',
            isPassword: true,
          ),
        ],
      ),
    );
  }
}
