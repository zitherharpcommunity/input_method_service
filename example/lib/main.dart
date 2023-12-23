import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:input_method_service/input_method_service.dart';

// /// This is on alternate entrypoint for this module to display Flutter UI in
// /// a (multi-)view integration scenario.
// // This is unfortunately in this file due to
// // https://github.com/flutter/flutter/issues/72630.
// @pragma("vm:entry-point")
// void showCell() {
//   runApp(
//     const InputMethodWidget(
//       child: FlutterLogo(),
//     ),
//   );
// }

void main() {
  // This call ensures the Flutter binding has been set up before creating the
  // MethodChannel-based model.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _inputMethodServicePlugin = InputMethodService();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _inputMethodServicePlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              const TextField(),
              ElevatedButton(
                onPressed: () {
                  _inputMethodServicePlugin.commitText();
                },
                child: const Text('Commit Text'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
