import QtQuick 2.9
import QtQuick.Controls 2.3

Rectangle {
    id: countSetPage
    width: 400
    height: 320
    color: "#ffffff"
    radius: 8

    // 1.自定义信号，传递信息
    signal clickBtnOk(string strName, string strDate)

    // 标题栏
    Rectangle {
        id: rectTitle
        width: parent.width
        height: 40
        color: "#498ff8"
        anchors.left: parent.left
        radius: 8

        // 标题文本
        Text {
            text: qsTr("常态录播")
            color: "#ffffff"
            font.pointSize: 20
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.verticalCenter: parent.verticalCenter
        }

        // 关闭按钮
        Button {
            id: btnClose
            width: 32
            height: 32
            text: qsTr("设置")
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            onClicked: countSetPage.destroy()
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

    // 单行编辑框相关
    Column {
        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.top: rectTitle.bottom
        anchors.topMargin: 12
        spacing: 12

        Text {
            text: qsTr("名称")
            font.pointSize: 16
        }

        TextArea {
            id: textAreaName
            placeholderText: qsTr("期末考试")
            font.pointSize: 16

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                border.color: textAreaName.enabled ? "#21be2b" : "transparent"
            }
        }

        Text {
            text: qsTr("截止日期")
            font.pointSize: 16
        }

        TextArea {
            id: textAreaDate
            placeholderText: qsTr("2020-05-04")
            font.pointSize: 16

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                border.color: textAreaDate.enabled ? "#21be2b" : "transparent"
            }
        }
    }

    // 取消按钮
    Button {
        text: qsTr("取消")
        font.pointSize: 20
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        onClicked: countSetPage.destroy()
    }

    // 确定按钮
    Button {
        text: qsTr("确定")
        font.pointSize: 20

        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        onClicked: {
            if(textAreaName.text == "" && textAreaDate.text == "")
                console.log("编辑框必须有输入")

            // 2.发送信号(名称 + 剩余天数)
            countSetPage.clickBtnOk(textAreaName.text, textAreaDate.text)

            // 关闭该页面
            countSetPage.destroy()
        }
    }
}
