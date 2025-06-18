import 'package:kaban_frontend/core/domain/entity/dependency.dart';

class DIContainer {
  final Map<Type, Dependency> _deps = {};

  T put<T extends Dependency>(T dep) {
    _deps[T] = dep;
    return dep;
  }

  T get<T extends Dependency>() {
    final dep = _deps[T] as T?;
    if (dep == null) {
      throw Exception("Dependency not found in DI Container: $T");
    }
    return dep;
  }
}
