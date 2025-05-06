import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/core/theme/ui/widget/theme_change_button.dart';
import 'package:kaban_frontend/feature/auth/ui/page/log_in_page.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_bloc.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.p8),
      child: Card(
        elevation: 0,
        color: context.colorScheme.surfaceContainerLow,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 640),
          child: Padding(
            padding: const EdgeInsets.all(AppSize.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account', style: context.textTheme.titleLarge),
                SizedBox(height: AppSize.p20),
                Row(
                  children: [
                    Text('Username'),
                    SizedBox(width: AppSize.p8),
                    Text(user.username),
                  ],
                ),
                SizedBox(height: AppSize.p16),
                Row(
                  children: [
                    Icon(Icons.keyboard, size: 24),
                    SizedBox(width: AppSize.p8),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(
                          context.colorScheme.onSurface,
                        ),
                      ),
                      child: Text('Change password'),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.p16),
                Row(
                  children: [
                    Icon(Icons.mail, size: 24),
                    SizedBox(width: AppSize.p8),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(
                          context.colorScheme.onSurface,
                        ),
                      ),
                      child: Text('Change e-mail'),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.p16),
                SizedBox(
                  width: 200,
                  child: TextButton(
                    onPressed: () {
                      context.go(LogInPage.path);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        context.colorScheme.error.withRed(255),
                      ),
                      foregroundColor: WidgetStateProperty.all(
                        context.colorScheme.surface,
                      ),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                          horizontal: AppSize.p16,
                          vertical: AppSize.p8,
                        ),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r16),
                        ),
                      ),
                    ),
                    child: Text('Logout'),
                  ),
                ),
                SizedBox(height: AppSize.p24),
                Container(
                  color: context.colorScheme.onSurface.withOpacity(0.2),
                  height: 1,
                ),
                SizedBox(height: AppSize.p24),
                Text('System', style: context.textTheme.titleLarge),
                SizedBox(height: AppSize.p20),
                Row(
                  children: [
                    Text('Theme'),
                    SizedBox(width: AppSize.p8),
                    ThemeChangeButton(),
                  ],
                ),
                Spacer(),
                SwitchListTile(
                  title: const Text('Use Mock Data'),
                  value: context.configBloc.state.useMocks,
                  onChanged: (value) => context.toggleMocks(value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
