#include "nsIGenericFactory.h"
#include "DockProgress.h"

NS_GENERIC_FACTORY_CONSTRUCTOR(DockProgress)

static nsModuleComponentInfo components[] =
{
    {
       DOCK_PROGRESS_CLASSNAME, 
       DOCK_PROGRESS_CID,
       DOCK_PROGRESS_CONTRACTID,
       DockProgressConstructor,
    }
};

NS_IMPL_NSGETMODULE("DockProgressModule", components) 

