#include "DockProgressC.h"

/**** Internal definitions ****/

#include <Cocoa/Cocoa.h>

static FDPStyle gFDPStyle = kFDPStyleBar;
static NSImage *gFDPGradient = NULL;

static const double kFDPProgressBarHeight = 6.0/32;
static const double kFDPProgressBarHeightInIcon = 8.0/32;

static void FDPUpdate(bool show, double progress);
static void FDPDrawBar(NSImage *icon, double progress);
static void FDPDrawFill(NSImage *icon, double progress);


/**** Implementation ****/

void FDPSetHidden(void) {
	FDPUpdate(false, 0);
}

void FDPSetProgress(double percent) {
	FDPUpdate(true, percent);
}

void FDPSetStyle(FDPStyle style) {
	gFDPStyle = style;
}

void FDPSetGradientPath(const char *path) {
	NSString *imgPath = [NSString stringWithUTF8String: path];
	gFDPGradient = [[NSImage alloc] initByReferencingFile: imgPath];
}

static void FDPUpdate(bool show, double progress) {
	NSImage *appIcon = [NSImage imageNamed: @"NSApplicationIcon"];
	NSImage *dockIcon = [appIcon copyWithZone: nil];
	if (show) {
		[dockIcon lockFocus];
		switch (gFDPStyle) {
			case kFDPStyleBar:
				FDPDrawBar(dockIcon, progress); break;
			case kFDPStyleFill:
				FDPDrawFill(dockIcon, progress); break;
		}
		[dockIcon unlockFocus];
	}
	// Use NSDockTile instead?
	[NSApp setApplicationIconImage: dockIcon];
}

static void FDPDrawBar(NSImage *icon, double progress) {
	double height = kFDPProgressBarHeightInIcon;
	NSSize s = [icon size];
	NSRect bar = NSMakeRect(0, s.height * (height - kFDPProgressBarHeight / 2),
		s.width - 1, s.height * kFDPProgressBarHeight);
	
	[[NSColor whiteColor] set];
	[NSBezierPath fillRect: bar];
	
	NSRect done = bar;
	done.size.width *= progress / 100;
	NSRect gradRect = NSZeroRect;
	gradRect.size = [gFDPGradient size];
	[gFDPGradient drawInRect: done fromRect: gradRect operation: NSCompositeCopy
		fraction: 1.0];
	
	[[NSColor blackColor] set];
	[NSBezierPath strokeRect: bar];
}

static void FDPDrawFill(NSImage *icon, double progress) {
	NSSize sz = [icon size];
	double h = sz.height * progress / 100;
	NSRect r = NSMakeRect(0, h, sz.width, sz.height - h);
	
	[[NSColor colorWithCalibratedWhite: 1.0 alpha: 0.7] set];
	[[NSGraphicsContext currentContext]
		setCompositingOperation: NSCompositeSourceAtop];
	[NSBezierPath fillRect: r];
}
