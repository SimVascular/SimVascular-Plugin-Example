#include "svHello.h"
#include "ui_svHello.h"

const QString svHello::EXTENSION_ID = "org.sv.views.hello";

svHello::svHello() :
  ui(new Ui::svHello)
{


}

svHello::~svHello(){
  delete ui;
}

void svHello::CreateQtPartControl(QWidget *parent){
  m_Parent=parent;
  ui->setupUi(parent);

  m_DisplayWidget=GetActiveStdMultiWidget();

  if(m_DisplayWidget==NULL)
  {
      parent->setEnabled(false);
      MITK_ERROR << "Plugin Hello Init Error: No QmitkStdMultiWidget!";
      return;
  }

  getText();
  connect(ui->helloPushButton, SIGNAL(clicked()), this, SLOT(printText()) );
  connect(ui->helloLineEdit, SIGNAL(editingFinished()), this, SLOT(getText()) );
}

void svHello::getText(){
  hello_str = ui->helloLineEdit->text();
}

void svHello::printText(){
  std::cout << hello_str << "\n";
}
