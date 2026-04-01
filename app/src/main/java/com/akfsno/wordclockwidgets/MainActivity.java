package com.akfsno.wordclockwidgets;

import android.app.Activity;
import android.app.AlertDialog;
import android.appwidget.AppWidgetManager;
import android.content.ComponentName;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        CrashLogger.init(this);
        setContentView(R.layout.activity_main);

        TextView title = findViewById(R.id.title_text);
        title.setText("Word Clock Widgets");

        Button addWidgetButton = findViewById(R.id.add_widget_button);
        addWidgetButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                AppWidgetManager appWidgetManager = AppWidgetManager.getInstance(MainActivity.this);
                int[] widgetIds = appWidgetManager.getAppWidgetIds(new ComponentName(MainActivity.this, WordClockWidgetProvider.class));
                if (widgetIds.length == 0) {
                    widgetIds = appWidgetManager.getAppWidgetIds(new ComponentName(MainActivity.this, LargeWordClockWidgetProvider.class));
                }

                if (widgetIds.length > 0) {
                    showStyleSelectionDialog(widgetIds[0]);
                } else {
                    Toast.makeText(MainActivity.this, "Сначала добавьте виджет на главный экран", Toast.LENGTH_LONG).show();
                }
            }
        });

        // Кнопка обновления убрана по заданию: управление через сохранение/применение внутри конструктора

    }

    private void showStyleSelectionDialog(int appWidgetId) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Выберите стиль настройки");
        builder.setMessage("Как вы хотите настроить виджет?");
        builder.setPositiveButton("Базовый стиль", (dialog, which) -> {
            Intent intent = new Intent(MainActivity.this, BasicStyleActivity.class);
            intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId);
            startActivity(intent);
        });
        builder.setNegativeButton("Конструктор", (dialog, which) -> {
            Intent intent = new Intent(MainActivity.this, WidgetConfigureActivity.class);
            intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId);
            startActivity(intent);
        });
        builder.setNeutralButton("Отмена", (dialog, which) -> dialog.dismiss());
        builder.show();
    }
}