TEMPLATE        = app
TARGET          = sqlbrowser

QT              += sql widgets
requires(qtConfig(tableview))

HEADERS         = browser.h connectionwidget.h qsqlconnectiondialog.h \
    parser.h
SOURCES         = main.cpp browser.cpp connectionwidget.cpp qsqlconnectiondialog.cpp \
    grammar.c \
    lexical.c \
    parser.c

FORMS           = browserwidget.ui qsqlconnectiondialog.ui
build_all:!build_pass {
    CONFIG -= build_all
    CONFIG += release
}

# install
target.path = $$[QT_INSTALL_EXAMPLES]/sql/sqlbrowser
INSTALLS += target
