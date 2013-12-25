# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = tether

CONFIG += sailfishapp

SOURCES += src/tether.cpp \
    src/tethering.cpp

OTHER_FILES += qml/tether.qml \
    qml/cover/CoverPage.qml \
    rpm/tether.spec \
    rpm/tether.yaml \
    tether.desktop \
    qml/pages/WifiTether.qml \
    qml/tether.png

HEADERS += \
    src/tethering.h

