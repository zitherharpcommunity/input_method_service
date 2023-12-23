import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'input_method_service_method_channel.dart';

abstract class InputMethodServicePlatform extends PlatformInterface {
  /// Constructs a InputMethodServicePlatform.
  InputMethodServicePlatform() : super(token: _token);

  static final Object _token = Object();

  static InputMethodServicePlatform _instance =
      MethodChannelInputMethodService();

  /// The default instance of [InputMethodServicePlatform] to use.
  ///
  /// Defaults to [MethodChannelInputMethodService].
  static InputMethodServicePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InputMethodServicePlatform] when
  /// they register themselves.
  static set instance(InputMethodServicePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion();

  Future<void> commitText();
}
