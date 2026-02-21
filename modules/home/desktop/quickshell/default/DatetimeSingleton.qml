pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property alias current: clock.date

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
