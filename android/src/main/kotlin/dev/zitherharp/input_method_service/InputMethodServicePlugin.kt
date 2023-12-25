package dev.zitherharp.input_method_service

import android.inputmethodservice.InputMethodService
import android.view.View
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class InputMethodServicePlugin: InputMethodService(), FlutterPlugin, MethodCallHandler {
  private lateinit var flutterChannel: MethodChannel

  companion object {
    private const val METHOD_CHANNEL_NAME = "dev.zitherharp.input_method_service"
    private const val COMMIT_TEXT_METHOD = "$METHOD_CHANNEL_NAME/commit_text"
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    flutterChannel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL_NAME).apply {
      setMethodCallHandler(this@InputMethodServicePlugin)
      invokeMethod(COMMIT_TEXT_METHOD, "key")
    }
  }

  override fun onCreateInputView(): View {
    val engine = FlutterEngine(applicationContext)
    engine.dartExecutor.executeDartEntrypoint(
      DartExecutor.DartEntrypoint(
        FlutterInjector.instance().flutterLoader().findAppBundlePath(),
        "showCell"))

    val flutterViewEngine = InputMethodServiceEngine(engine)
      return flutterViewEngine.flutterView!!
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      COMMIT_TEXT_METHOD -> {
        val key = call.argument<String>("key")
        currentInputConnection.commitText(key, 1)
        result.success(null)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    //serviceEngine.detachFlutterView()
    flutterChannel.setMethodCallHandler(null)
  }
}
