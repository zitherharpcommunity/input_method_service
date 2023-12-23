// import 'package:flutter_test/flutter_test.dart';
// import 'package:input_method_service/input_method_service.dart';
// import 'package:input_method_service/input_method_service_platform_interface.dart';
// import 'package:input_method_service/input_method_service_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockInputMethodServicePlatform
//     with MockPlatformInterfaceMixin
//     implements InputMethodServicePlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final InputMethodServicePlatform initialPlatform = InputMethodServicePlatform.instance;

//   test('$MethodChannelInputMethodService is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelInputMethodService>());
//   });

//   test('getPlatformVersion', () async {
//     InputMethodService inputMethodServicePlugin = InputMethodService();
//     MockInputMethodServicePlatform fakePlatform = MockInputMethodServicePlatform();
//     InputMethodServicePlatform.instance = fakePlatform;

//     expect(await inputMethodServicePlugin.getPlatformVersion(), '42');
//   });
// }
