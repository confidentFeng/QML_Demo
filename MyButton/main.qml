import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4

Window {
    visible: true
    width: 800
    height: 480
    title: qsTr("Hello World")

    Grid {
         columns : 3
         rows: 2
         spacing: 80
         anchors.centerIn: parent

         MyButton{
             id: btnCancle
             width: 100
             height: 50
             text: "取消"
             clr_font: "#498ff8"
             clr_backNormal: "#ffffff"
             clr_backPress: "#DEE4ED"
             clr_boardNormal: "#498ff8"
             clr_boardPress: "#498ff8"

         }

         MyButton{
             id: btnOk
             width: 100
             height: 50
             text: "确定"
         }

         ThreeIconButton {
             width: 150
             height: 60
             text: "OK"
         }

         MyIconButton {
             id: btn_camera
             img_src: "qrc:/image/camera.png";
             btn_txt: "相机"
             onClickedLeft: console.log(btn_txt + " Left button click")
         }

         MyIconButton {
             id: btn_video
             img_src: "qrc:/image/dianshiju.png";
             btn_txt: "视频"
             onClickedLeft: console.log(btn_txt + " Left Button click")
         }

         MyIconButton {
             id: btn_audio
             img_src: "qrc:/image/music.png";
             btn_txt: "音乐"
             onClickedLeft: console.log(btn_txt + " Left Button click")
         }
    }
}
