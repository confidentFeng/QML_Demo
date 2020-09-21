#ifndef CPPOBJECT_H
#define CPPOBJECT_H

#include <QObject>

// 需要派生自QObject
// 使用qmlRegisterType注册到QML中
class CppObject : public QObject
{
    Q_OBJECT

    // 属性：使用Q_PROPERTY注册属性，使之可以在QML中访问
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int year READ getYear WRITE setYear NOTIFY yearChanged)

public:
    explicit CppObject(QObject *parent = nullptr);

    // 给类属性添加访问方法--myName
    void setName(const QString &name);
    QString getName() const;
    // 给类属性添加访问方法--myYear
    void setYear(int year);
    int getYear() const;

    // 函数：通过Q_INVOKABLE宏标记的public函数可以在QML中访问
    Q_INVOKABLE void testFun(); // 功能为打印信息

signals:
    // 信号：可以直接在QML中访问信号
    void cppSignalA();//一个无参信号
    void cppSignalB(const QString &str,int value); // 一个带参数信号
    void nameChanged(const QString name);
    void yearChanged(int year);

public slots:
    // 槽函数：可以直接在QML中访问public槽函数
    void cppSlotA();//一个无参槽函数
    void cppSlotB(const QString &str,int value); // 一个带参数槽函数

private:
    // 类的属性
    QString myName;
    int myYear;
};

#endif // CPPOBJECT_H
