#include "svHelloPluginActivator.h"
#include "svHello.h"

void svHelloPluginActivator::start(ctkPluginContext* context)
{

    BERRY_REGISTER_EXTENSION_CLASS(svHello, context)

}

void svHelloPluginActivator::stop(ctkPluginContext* context)
{

}
