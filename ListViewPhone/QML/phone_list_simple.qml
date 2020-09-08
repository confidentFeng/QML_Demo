import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Rectangle {
    width: 360
    height: 300
    color: "#EEEEEE"

    // 1.定义delegate，内嵌三个Text对象来展示Model定义的ListElement的三个role
    Component {
        id: phoneDelegate
        Item {
            id: wrapper
            width: parent.width
            height: 30
            
            // 实现了鼠标点选高亮的效果
            MouseArea {
                anchors.fill: parent;
                onClicked: wrapper.ListView.view.currentIndex = index
            }
            
            // 内嵌三个Text对象，水平布局
            RowLayout {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8

                Text { 
                    id: col1;
                    text: name;
                    // 是否是当前条目
                    color: wrapper.ListView.isCurrentItem ? "red" : "black"
                    font.pixelSize: wrapper.ListView.isCurrentItem ? 22 : 18
                    Layout.preferredWidth: 120
                }
                
                Text { 
                    text: cost; 
                    color: wrapper.ListView.isCurrentItem ? "red" : "black"
                    font.pixelSize: wrapper.ListView.isCurrentItem ? 22 : 18
                    Layout.preferredWidth: 80
                }
                
                Text { 
                    text: manufacturer; 
                    color: wrapper.ListView.isCurrentItem ? "red" : "black"
                    font.pixelSize: wrapper.ListView.isCurrentItem ? 22 : 18
                    Layout.fillWidth: true
                }
            }
        }
    } // phoneDelegate-END
    
    // 2.定义ListView
    ListView {
        id: listView
        anchors.fill: parent

        // 使用先前设置的delegate
        delegate: phoneDelegate
        
        // 3.ListModel专门定义列表数据的，它内部维护一个 ListElement 的列表。
        model: ListModel {
            id: phoneModel

            // 一个 ListElement 对象就代表一条数据
            ListElement{
                name: "iPhone 3GS"
                cost: "1000"
                manufacturer: "Apple"
            }
            ListElement{
                name: "iPhone 4"
                cost: "1800"
                manufacturer: "Apple"
            }            
            ListElement{
                name: "iPhone 4S"
                cost: "2300"
                manufacturer: "Apple"
            } 
            ListElement{
                name: "iPhone 5"
                cost: "4900"
                manufacturer: "Apple"
            }    
            ListElement{
                name: "B199"
                cost: "1590"
                manufacturer: "HuaWei"
            }  
            ListElement{
                name: "MI 2S"
                cost: "1999"
                manufacturer: "XiaoMi"
            }         
            ListElement{
                name: "GALAXY S5"
                cost: "4699"
                manufacturer: "Samsung"
            }                                                  
        }

        // 背景高亮
        focus: true
        highlight: Rectangle{
            color: "lightblue"
        }
    }
}
