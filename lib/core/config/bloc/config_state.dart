import 'package:kaban_frontend/core/config/model/di_container.dart';
import 'package:kaban_frontend/core/domain/entity/env_type.dart';

enum ConfigStatus { loading, success }

class ConfigState {
  ConfigState({
    required this.container,
    required this.status,
    required this.envType,
    required this.useMocks,
  });

  final DIContainer container;
  final ConfigStatus status;
  final EnvType envType;
  final bool useMocks;

  ConfigState copyWith({
    DIContainer? container,
    ConfigStatus? status,
    EnvType? envType,
    bool? useMocks,
  }) {
    return ConfigState(
      container: container ?? this.container,
      status: status ?? this.status,
      envType: envType ?? this.envType,
      useMocks: useMocks ?? this.useMocks,
    );
  }
}
