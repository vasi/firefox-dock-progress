#include "DockProgress.h"

#include "stdio.h"

/* Implementation file */
NS_IMPL_ISUPPORTS1(DockProgress, IDockProgress)

DockProgress::DockProgress()
{
  /* member initializers and constructor code */
}

DockProgress::~DockProgress()
{
  /* destructor code */
}

/* void SetHidden (); */
NS_IMETHODIMP DockProgress::SetHidden()
{
	// TODO
    return NS_OK;
}

/* void SetProgress (in double percent); */
NS_IMETHODIMP DockProgress::SetProgress(double percent)
{
	// TODO
	printf("DockProgress XPCOM workage!");
	
    return NS_OK;
}
