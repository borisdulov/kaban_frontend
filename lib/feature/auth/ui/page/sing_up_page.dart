import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/auth/ui/widget/sign_up_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const String name = 'Register';
  static const String path = '/auth/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpWidget(),
    );
  }
}
