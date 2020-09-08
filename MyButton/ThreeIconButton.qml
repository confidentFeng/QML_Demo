import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button
{
    id: root_Button
    property string nomerPic: "qrc:/image/ok.png"
    property string hoverPic: "qrc:/image/ok1.png"
    property string pressPic: "qrc:/image/ok2.png"

    style: ButtonStyle {
        background:Rectangle{
            implicitHeight: root_Button.height
            implicitWidth:  root_Button.width

            color: "transparent"  // 设置背景透明，否则会出现默认的白色背景

            BorderImage {
                anchors.fill: parent
                source: control.hovered ? (control.pressed ? pressPic : hoverPic) : nomerPic;
            }
        }
    }
}
