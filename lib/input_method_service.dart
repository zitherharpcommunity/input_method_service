import 'input_method_service_platform_interface.dart';

class InputMethodService {
  static const channelName = 'dev.zitherharp.input_method_service';

  static const commitTextMethodName = '$channelName/commitText';
  
  Future<String?> getPlatformVersion() {
    return InputMethodServicePlatform.instance.getPlatformVersion();
  }

  Future<void> commitText() {
    return InputMethodServicePlatform.instance.commitText();
  }
}
