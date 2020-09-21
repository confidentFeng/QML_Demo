#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "CppObject.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    // QML方式：qmlRegisterType注册C++类型至QML
    // 参数：qmlRegisterType<C++类型名> (import时模块名 主版本号 次版本号 QML中的类型名)
    qmlRegisterType<CppObject>("MyCppObject", 1, 0, "CppObject");

    QQmlApplicationEngine engine;

    // C++方式：也可以注册为qml全局对象
    //engine.rootContext()->setContextProperty("cppObj", new CppObject(qApp));

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
