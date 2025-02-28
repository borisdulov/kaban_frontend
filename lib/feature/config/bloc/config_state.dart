import 'package:kaban_frontend/feature/config/domain/env_type.dart';

abstract class ConfigState {}

final class ConfigStateSuccess extends ConfigState {
  final EnvType envType;

  ConfigStateSuccess({required this.envType});
}

final class ConfigStateLoading extends ConfigState {}

final class ConfigStateFailed extends ConfigState {}
