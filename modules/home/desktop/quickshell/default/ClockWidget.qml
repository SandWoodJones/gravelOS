import QtQuick

Text {
    text: Qt.formatDateTime(DatetimeSingleton.current, "hh:mm")
}
