package com.akfsno.wordclockwidgets;

import android.content.Context;
import android.os.Environment;
import android.util.Log;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class CrashLogger {

    private static final String TAG = "CrashLogger";
    private static final String LOG_FILE_NAME = "word_clock_crash.log";

    public static void init(Context context) {
        Thread.setDefaultUncaughtExceptionHandler((thread, throwable) -> {
            logCrash(context, thread, throwable);
            // Call original handler
            Thread.getDefaultUncaughtExceptionHandler().uncaughtException(thread, throwable);
        });
    }

    private static void logCrash(Context context, Thread thread, Throwable throwable) {
        try {
            File logFile = new File(context.getExternalFilesDir(null), LOG_FILE_NAME);
            FileWriter writer = new FileWriter(logFile, true);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault());
            String timestamp = sdf.format(new Date());

            writer.write("Crash at " + timestamp + "\n");
            writer.write("Thread: " + thread.getName() + "\n");
            writer.write("Exception: " + throwable.getClass().getName() + "\n");
            writer.write("Message: " + throwable.getMessage() + "\n");
            writer.write("StackTrace:\n");
            for (StackTraceElement element : throwable.getStackTrace()) {
                writer.write("  " + element.toString() + "\n");
            }
            writer.write("\n");
            writer.close();

            Log.e(TAG, "Crash logged to " + logFile.getAbsolutePath());
        } catch (IOException e) {
            Log.e(TAG, "Failed to log crash", e);
        }
    }
}