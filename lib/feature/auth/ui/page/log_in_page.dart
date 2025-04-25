import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/auth/ui/widget/log_in_widget.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  static const String name = 'Login';
  static const String path = '/auth/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LogInWidget());
  }
}
