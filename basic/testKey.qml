import QtQuick 2.10
import QtQuick.Window 2.3
import QtQuick.Controls 2.3
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1

Window {
    id: root
    visible: true
    width: 1000
    height: 600
    color: "#F6F6F6"

    // 使窗口强制获得焦点
    MouseArea {
        anchors.fill: parent
        onClicked: forceActiveFocus()
    }

    TextField {
        id: textUser
        placeholderText: "请输入用户名"
        font.family: "Microsoft YaHei"
        font.pixelSize: 28
        topPadding: 10
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.left: parent.left
        anchors.leftMargin: 40

        background: Rectangle {
            implicitWidth: 424
            implicitHeight: 50
            radius: 4
            border.color: parent.focus  ? "#498ff8" : "#C4DBFC"
        }

        // 当选择输入框的时候才显示键盘
        onPressed: {
            inputX = x
            inputY = y + height
            inputPanel.visible = true
        }
    }

    TextField {
        id: textPasswd
        placeholderText: "请输入密码"
        font.family: "Microsoft YaHei"
        font.pixelSize: 28
        topPadding: 10
        anchors.top: parent.top
        anchors.topMargin: 120
        anchors.left: parent.left
        anchors.leftMargin: 40

        background: Rectangle {
            implicitWidth: 424
            implicitHeight: 50
            radius: 4
            border.color: parent.focus  ? "#498ff8" : "#C4DBFC"
        }

        // 当选择输入框的时候才显示键盘
        onPressed: {
            inputX = x
            inputY = y + height
            inputPanel.visible = true
        }
    }

    property int inputX: 0 // 键盘x坐标(动态)
    property int inputY: root.height // 键盘y坐标(动态)

    // 嵌入式虚拟键盘
    InputPanel {
        id: inputPanel
        z: 99
        //更改x,y即可更改键盘位置
        x: textUser.x
        y: root.height
        //更改width即可更改键盘大小
        width: root.width - 100
        visible: false

        externalLanguageSwitchEnabled: false

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                // 将键盘顶部放在屏幕底部会使其隐藏起来
                x: inputX
                y: inputY
            }
        }

        Component.onCompleted: {
            //VirtualKeyboardSettings.locale = "eesti" // 复古键盘样式
            VirtualKeyboardSettings.wordCandidateList.alwaysVisible = true
            VirtualKeyboardSettings.activeLocales = "lang-zh_TW"
        }

        // 这种集成方式下点击隐藏键盘的按钮是没有效果的，只会改变active，因此我们自己处理一下
        onActiveChanged: {
            if(!active) { visible = false }
        }
    }

}
