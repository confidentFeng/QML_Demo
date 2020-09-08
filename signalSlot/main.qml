import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    id: iotMainPage
    visible: true
    width: 600
    height: 400
    color: "#F2F2F2"
    title: qsTr("Hello World")

    // 倒数日页面
    CountDownPage {
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
