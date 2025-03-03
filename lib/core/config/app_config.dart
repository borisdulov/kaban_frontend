import 'package:kaban_frontend/core/domain/env_type.dart';

class AppConfig {
  final EnvType envType;

  const AppConfig._({required this.envType});

  static AppConfig? _instance;

  static AppConfig get I => _instance ??= AppConfig._(
        envType: EnvType.fromString(
          String.fromEnvironment('ENV_TYPE', defaultValue: 'dev'),
        ),
      );
}
