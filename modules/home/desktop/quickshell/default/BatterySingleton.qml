pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    readonly property UPowerDevice device: UPower.displayDevice
    readonly property real percentage: device.percentage
    readonly property string state: UPowerDeviceState.toString(device.state)
}
