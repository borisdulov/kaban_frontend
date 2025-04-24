import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/auth/ui/widget/log_in_widget.dart';
import 'package:kaban_frontend/feature/auth/ui/widget/sign_up_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static const String name = 'Auth';
  static const String path = '/auth/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpWidget(),
      // body: LogInWidget(),
    );
  }
}
