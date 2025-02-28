enum EnvType {
  dev,
  prod;

  static EnvType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'dev':
      case 'development':
        return EnvType.dev;
      case 'prod':
      case 'production':
        return EnvType.prod;
      default:
        throw ArgumentError('Неизвестный EnvType: $value');
    }
  }

  static EnvType get fromEnv {
    const envValue = String.fromEnvironment('ENV_TYPE', defaultValue: 'prod');
    return fromString(envValue);
  }
}
