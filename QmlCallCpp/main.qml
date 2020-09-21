import QtQuick 2.9
import QtQuick.Window 2.9
// 引入我们注册的模块
import MyCppObject 1.0

Window {
    id: root
    visible: true
    width: 500
    height: 300
    title: qsTr("QML调用Cpp对象")
    color: "green"

    signal qmlSignalA
    signal qmlSignalB(string str, int value)

    //定义的函数可以作为槽函数
    function processB(str, value){
        console.log('qml function processB', str, value)
    }

    // 鼠标点击区域
    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: {
            if(mouse.button === Qt.LeftButton){
                console.log('----qml 点击左键：Cpp发射信号')
                // 1.修改属性会触发set函数，获取值会触发get函数
                cpp_obj.name = "gongjianbo"
                cpp_obj.year = 1992
                // 2.调用Q_INVOKABLE宏标记的函数
                cpp_obj.testFun()
                // 3.发射C++信号
                cpp_obj.cppSignalA()
                cpp_obj.cppSignalB("chenglong", 1995)
            }
            else{
                console.log('----qml 点击右键：QML发射信号')
                root.qmlSignalA()
                root.qmlSignalB('gongjianbo', 1992)
            }
        }
    }

    // 作为一个QML对象
    CppObject{
        id: cpp_obj
        //也可以像原生QML对象一样操作，增加属性之类的
        property int counts: 0

        onYearChanged: {
            counts++
            console.log('qml onYearChanged', counts)
        }
        onCountsChanged: {
            console.log('qml onCountsChanged', counts)
        }
    }

    // 关联信号与信号处理函数的方式同QML中的类型
    Component.onCompleted: {
        // 1. Cpp对象的信号关联到Qml的槽函数
        // cpp_obj.onCppSignalA.connect(function() {console.log('qml signalA process')})
        cpp_obj.onCppSignalA.connect(()=>console.log('qml signalA process')) // js的lambda
        cpp_obj.onCppSignalB.connect(processB)
        // 2. Qml对象的信号关联到Cpp的槽函数
        root.onQmlSignalA.connect(cpp_obj.cppSlotA)
        root.onQmlSignalB.connect(cpp_obj.cppSlotB)
    }
}
