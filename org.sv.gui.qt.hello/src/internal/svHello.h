#ifndef SVHELLO_H
#define SVHELLO_H

#include <QmitkFunctionality.h>
#include <QString>

namespace Ui {
class svHello;
}

class svHello : public QmitkFunctionality
{
    Q_OBJECT

public:

    svHello();

    virtual ~svHello();

    virtual void CreateQtPartControl(QWidget *parent) override;

    static const QString EXTENSION_ID;

public slots:
    void getText();

    void printText();



public:

protected:

  QString hello_str;

  Ui::svHello *ui;

  QWidget *m_parent;

  QmitkStdMultiWidget* m_DisplayWidget;
};

#endif // SVHELLO_H
