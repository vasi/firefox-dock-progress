#include "DockProgress.h"


/* Implementation file */
NS_IMPL_ISUPPORTS1(DockProgress, IDockProgress)


static const double ProgressBarHeight = 3.0/16;
static const double ProgressBarHeightInIcon = 3.0/16;

DockProgress::DockProgress() : mHidden(true), mProgress(0.0)
{
}

DockProgress::~DockProgress()
{
  /* destructor code */
}

/* void SetHidden (); */
NS_IMETHODIMP DockProgress::SetHidden()
{
	mHidden = true;
	UpdateDockIcon();
    return NS_OK;
}

/* void SetProgress (in double percent); */
NS_IMETHODIMP DockProgress::SetProgress(double percent)
{
	mProgress = percent;
	mHidden = false;
	UpdateDockIcon();
    return NS_OK;
}

void DockProgress::UpdateDockIcon()
{
	NSImage *appIcon = [NSImage imageNamed: @"NSApplicationIcon"];
	NSImage *dockIcon = [appIcon copyWithZone: NULL];
	if (!mHidden) {
		[dockIcon lockFocus];
		DrawProgressBar(dockIcon, ProgressBarHeightInIcon, mProgress);
		[dockIcon unlockFocus];
	}
	[NSApp setApplicationIconImage: dockIcon];
}

void DockProgress::DrawProgressBar(NSImage *img, double height, double progress)
{
	NSSize s = [img size];
	NSRect bar = NSMakeRect(0, s.height * (height - ProgressBarHeight / 2),
		s.width, s.height * ProgressBarHeight); 
	
	[[NSColor whiteColor] set];
	[NSBezierPath fillRect: bar];
	
	NSRect done = bar;
	done.size.width *= progress / 100;
	[[NSColor blueColor] set];
	[NSBezierPath fillRect: done];
	
	[[NSColor blackColor] set];
	[NSBezierPath strokeRect: bar];
}
