using Toybox.Application;
using Toybox.Lang;
using Toybox.WatchUi;

class GeleiaApp extends Application.AppBase {
    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() as Array<WatchUi.Views or WatchUi.InputDelegates>? {
        return [new GeleiaView()] as Array<WatchUi.Views or WatchUi.InputDelegates>;
    }
}
