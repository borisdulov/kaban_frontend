import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/board/ui/widget/settings_widget.dart';
import 'package:kaban_frontend/feature/user/data/model/user_mock_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String name = 'Settings';
  static const String path = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(AppSize.p12),
          child: Text('Settings', style: context.textTheme.titleLarge),
        ),
        toolbarHeight: 64,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: context.colorScheme.onSurface.withOpacity(0.2),
            height: 1,
          ),
        ),
      ),
      body: SettingsWidget(user: UserMockModel.random()),
    );
  }
}
