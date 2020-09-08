import QtQuick 2.9
import QtQuick.Controls 2.4

Button {
    id: root_Button
    font.pointSize: 16 // 设置字体大小

    property color clr_font: "#ffffff"
    property color clr_backNormal: "#498ff8"
    property color clr_backPress: "#0066FF"
    property color clr_boardNormal: "#498ff8"
    property color clr_boardPress: "#0066FF"

    // 设置按钮文本
    contentItem: Text {
        id: text2
        text: root_Button.text
        font: root_Button.font
        opacity: enabled ? 1.0 : 0.3
        color: clr_font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    // 设置按钮背景
    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        color: root_Button.down ? clr_backPress : clr_backNormal
        border.color: root_Button.down ? clr_boardPress : clr_boardNormal
        border.width: 1
        radius: 6
    }
}
