enum Environment { DEV, PROD }

class Constants {
  static Map<String, dynamic>? _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.devConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get api {
    return _config![_Config.API];
  }
}

class _Config {
  static const API = "API";

  static Map<String, dynamic> devConstants = {
    API: "https://sunufoncier.herokuapp.com/api",
  };

  static Map<String, dynamic> prodConstants = {
    API: "https://sunufoncier.herokuapp.com/api",
  };
}
