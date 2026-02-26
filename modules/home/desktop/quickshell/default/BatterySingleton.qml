pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    readonly property UPowerDevice display: UPower.displayDevice
    readonly property UPowerDevice battery: UPower.devices.values.find(d => d.type === UPowerDeviceType.Battery && d.isPresent) || null

    readonly property real percentage: display.percentage
    readonly property real health: battery ? battery.healthPercentage : 0
    readonly property string state: UPowerDeviceState.toString(display.state)
    readonly property bool isCharging: display.state === UPowerDeviceState.Charging || display.state === UPowerDeviceState.FullyCharged
    readonly property bool isCalculatingTime: {
        return (isCharging && display.timeToFull === 0 && display.state !== UPowerDeviceState.FullyCharged) || (!isCharging && display.timeToEmpty === 0);
    }
    readonly property string time: {
        if (isCharging) {
            DatetimeSingleton.formatSecs(display.timeToFull + 60);
        } else {
            DatetimeSingleton.formatSecs(display.timeToEmpty);
        }
    }
}
