#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include <QObject>
#include <QQuickView>
#include <QQuickItem>
#include <QMetaObject>
#include <QQmlProperty>
#include <QDebug>

namespace Ui {
class Widget;
}

class Widget : public QWidget
{
    Q_OBJECT

public:
    explicit Widget(QWidget *parent = nullptr);
    ~Widget();

signals:
    // 信号 --用来触发qml的函数
    // 注意参数为var类型，对应qml中js函数的参数类型
    void cppSendMsg(const QVariant &arg1,const QVariant &arg2);

public slots:
    // 槽函数 --用来接收qml的信号
    void cppRecvMsg(const QString &arg1,const QString &arg2);

private slots:
    void on_pushButton_clicked();

private:
    Ui::Widget *ui;

    QQuickView *view;
};

#endif // WIDGET_H
