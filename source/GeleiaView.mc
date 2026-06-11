using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.WatchUi;

class GeleiaView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc as Dc) as Void {
        // Carregar layouts XML se necessário
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onUpdate(dc as Dc) as Void {
        try {
            var clockTime = System.getClockTime();
            var currentHour = clockTime.hour;
            var currentMinute = clockTime.min;

            // Fundo preto
            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
            dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

            drawClock(dc, currentHour, currentMinute);
            drawGelatin(dc);
            drawDate(dc);
            drawBattery(dc);
        } catch (e) {
            System.println("Error in onUpdate: " + e.getErrorMessage());
        }
    }

    function drawClock(dc as Dc, currentHour as Number, currentMinute as Number) as Void {
        var centerX = dc.getWidth() / 2;
        var hourFormatted = currentHour.format("%02d");
        var minuteFormatted = currentMinute.format("%02d");

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, 30, Graphics.FONT_MEDIUM,
                   hourFormatted + ":" + minuteFormatted,
                   Graphics.TEXT_JUSTIFY_CENTER);
    }

    function drawGelatin(dc as Dc) as Void {
        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() / 2;

        // Corpo da geleia (rosa/magenta)
        dc.setColor(0xFF88AA, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(centerX, centerY, 50);

        // Olhos (branco)
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(centerX - 20, centerY - 15, 10);
        dc.fillCircle(centerX + 20, centerY - 15, 10);

        // Pupilas (preto)
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(centerX - 20, centerY - 15, 5);
        dc.fillCircle(centerX + 20, centerY - 15, 5);

        // Brilho nos olhos (destaque branco)
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(centerX - 23, centerY - 18, 2);
        dc.fillCircle(centerX + 17, centerY - 18, 2);

        // Boca sorrindo (arco branco)
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawArc(centerX, centerY + 10, 20, Graphics.ARC_CLOCKWISE, 190, 350);
    }

    function drawDate(dc as Dc) as Void {
        try {
            var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
            var dateStr = date.day.format("%d") + "/" + date.month.format("%d");
            var centerX = dc.getWidth() / 2;

            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(centerX, dc.getHeight() - 30, Graphics.FONT_TINY,
                       dateStr, Graphics.TEXT_JUSTIFY_CENTER);
        } catch (e) {
            System.println("Error in drawDate: " + e.getErrorMessage());
        }
    }

    function drawBattery(dc as Dc) as Void {
        try {
            var battery = System.getSystemStats().battery;
            
            // Validar nível da bateria
            if (battery == null) {
                battery = 0;
            }

            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            
            // Borda da bateria
            dc.drawRectangle(dc.getWidth() - 30, 5, 20, 10);
            
            // Terminal da bateria
            dc.fillRectangle(dc.getWidth() - 8, 8, 2, 4);

            // Preenchimento da bateria
            var battWidth = ((battery / 100.0) * 18).toNumber();
            if (battWidth > 18) { battWidth = 18; } // Limitar ao máximo
            if (battWidth > 0) {
                dc.fillRectangle(dc.getWidth() - 28, 7, battWidth, 6);
            }
        } catch (e) {
            System.println("Error in drawBattery: " + e.getErrorMessage());
        }
    }

    function onPartialUpdate(dc as Dc) as Void {
        // Para watchfaces, geralmente chama onUpdate
        // Mas pode ser otimizado para atualizar apenas partes específicas
        onUpdate(dc);
    }
}
