#ifndef _DOCK_PROGRESS_H_
#define _DOCK_PROGRESS_H_

#include "IDockProgress.h"

#define DOCK_PROGRESS_CONTRACTID "@vasi.dyndns.org/DockProgress/DockProgress;1"
#define DOCK_PROGRESS_CLASSNAME "Dock icon progress bar"
#define DOCK_PROGRESS_CID { 0xDBAB3747, 0xF5F0, 0x44ED, \
	{ 0xA6, 0x4F, 0xB3, 0x67, 0x59, 0x06, 0xAA, 0x2F } }

/* Header file */
class DockProgress : public IDockProgress
{
public:
  NS_DECL_ISUPPORTS
  NS_DECL_IDOCKPROGRESS

  DockProgress();

private:
  ~DockProgress();

protected:
  /* additional members */
};

#endif
