import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.WatchUi;

class GeleiaView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc as Dc) as Void {
    }

    function onUpdate(dc as Dc) as Void {
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

        // Corpo da geleia
        dc.setColor(0xFF88AA, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(centerX, centerY, 50);

        // Olhos
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(centerX - 20, centerY - 15, 10);
        dc.fillCircle(centerX + 20, centerY - 15, 10);

        // Pupilas
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(centerX - 20, centerY - 15, 5);
        dc.fillCircle(centerX + 20, centerY - 15, 5);

        // Brilho nos olhos
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(centerX - 23, centerY - 18, 2);
        dc.fillCircle(centerX + 17, centerY - 18, 2);

        // Boca sorrindo
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawArc(centerX, centerY + 10, 20, Graphics.ARC_CLOCKWISE, 190, 350);
    }

    function drawDate(dc as Dc) as Void {
        var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var dateStr = date.day.format("%d") + "/" + date.month.format("%d");
        var centerX = dc.getWidth() / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, dc.getHeight() - 30, Graphics.FONT_TINY,
                   dateStr, Graphics.TEXT_JUSTIFY_CENTER);
    }

    function drawBattery(dc as Dc) as Void {
        var battery = System.getSystemStats().battery;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawRectangle(dc.getWidth() - 30, 5, 20, 10);
        dc.fillRectangle(dc.getWidth() - 8, 8, 2, 4);

        var battWidth = (battery / 100.0 * 18).toNumber();
        dc.fillRectangle(dc.getWidth() - 28, 7, battWidth, 6);
    }

    function onPartialUpdate(dc as Dc) as Void {
        onUpdate(dc);
    }
}
