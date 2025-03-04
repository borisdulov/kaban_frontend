import 'package:kaban_frontend/core/domain/dependency.dart';

class DIContainer {
  final Map<Type, Dependency> _dependencies = {};

  DIContainer register<T extends Dependency>(T dependency) {
    _dependencies[T] = dependency;
    return this;
  }

  T resolve<T extends Dependency>() {
    final dependency = _dependencies[T] as T?;
    if (dependency == null) {
      throw Exception("Dependencyendency not found in DI Container: $T");
    }
    return dependency;
  }
}
