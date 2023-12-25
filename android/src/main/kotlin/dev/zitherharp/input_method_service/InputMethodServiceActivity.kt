package dev.zitherharp.input_method_service

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor

open class InputMethodServiceActivity : FlutterActivity() {
    private lateinit var flutterViewEngine: InputMethodServiceEngine

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val engine = FlutterEngine(applicationContext)
//        engine.dartExecutor.executeDartEntrypoint(
//            DartExecutor.DartEntrypoint(
//                FlutterInjector.instance().flutterLoader().findAppBundlePath(),
//                "showCell"),)
        flutterViewEngine = InputMethodServiceEngine(engine)
//        // The activity and FlutterView have different lifecycles.
//        // Attach the activity right away but only start rendering when the
//        // view is also scrolled into the screen.
//        flutterViewEngine.attachToActivity(this)
//        flutterViewEngine?.dartExecutor?.executeDartEntrypoint(
//            DartExecutor.DartEntrypoint.createDefault()
//        )
    }

    override fun onDestroy() {
        super.onDestroy()
        flutterViewEngine.detachActivity()
    }

    // These below aren't used here in this demo but would be needed for Flutter plugins that may
    // consume these events.
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        flutterViewEngine.onRequestPermissionsResult(requestCode, permissions, grantResults)
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        flutterViewEngine.onActivityResult(requestCode, resultCode, data)
        super.onActivityResult(requestCode, resultCode, data)
    }

    override fun onUserLeaveHint() {
        flutterViewEngine.onUserLeaveHint()
        super.onUserLeaveHint()
    }
}