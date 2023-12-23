import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:input_method_service/input_method_service.dart';

import 'input_method_service_platform_interface.dart';

/// An implementation of [InputMethodServicePlatform] that uses method channels.
class MethodChannelInputMethodService extends InputMethodServicePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(InputMethodService.channelName);

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> commitText() async {
    await methodChannel.invokeMethod<void>(InputMethodService.commitTextMethodName);
  }
}
