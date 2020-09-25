TEMPLATE = app
TARGET = basic
QT += qml quick quickwidgets
SOURCES += main.cpp
CONFIG += link_pkgconfig

# 使用静态插件
static {
    QT += svg
    QTPLUGIN += qtvirtualkeyboardplugin
}

disable-xcb {
    message("The disable-xcb option has been deprecated. Please use disable-desktop instead.")
    CONFIG += disable-desktop
}

disable-layouts {
    CONFIG += disable-layouts
}

target.path = $$[QT_INSTALL_EXAMPLES]/virtualkeyboard/basic
INSTALLS += target

RESOURCES += \
    demo.qrc

OTHER_FILES += \
    Basic.qml \
    content/TextField.qml \
