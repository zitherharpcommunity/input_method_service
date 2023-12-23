import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'input_method_service.dart';

final class InputMethodWidget extends StatefulWidget {
  const InputMethodWidget({super.key, required this.child});

  final Widget child;

  @override
  State<InputMethodWidget> createState() => _InputMethodWidgetState();
}

class _InputMethodWidgetState extends State<InputMethodWidget>
    with WidgetsBindingObserver {
  AppLifecycleState? appLifecycleState;
  late final channel = const MethodChannel(InputMethodService.channelName);

  @override
  void initState() {
    channel.setMethodCallHandler((call) async {
      if (call.method == '${channel.name}/commit_text') {
        setState(() {
        });
      }
    });
    // Keep track of what the current platform lifecycle state is.
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      appLifecycleState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        channel.invokeMethod<void>('${channel.name}/commit_text');
      },
      child: widget.child,
    );
  }
}
