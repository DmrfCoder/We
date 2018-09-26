package cn.edu.nuaa.dmrf.joooey.flutterwe

import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.drawable.Drawable
import android.os.Bundle
import android.provider.MediaStore
import android.widget.Toast

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity() : FlutterActivity() {

    private val CHANNEL = "com.dmrf.flutterwe/imagePicker"
    val RESULT_LOAD_IMAGE = 0


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)


        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            // TODO
            if (call.method == "pickImage") {

                intent = Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
                startActivityForResult(intent, RESULT_LOAD_IMAGE);

            }

        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {


        super.onActivityResult(requestCode, resultCode, data)
        when (requestCode) {
            RESULT_LOAD_IMAGE -> {
                val slesctedImage = data!!.data

                val filePathColumn = arrayOf(MediaStore.Images.Media.DATA)

                val cursor = contentResolver.query(slesctedImage,

                        filePathColumn, null, null, null)

                cursor.moveToFirst()

                val columnIndex = cursor.getColumnIndex(filePathColumn[0])

                val picturePath = cursor.getString(columnIndex)

                cursor.close()

                var drawable = Drawable.createFromPath(picturePath)//Drawable对象，就是选择的图片



            }
        }
    }


}
