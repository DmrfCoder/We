package cn.edu.nuaa.dmrf.joooey.flutterwe

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.drawable.Drawable
import android.os.Bundle
import android.provider.MediaStore
import android.widget.Toast

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity() : FlutterActivity() {

    private val CHANNEL = "com.dmrf.flutterwe/imagePicker"
    val RESULT_LOAD_IMAGE = 0
    private var pendingResult: MethodChannel.Result? = null
    private var methodCall: MethodCall? = null
    private var fileUtils: FileUtils? = null

    private var activity: Activity? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        fileUtils = FileUtils()
        activity = this


        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            // TODO
            if (call.method == "pickImage") {

                this.methodCall = call
                this.pendingResult = result


                val pickImageIntent = Intent(Intent.ACTION_GET_CONTENT)
                pickImageIntent.type = "image/*"

                startActivityForResult(pickImageIntent, RESULT_LOAD_IMAGE)

//                intent = Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
//                startActivityForResult(intent, RESULT_LOAD_IMAGE);

            }

        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {


        super.onActivityResult(requestCode, resultCode, data)
        when (requestCode) {
            RESULT_LOAD_IMAGE -> {


                val path = fileUtils!!.getPathFromUri(activity, data!!.getData())
                handleVideoResult(path)

            }
        }
    }

    private fun handleVideoResult(path: String) {
        if (pendingResult != null) {
            pendingResult!!.success(path)
            methodCall = null
            pendingResult = null
        } else {
            throw IllegalStateException("Received video from picker that was not requested")
        }
    }


}
