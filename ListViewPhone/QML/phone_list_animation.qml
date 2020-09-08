import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

Rectangle {
    width: 360
    height: 300
    color: "#EEEEEE"

    // 定义header
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
                    font.bold: true
                    font.pixelSize: 20
                    Layout.preferredWidth: 80
                }

                Text {
                    text: "Manufacturer"
                    font.bold: true
                    font.pixelSize: 20
                    Layout.fillWidth: true
                }
            }
        }
    }
    
    // 定义footer
    Component {
        id: footerView

        Item{
            id: footerRootItem
            width: parent.width
            height: 30

            // 自定义信号
            signal add()
            signal insert()
            signal moveUp()
            signal moveDown()
            
            // 新增按钮
            Button {
                id: addOne
                anchors.right: parent.right
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                text: "Add"
                onClicked: footerRootItem.add()
            }

            // 插入按钮
            Button {
                id: insertOne
                anchors.right: addOne.left
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                text: "Insert"
                onClicked: footerRootItem.insert()
            }

            // 下移按钮
            Button {
                id: moveDown;
                anchors.right: insertOne.left
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                text: "Down"
                onClicked: footerRootItem.moveDown()
            }

            // 上移按钮
            Button {
                id: moveUp;
                anchors.right: moveDown.left
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                text: "Up"
                onClicked: footerRootItem.moveUp()
            }
        }
    }

    // 定义model
    Component {
        id: phoneModel

        ListModel {
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
    
    // 定义delegate
    Component {
        id: phoneDelegate

        Item {
            id: wrapper
            width: parent.width
            height: 30
            
            // 双击删除
            MouseArea {
                id: delegateMouseArea
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
    
    // 定义ListView
    ListView {
        id: listView
        anchors.fill: parent
        interactive: false

        delegate: phoneDelegate
        model: phoneModel.createObject(listView)
        header: headerView
        footer: footerView
        focus: true
        highlight: Rectangle{
            color: "lightblue"
        }
        
        // 在ListView第一次实例化或者因Model变化而需要创建Item时应用
        populate: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1.0
                duration: 1000
            }
        }

        // add过渡动画（新增Item触发）
        add: Transition {
            ParallelAnimation{
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1.0
                    duration: 1000
                }
                NumberAnimation {
                    properties: "x,y"
                    from: 0
                    duration: 1000
                }
            }
        }
        
        // 用于指定通用的、由于Model变化导致Item被迫移位时的动画效果
        displaced: Transition {
            SpringAnimation {
                property: "y"
                spring: 3
                damping: 0.1
                epsilon: 0.25
            }
        }
        
        // remove过渡动画（移除Item触发）
        remove: Transition {
            SequentialAnimation{
                NumberAnimation {
                    properties: "y"
                    to: 0
                    duration: 600
                }            
                NumberAnimation {
                    property: "opacity"
                    to: 0
                    duration: 400
                }
            }
        }
        
        // move过渡动画（移动Item触发）
        move: Transition {
            NumberAnimation {
                property: "y"
                duration: 700
                easing.type: Easing.InQuart
            }
        }
        
        // 新增函数
        function addOne() {
            model.append(
                        {
                            "name": "MX3",
                            "cost": "1799",
                            "manufacturer": "MeiZu"
                        } 
            )
        }
        
        // 插入函数
        function insertOne() {
            model.insert( Math.round(Math.random() * model.count),
                        {
                            "name": "HTC One E8",
                            "cost": "2999",
                            "manufacturer": "HTC"
                        } 
            )
        }
        
        // 上移函数
        function moveUp() {
            if(currentIndex - 1 >= 0){
                model.move(currentIndex, currentIndex - 1, 1)
            }
        }

        // 下移函数
        function moveDown() {
            if(currentIndex + 1 < model.count){
                model.move(currentIndex, currentIndex + 1, 1)
            }
        }
        
        // 连接信号槽
        Component.onCompleted: {
            listView.footerItem.add.connect(listView.addOne)
            listView.footerItem.insert.connect(listView.insertOne)
            listView.footerItem.moveUp.connect(listView.moveUp)
            listView.footerItem.moveDown.connect(listView.moveDown)
        }      
    }
}
