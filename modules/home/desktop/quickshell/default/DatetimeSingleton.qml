pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property alias current: clock.date

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    function formatSecs(secs: int): string {
        if (secs === undefined || secs === null || secs <= 0)
            return "00:00";

        let hours = Math.floor(secs / 3600);
        let minutes = Math.floor((secs % 3600) / 60);
        return String(hours).padStart(2, '0') + ":" + String(minutes).padStart(2, '0');
    }
}
