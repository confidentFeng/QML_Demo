#include "widget.h"
#include "ui_widget.h"

Widget::Widget(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::Widget)
{
    ui->setupUi(this);

    view = new QQuickView;
}

Widget::~Widget()
{
    delete ui;
}

void Widget::on_pushButton_clicked()
{
    //【1】使用QQuickView的C++代码加载QML文档，显示QML界面
    // 另外可以用QQmlComponent、QQuickWidget加载QML文档 【QQuickView不能用Window做根元素】
    view->setSource(QUrl("qrc:/main.qml"));
    view->show();

    /* 文档如是说：
    应该始终使用QObject::setProperty()、QQmlProperty
    或QMetaProperty::write()来改变QML的属性值，以确保QML引擎感知属性的变化。*/

    //【2】通过QObject设置属性值、获取属性值
    QObject *qmlObj = view->rootObject(); // 获取到qml根对象的指针
    //qmlObj->setProperty("height",300);
    QQmlProperty(qmlObj, "height").write(300);
    qDebug() << "Cpp get qml property height" << qmlObj->property("height");
    // 任何属性都可以通过C++访问
    qDebug() << "Cpp get qml property msg" << qmlObj->property("msg");

    //【3】通过QQuickItem设置属性值、获取属性值
    QQuickItem *item = qobject_cast<QQuickItem*>(qmlObj);
    item->setWidth(300);
    qDebug() << "Cpp get qml property width" << item->width();

    //【4】通过objectName访问加载的QML子对象
    // QObject::findChildren()可用于查找具有匹配objectName属性的子项
    QObject *qmlRect = qmlObj->findChild<QObject*>("rect");
    if(qmlRect) {
        qmlRect->setProperty("color", "red");
        qDebug() << "Cpp get rect color" << qmlRect->property("color");
    }

    //【5】调用QML方法
    QVariant val_return;  // 返回值
    QVariant val_arg = "GongJianBo";  // 参数值
    // Q_RETURN_ARG()和Q_Arg()参数必须制定为QVariant类型
    QMetaObject::invokeMethod(qmlObj,
                              "qml_method",
                              Q_RETURN_ARG(QVariant,val_return),
                              Q_ARG(QVariant,val_arg));
    qDebug()<<"QMetaObject::invokeMethod result"<<val_return; // qml函数中返回“ok”

    //【6】关联信号槽
    // 1.关联qml信号与cpp槽，如果信号参数为QML对象类型，信号用var参数类型，槽用QVariant类型接收
    QObject::connect(qmlObj, SIGNAL(qmlSendMsg(QString,QString)),
                     this, SLOT(cppRecvMsg(QString,QString)));
    // 2.关联cpp信号与qml槽
    // qml中js函数参数为var类型，信号也用QVariant类型
    QObject::connect(this, SIGNAL(cppSendMsg(QVariant,QVariant)),
                     qmlObj, SLOT(qmlRecvMsg(QVariant,QVariant)));
    // 此外，cpp信号也可以关联qml信号
}

void Widget::cppRecvMsg(const QString &arg1,const QString &arg2)
{
    qDebug() << "CppObject::cppRecvMsg" << arg1 << arg2;
    qDebug() << "emit cppSendMsg";
    emit cppSendMsg(arg1,arg2);
}
