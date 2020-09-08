﻿import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Rectangle {
    width: 360
    height: 300
    color: "#EEEEEE"
    
    Component {
        id: headerView
        Item {
            width: parent.width
            height: 30
            RowLayout {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8

                Text { 
                    text: "Name"
                    font.bold: true
                    font.pixelSize: 20
                    Layout.preferredWidth: 120
                }

                Text {
                    text: "Cost"
                    font.bold: true;
                    font.pixelSize: 20
                    Layout.preferredWidth: 80
                }

                Text {
                    text: "Manufacturer"
                    font.bold: true;
                    font.pixelSize: 20
                    Layout.fillWidth: true
                }
            }            
        }
    }
    
    Component {
        id: footerView
        Item{
            id: footerRootItem
            width: parent.width
            height: 30
            property alias text: txt.text

            // 1.自定义信号
            signal clean()
            signal add()
            
            Text {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                id: txt
                font.italic: true
                color: "blue"
                verticalAlignment: Text.AlignVCenter
            }
            
            Button {
                id: clearAll
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: "Clear"
                onClicked: footerRootItem.clean()
            }            
            
            Button {
                id: addOne
                anchors.right: clearAll.left
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                text: "Add"
                onClicked: footerRootItem.add()
            }
        }
    }

    Component {
        id: phoneDelegate
        Item {
            id: wrapper
            width: parent.width
            height: 30
            
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    wrapper.ListView.view.currentIndex = index
                    mouse.accepted = true
                }
                
                onDoubleClicked: {
                    wrapper.ListView.view.model.remove(index)
                    mouse.accepted = true
                }
            }               
            
            RowLayout {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8

                Text { 
                    id: col1
                    text: name
                    color: wrapper.ListView.isCurrentItem ? "red" : "black"
                    font.pixelSize: wrapper.ListView.isCurrentItem ? 22 : 18
                    Layout.preferredWidth: 120
                }

                Text {
                    text: cost
                    color: wrapper.ListView.isCurrentItem ? "red" : "black"
                    font.pixelSize: wrapper.ListView.isCurrentItem ? 22 : 18
                    Layout.preferredWidth: 80
                }

                Text {
                    text: manufacturer
                    color: wrapper.ListView.isCurrentItem ? "red" : "black"
                    font.pixelSize: wrapper.ListView.isCurrentItem ? 22 : 18
                    Layout.fillWidth: true
                }
            }
        }
    }

    Component {
        id: phoneModel;
        ListModel {
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
    }
    
    ListView {
        id: listView
        anchors.fill: parent

        delegate: phoneDelegate
        model: phoneModel.createObject(listView)
        header: headerView
        footer: footerView
        focus: true
        highlight: Rectangle{
            color: "lightblue"
        }
        
        onCurrentIndexChanged: {
            if( listView.currentIndex >=0 ){
                var data = listView.model.get(listView.currentIndex)
                listView.footerItem.text = data.name + " , " + data.cost + " , " + data.manufacturer
            }else{
                listView.footerItem.text = ""
            }
        }
        
        // 2.槽函数：添加数据
        function addOne() {
            model.append(
                        {
                            "name": "MX3",
                            "cost": "1799",
                            "manufacturer": "MeiZu"
                        } 
            )
        }
        
        // 3.连接信号槽
        Component.onCompleted: {
            listView.footerItem.clean.connect(listView.model.clear)
            listView.footerItem.add.connect(listView.addOne)
        }
    }
}
