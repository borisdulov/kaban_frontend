import 'package:kaban_frontend/core/domain/entity/dependency.dart';

class DIContainer {
  final Map<Type, Dependency> _dependencies = {};

  DIContainer put<T extends Dependency>(T dependency) {
    _dependencies[T] = dependency;
    return this;
  }

  T get<T extends Dependency>() {
    final dependency = _dependencies[T] as T?;
    if (dependency == null) {
      throw Exception("Dependency not found in DI Container: $T");
    }
    return dependency;
  }
}
