import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/auth/ui/page/sing_up_page.dart';
import 'package:kaban_frontend/feature/auth/ui/widget/auth_button_widget.dart';
import 'package:kaban_frontend/feature/auth/ui/widget/text_field_widget.dart';

class LogInWidget extends StatelessWidget {
  const LogInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
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
                SizedBox(height: AppSize.p16),
                Text('Log in', style: TextStyle(fontSize: 32)),
                SizedBox(height: AppSize.p8),
                Text(
                  'Continue work',
                  style: TextStyle(
                    color: context.colorScheme.onSurface.withOpacity(0.4),
                  ),
                ),
                SizedBox(height: AppSize.p48),
                TextFieldWidget(
                  text: 'E-mail',
                  icon: Icons.mail,
                  hintText: 'Enter your address...',
                ),
                SizedBox(height: AppSize.p12),
                TextFieldWidget(
                  text: 'Passsword',
                  icon: Icons.lock,
                  hintText: 'Create your password',
                  isPassword: true,
                ),
                SizedBox(height: AppSize.p20),
                AuthButtonWidget(text: 'Log In', onPressed: () {}),
                SizedBox(height: AppSize.p24),
                Text('Dont have an account?'),
                SizedBox(height: AppSize.p12),
                TextButton(
                  onPressed: () {
                    context.go(SignUpPage.path);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: context.colorScheme.onSurface,
                  ),
                  child: Text(
                    'Register for free',
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
