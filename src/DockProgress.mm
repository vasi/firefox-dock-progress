#import "DockProgress.h"
#include "DockProgressC.h"

#include "nsStringAPI.h"

/* Implementation file */
NS_IMPL_ISUPPORTS1(DockProgress, IDockProgress)

DockProgress::DockProgress() { }
DockProgress::~DockProgress() { }

/* void SetHidden (); */
NS_IMETHODIMP DockProgress::SetHidden()
{
	FDPSetHidden();
    return NS_OK;
}

/* void SetProgress (in double percent); */
NS_IMETHODIMP DockProgress::SetProgress(double percent)
{
	FDPSetProgress(percent);
	return NS_OK;
}

/* void SetGradientPath (in AUTF8String path); */
NS_IMETHODIMP DockProgress::SetGradientPath(const nsACString & path)
{
	FDPSetGradientPath(path.BeginReading());
	return NS_OK;
}

/* void SetStyle (in long style); */
NS_IMETHODIMP DockProgress::SetStyle(PRInt32 style)
{
	FDPSetStyle((FDPStyle)style); // Enum values must be identical!
    return NS_OK;
}
