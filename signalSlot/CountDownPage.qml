import QtQuick 2.9
import QtQuick.Controls 2.3

Rectangle {
    id: countDownPage
    width: 240
    height: 160
    color: "#ffffff"
    radius: 8

    // 3.定义接收槽函数
    function recvName2Date(strName, strDate){
        console.log(strName + " " + strDate);
        textName.text = String("距离%1还有").arg(strName)
        textDate.text = strDate
    }

    // 设置子窗口
    Rectangle {
        id: subWindow
        width: 30
        height: 30
        visible: false
        color: "#000000"
        anchors.centerIn: parent
    }

    // 标题栏
    Rectangle {
        id: rectTitle
        width: parent.width
        height: 40
        color: "#498ff8"
        radius: 8
        anchors.left: parent.left

        // 标题文本
        Text {
            text: qsTr("倒数日")
            color: "#ffffff"
            font.pointSize: 20
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.verticalCenter: parent.verticalCenter
        }

        // 设置按钮
        Button {
            width: 32
            height: 32
            text: qsTr("设置")
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                var component = Qt.createComponent("CountSetPage.qml");
                if (component.status === Component.Ready) {
                    var object = component.createObject(iotMainPage, {x:100, y:50, width:400, height:320})
                    // 4.使用connect连接信号槽
                    object.clickBtnOk.connect(recvName2Date);
                }
            }
        }
    }
    // 填充标题栏"左下"和"右下"的"圆角缺口"
    Rectangle {
        width: parent.width
        height: 8
        color: "#498ff8"
        anchors.left: parent.left
        anchors.bottom: rectTitle.bottom
    }

    // 名称文本
    Text {
        id: textName
        text: qsTr("距离期末考试还有")
        color: "#808080"
        font.pointSize: 18
        anchors.top: rectTitle.bottom
        anchors.topMargin: 12
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // 日期文本
    Text {
        id: textDate
        text: qsTr("20")
        color: "#D9001B"
        font.pointSize: 28
        anchors.top: textName.bottom
        anchors.topMargin: 12
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // "天"文本
    Text {
        text: qsTr("天")
        color: "#000000"
        font.pointSize: 20
        x: 150
        y: 120
    }
}
