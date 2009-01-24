#import "DockProgress.h"

#include "nsStringAPI.h"

/* Implementation file */
NS_IMPL_ISUPPORTS1(DockProgress, IDockProgress)


static const double ProgressBarHeight = 6.0/32;
static const double ProgressBarHeightInIcon = 8.0/32;

DockProgress::DockProgress() : mHidden(true), mProgress(0.0), mGradient(nil)
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
	NSImage *dockIcon = [appIcon copyWithZone: nil];
	if (!mHidden) {
		[dockIcon lockFocus];
		FilledIcon(dockIcon);
		//ProgressBarIcon(dockIcon);
		[dockIcon unlockFocus];
	}
	[NSApp setApplicationIconImage: dockIcon];
}

void DockProgress::ProgressBarIcon(NSImage *img)
{
	DrawProgressBar(img, ProgressBarHeightInIcon, mProgress);
}

void DockProgress::FilledIcon(NSImage *img)
{
	NSSize sz = [img size];
	double h = sz.height * mProgress / 100;
	NSRect r = NSMakeRect(0, h, sz.width, sz.height - h);
	
	[[NSColor colorWithCalibratedWhite: 1.0 alpha: 0.7] set];
	[[NSGraphicsContext currentContext]
		setCompositingOperation: NSCompositeSourceAtop];
	[NSBezierPath fillRect: r];
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
	NSRect gradRect = NSZeroRect;
	gradRect.size = [mGradient size];
	[mGradient drawInRect: done fromRect: gradRect operation: NSCompositeCopy
		fraction: 1.0];
	
	[[NSColor blackColor] set];
	[NSBezierPath strokeRect: bar];
}

NSString *DockProgress::COMToCocoaString(const nsACString & str)
{
	return [NSString stringWithUTF8String: str.BeginReading()];
}

/* void SetGradientPath (in AUTF8String path); */
NS_IMETHODIMP DockProgress::SetGradientPath(const nsACString & path)
{
	NSString *cPath = COMToCocoaString(path);
	mGradient = [[NSImage alloc] initByReferencingFile: cPath];
	
	return NS_OK;
}
