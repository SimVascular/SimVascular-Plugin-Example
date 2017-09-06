#ifndef SVHELLOPLUGINACTIVATOR_H
#define SVHELLOPLUGINACTIVATOR_H

#include <ctkPluginActivator.h>

class svHelloPluginActivator :
        public QObject, public ctkPluginActivator
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org_sv_gui_qt_hello")
    Q_INTERFACES(ctkPluginActivator)

public:

//    static ctkPluginContext* GetContext();
//    static svPathPlanningPluginActivator* GetInstance();

    void start(ctkPluginContext* context) override;
    void stop(ctkPluginContext* context) override;

private:

};

#endif // SVHELLOPLUGINACTIVATOR_H
