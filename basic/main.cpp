#include <QQuickView>
#include <QGuiApplication>
#include <QQmlEngine>
#include <QApplication>
#include <QQuickWidget>

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QApplication a(argc, argv);

    QQuickWidget *mainMapBoxWidget = new QQuickWidget();
    mainMapBoxWidget->setResizeMode(QQuickWidget::SizeRootObjectToView);
    mainMapBoxWidget->setSource(QUrl("qrc:/testKey.qml"));

    return a.exec();
}
